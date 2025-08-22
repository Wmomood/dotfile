export ZSH="$HOME/.oh-my-zsh"

# export BROWSER =zen
export EDITOR="helix"
export VISUAL="helix"
export BROWSER="zen-browser"



export ELECTRON_OZONE_PLATFORM_HINT=auto
# export QT_QPA_PLATFORM=wayland
# export QT_FONT_DPI=96

# export GTK_IM_MODULE=ibus
# export XMODLFLERS=im=ibus
# export QT_IM_MODULE=ibus


# unset GTK_IM_MODULE
# unset QT_IM_MODULE
# unset XMODIFIERS

# fcitx
# export XIM="fcitx"
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export INPUT_METHOD=fcitx
# export SDL_IM_MODULE=fcitx
# export GLFW_IM_MODULE=ibus

# disable in x11 (put it in hyprland conf)
# export XDG_CURRENT_DESKTOP=Hyprland
# export XDG_SESSION_TYPE=wayland


# chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
# code --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime

export FZF_DEFAULT_COMMAND='fd -t f --color=never --hidden'
export FZF_DEFAULT_OPTS="--style full --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '/home/momo/Scripts/fzf-preview.sh {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export FZF_TMUX=1
