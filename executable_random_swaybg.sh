#!/bin/bash

# Массив цветов
colors=(
  "#00008B"  # Темно-синий
  "#800000"  # Бордовый
  "#4B0082"  # Фиолетовый
  "#006400"  # Темно-зеленый
)

# Случайный выбор цвета
random_color=${colors[$RANDOM % ${#colors[@]}]}

# Установка фона через swaybg
swaybg --color "$random_color" --mode fill &
