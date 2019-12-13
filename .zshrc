_has()
{
    return $(whence $1 >/dev/null)
}

_try()
{
    return $(eval $* > /dev/null 2>&1)
}

_is()
{
    return$( ["$HOSTTYPE" = "$1"] )
}

_color()
{
    return $([ -z "$INSIDE_EMACS" -a -z "$VIMRUNTIME"])
}

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="aleks"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git svn zsh-syntax-highlighting git-flow)

# User configuration

export PATH="/home/${USER}/.pyenv/bin:/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/bin:$HOME/node_modules/.bin:/usr/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
CDPATH=".:~:~/code"

function sources
{
    find . -name "*.cpp" -o -name "*.cc" -o -name "*.py" -o -name "*.hpp" -o -name "*.c" -o -name "*.h" -o -name "*.html" -o -name "*.js" -o -name "*.css"
}

function agc
{
    local search_param=$1;
    sources | xargs ag -n "$search_param" 2> /dev/null
}

function di
{
    pushd ~/code/beyondisee;
    bash ~/code/beyondisee/docker/scripts/dev_into.sh ${1};
    popd
}

function virtenv
{
    source ${1}/bin/activate 2> /dev/null || echo "No virtual environment available."
}


# Disable the most annoying feature of ZSH
unsetopt share_history
unsetopt auto_cd

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='vim'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cp="rsync -ah --progress"
alias gbdiff="git log --left-right --graph --cherry-pick --oneline "
alias dn="daemon"

# Haskell stuff
export PATH=~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(direnv hook zsh)"

# Change default format of built-in time
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

if [ -e ~/.zshlocal ]; then
    source ~/.zshlocal
fi


# Work related aliases
alias dsb="docker start beyond_dev"
alias dss="docker stop beyond_dev"
eval $(thefuck --alias)

#fpath=(~/.zshr/completion $fpath)

# vim diffing setup for git
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
. /home/aleks/.pyenv/versions/anaconda3-5.1.0/etc/profile.d/conda.sh
alias config='/usr/bin/git --git-dir=/home/aleks/.cfg/ --work-tree=/home/aleks'
