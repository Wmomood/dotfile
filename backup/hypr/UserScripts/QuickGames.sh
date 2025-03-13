#!/bin/bash

# Path to .desktop files
game_desktop_dir="$HOME/Desktop"

# Function to display available files
menu() {
  find "$game_desktop_dir" -maxdepth 1 -type f -exec basename {} \; | nl
}

# Main function to handle menu selection
main() {
  choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-compact.rasi | awk '{print $2}')

  if [ -n "$choice" ]; then
    file_path="$game_desktop_dir/$choice"
    if [ -f "$file_path" ]; then
      xdg-open "$file_path"
    fi
  fi
}

# Check if rofi is already running
if pidof rofi >/dev/null; then
  pkill rofi
fi
