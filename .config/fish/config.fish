### Manually adding to path
set -e fish_user_paths
# set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.cargo/bin $HOME/anaconda3/bin $fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/.cargo/bin $fish_user_paths
set -Ux XDG_DATA_DIRS /var/lib/flatpak/exports/share /home/$USER/.local/share/flatpak/exports/share /usr/local/share /usr/share

set fish_greeting
set TERM tmux-256color
set EDITOR "emacsclient -t -a ''"
set VISUAL "emacsclient -c -a emacs"

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
    cd (fd -t d -H | fzf --height 50% --border --reverse)
end

function nff
    cd
    nvim (fd -t f -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function eff
    cd
    emacsclient -c -a emacs (fd -t f -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function ef
    emacsclient -c -a emacs (fd -t f -H | fzf --preview 'bat --color=always {}' --height 50% --border --reverse)
end

function cff
    cd
    cd (fd -t d -H | fzf --height 50% --border --reverse)
end

function jl
    julia --project=. $argv[1]
end

function jladd
    for arg in $argv
        julia -e "using Pkg; Pkg.activate(\".\"); Pkg.add(\"$arg\")"
    end
end

function jlremove
    for arg in $argv
        julia -e "using Pkg; Pkg.activate(\".\"); Pkg.rm(\"$arg\")"
    end
end

alias emacs="emacsclient -c -a 'emacs'"
alias rem="killall emacs || echo 'Emacs server not running'; /usr/bin/emacs --daemon" # Kill Emacs and restart daemon..
alias ls="eza -al --group-directories-first --color=always"
alias la="eza -a --group-directories-first --color=always"
alias lr="eza -aT --group-directories-first --git-ignore --color=always"
alias cls="clear"
alias md="mkdir"
alias ..="cd .."
alias it="cd ~/projects"
alias ex="nautilus ."
alias lg="lazygit"
alias rd='rm -rf'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias conadd="config add -u"
alias concommit="config commit -m"
alias conpush="config push"
alias nc="cd ~/.config/nvim/lua/xrhahelry"
alias active="conda activate"
alias deactive="conda deactivate"
alias cc="code ."
alias nn="nvim ."
alias tlauncher="java -jar /opt/TLauncher.jar"
alias doom=" ~/.config/emacs/bin/doom"
alias note="jupyter notebook"

if status is-interactive
    colorscript random
end

starship init fish | source

if test -f /home/xrhahelry/anaconda3/bin/conda
    eval /home/xrhahelry/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/xrhahelry/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/xrhahelry/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/xrhahelry/anaconda3/bin $PATH
    end
end

conda activate main

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/xrhahelry/.ghcup/bin $PATH # ghcup-env

if not set -q TMUX
    if command -v tmux >/dev/null
        exec tmux
    else
        echo "tmux is not installed. Please install it first."
    end
else
end
