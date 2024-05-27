if vim.g.vscode then
    vim.opt.clipboard:append("unnamedplus")

    vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last change" })
end
