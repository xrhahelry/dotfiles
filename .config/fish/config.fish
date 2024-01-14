### Manually adding to path
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.cargo/bin $fish_user_paths

set fish_greeting
set TERM "xterm-256color"
set EDITOR "nvim"
set VISUAL "nvim"

set -x MANPAGER "nvim +Man!"

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

function nf
    nvim (fd -t f -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function cf
    cd (fd -t d -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function nff
    cd
    nvim (fd -t f -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function cff
    cd
    cd (fd -t d -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

alias ls="eza -al --group-directories-first --color=always"
alias la="eza -a --group-directories-first --color=always"
alias lr="eza -aT --group-directories-first --git-ignore --color=always"
alias cls="clear"
alias md="mkdir"
alias ..="cd .."
alias it="cd ~/projects"
alias ex="explorer.exe ."
alias lg="lazygit"
alias rd='rm -rf'
alias addall="git add ."
alias gadd="git add"
alias clone="git clone"
alias pull="git pull"
alias push="git push"
alias commit="git commit -m"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias conadd="config add -u"
alias concommit="config  commit -m"
alias conpush="config push"
alias nc="cd ~/.config/nvim/lua/xrhahelry"

starship init fish | source
