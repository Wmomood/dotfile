#!/bin/bash

SAVE_DIR="$HOME/Pictures/Screenshots"
# mkdir -p "$SAVE_DIR"

hyprshot -t 3000 -m output -o "$SAVE_DIR"
