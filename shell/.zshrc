#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
# bind '"\e[A":history-search-backward'
# bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=15000
SAVEHIST=15000
bindkey -v
# End of lines configured by zsh-newuser-install

export VISUAL='kitty /usr/bin/nvim'
export EDITOR=neovim
export PAGER=less
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"

# Zsh and starhip init
typeset -g AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=0
typeset -g ZSH_SYSTEM_CLIPBOARD_USE_WL_CLIPBOARD='true'
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
eval "$(starship init zsh)"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Clipboard fix
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | wl-copy -n
	zvm_exit_visual_mode
}
autoload -Uz compinit && compinit

# Clear terminal Ctrl+l
scroll-and-clear-screen() {
         printf '\n%.0s' {1..$LINES}
         zle clear-screen
     }
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

# SSH keys
eval $(keychain --eval --quiet id_rsa)

export PATH="$(yarn global bin):$PATH"

# because it's required for share_history.
setopt append_history

# import new commands from the history file also in other zsh-session
setopt inc_append_history
setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first

# Don't record an entry that was just recorded again.
setopt hist_ignore_dups

# Don't write duplicate entries in the history file.
setopt hist_save_no_dups
# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

source ~/.zaliases
