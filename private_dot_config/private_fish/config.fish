#=============================================================================
# Title       : fish Shell
# Description : My Custom fish Shell Settings
# Author      : H.Y.
# LastUpdate  : 2021/05/16
# Since       : 2021/04/24
# Copyright   : © 2021 Digi-Angler
# License     : MIT License
# Version     : 1.0
#=============================================================================

#=============================================================================
# Personal Settings
#=============================================================================

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

# Neofetch を表示する
neofetch

# 起動時のメッセージを非表示にする
# set -U fish_greeting ""
function fish_greeting
    echo "Let's build something epic 🚀"
    echo The time is (set_color FF26AB; date +%T; set_color 721BF2) and this machine is called $hostname
end

# viモードを有効にする
set -U fish_key_bindings fish_vi_key_bindings

# プロンプトでフルパスを取得する
set -U fish_prompt_pwd_dir_length 0

# theme
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# nvim
# command -qv nvim && alias vim nvim
# set -gx EDITOR nvim

# cd した後に ls
function cd
    if test (count $argv) -eq 0
        cd $HOME
        return 0
    else if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    end
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = -
        if test "$__fish_cd_direction" = next
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    pwd
    ls -A
    return $status
end

# set theme via `starship`
set starship init fish | source



#=============================================================================
# Custom Keybindings
#=============================================================================

# # aliases
# alias ls "ls -p -G"
# alias la "ls -A"
# alias ll "ls -l"
# alias lla "ll -A"
# alias l "ls -CF"
# alias p "pwd"

# Directory
alias .1 "cd .."
alias .2 "cd ../.."
alias .3 "cd ../../.."
alias .4 "cd ../../../.."
alias .5 "cd ../../../../.."
alias cc "chezmoi cd"

# Git
alias g git
alias status "git status"
alias commit "git commit"
alias push "git push"
alias ghg "ghq get"
alias ghl "ghq list"
alias gad "git add ."
alias gcm "git commit -m "Initial commit""
alias gps "git push -u origin main"

# Shells
alias bl "brew list"
alias fl "fisher list"
alias al "asdf list"
alias nl "npm list"
alias yl "yarn list"

# Runtime
alias n npm
alias y yarn

# Docker
alias d docker
alias dc docker-compose

# Vim
alias v vim
alias nv nvim
alias t tmux
alias e emacs
alias emacs nvim
alias cdf "chezmoi diff"
alias cap "chezmoi apply"

## Open shell files
alias vz "v ~/.zshrc"
alias nz "nv ~/.zshrc"
alias cz "chezmoi edit ~/.zshrc"
alias vv "v ~/.vimrc"
alias nv "nv ~/.vimrc"
alias cv "chezmoi edit ~/.vimrc"
alias vt "v ~/.tmux.conf"
alias nt "nv ~/.tmux.conf"
alias ct "chezmoi edit ~/.tmux.conf"
alias vf "v ~/.config/fish/config.fish"
alias nf "nv ~/.config/fish/config.fish"
alias cf "chezmoi edit ~/.config/fish/config.fish"
alias vo "v ~/.config/fish/config-osx.fish"
alias no "nv ~/.config/fish/config-osx.fish"
alias co "chezmoi edit ~/.config/fish/config-osx.fish"
alias vw "v ~/.config/fish/config-windows.fish"
alias nw "nv ~/.config/fish/config-windows.fish"
alias cw "chezmoi edit ~/.config/fish/config-windows.fish"
alias vsi "v ~/.SpaceVim.d/init.toml"
alias nsi "nv ~/.SpaceVim.d/init.toml"
alias csi "chezmoi edit ~/.SpaceVim.d/init.toml"
alias vsm "v ~/.SpaceVim.d/autoload/myspacevim.vim"
alias nsm "nv ~/.SpaceVim.d/autoload/myspacevim.vim"
alias csm "chezmoi edit ~/.SpaceVim.d/autoload/myspacevim.vim"
alias vn "v ~/.config/neofetch/config.conf"
alias nn "nv ~/.config/neofetch/config.conf"
alias cn "chezmoi edit ~/.config/neofetch/config.conf"
alias vs "v ~/.config/starship.toml"
alias ns "nv ~/.config/starship.toml"
alias cs "chezmoi edit ~/.config/starship.toml"

## When finished
alias q quit
alias x exit



#=============================================================================
# Theme Settings
#=============================================================================

# Budspencer theme
if test (uname -s) = Darwin
    set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
    set -gx PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
end

# 起動時の挨拶を無効にする
# set -U budspencer_nogreeting

# プロンプトの色を変更する
set budspencer_colors 00d7be 5e35b1 7b17eb e6e6e6 37195a e8c317 e6460a ff3270 ffff00 ff26ab d6f02f 00ff9c

# コマンド履歴に表示されるべきではないコマンド
set -U budspencer_nocmdhist c d ll ls m s

# Node バージョンを表示する
# set -g budspencer_alt_environment "node -v"



#=============================================================================
# tmux Settings
#=============================================================================

# 256 色表示対応
set -gx TERM xterm-256color

#function attach_tmux_session_if_needed
#    set ID (tmux list-sessions)
#    if test -z "$ID"
#        tmux new-session
#        return
#    end

#    set new_session "Create New Session"
#    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
#    if test "$ID" = "$new_session"
#        tmux new-session
#    else if test -n "$ID"
#        tmux attach-session -t "$ID"
#    end
#end

#if test -z $TMUX && status --is-login
#    attach_tmux_session_if_needed
#end



#=============================================================================
# Develop Settings
#=============================================================================

# anyenv 設定
#set -x PATH $HOME/.anyenv/bin $PATH
#eval (anyenv init - | source)

# asdf-vm 設定
source /usr/local/opt/asdf/asdf.fish

# python


# go


# java


# Flutter
set -x PATH ~/bin/flutter/bin $PATH

# mysql


# postgresql


# hub
eval (hub alias -s)

# thefuck
#eval (thefuck --alias)
#eval (thefuck --alias FUCK)
#eval (thefuck --alias --enable-experimental-instant-mode)



#=============================================================================
# imports Settings
#=============================================================================

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        # Do nothing
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
