if [[ -d $HOME/local ]]; then
  ZPLUG_CACHE_DIR=$HOME/local/.zplug-cache
fi
source "${HOME}/.zplug/init.zsh"
export HGEDITOR=vim
export EDITOR=vim
export HISTSIZE=120000
export SAVEHIST=120000

# vi keys are just weird at the shell
bindkey -e
# fix del ?!
bindkey    "^[[3~"          delete-char

# override paths {{{
for path_candidate in ~/bin \
  ~/local/pfx/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${path_candidate}:${PATH}
  fi
done
# }}}

# early local config (zplug stuff, path, etc.)
if [ -f .zshrc.local.pre ]; then
  source ~/.zshrc.local.pre
fi

# PLUGINS {{{
zplug "robbyrussell/oh-my-zsh"
zplug "zsh-users/zsh-history-substring-search"
zplug "djui/alias-tips"
zplug "willghatch/zsh-saneopt"

# Load some oh-my-zsh plugins
zplug "plugins/git", from:oh-my-zsh, defer:2

zplug "chrissicool/zsh-256color"
zplug "zlsun/solarized-man"
zplug "hchbaw/zce.zsh"

GENCOMPL_FPATH=$HOME/.zsh/complete
zplug "RobSis/zsh-completion-generator"

zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:bullet-train.zsh-theme
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "knu/z", use:z.sh, defer:2
zplug "jreese/zsh-titles"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
# }}}

zmodload zsh/terminfo

setopt prompt_subst
setopt inc_append_history
setopt share_history
setopt hist_verify
setopt hist_ignore_dups
setopt hist_ignore_space
setopt extended_history

# Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

setopt interactivecomments
setopt auto_cd
# BULLET TRAIN {{{
# host-type icon in custom part
BULLETTRAIN_CUSTOM_FG=007
hostname="$(hostname)"
BULLETTRAIN_CUSTOM_MSG="$(hostname -s)"
BULLETTRAIN_CONTEXT_DEFAULT_USER="aaronmiller"
BULLETTRAIN_HG_SHOW=false
BULLETTRAIN_PROMPT_ORDER=(
  custom
  git
  hg
  context
  dir
)

BULLETTRAIN_DIR_BG=19
BULLETTRAIN_GIT_BG=07
BULLETTRAIN_GIT_UNTRACKED="%F{green}✭%F{black}"
BULLETTRAIN_DIR_EXTENDED=0
# }}}

bindkey '^F' zce
bindkey '^W' kill-word

# dircolors {{{
if type dircolors 2>&1 >/dev/null; then
  eval `dircolors ~/mydots/dircolors/dircolors.ansi-dark`
fi

ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
# }}}

# FZF {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Atelier Dune
# Author: Bram de Haan (http://atelierbramdehaan.nl)


local color00='0'
local color01='1'
local color02='2'
local color03='3'
local color04='4'
local color05='5'
local color06='6'
local color07='7'
local color08='8'
local color09='9'
local color0A='10'
local color0B='11'
local color0C='12'
local color0D='13'
local color0E='14'
local color0F='15'

export FZF_DEFAULT_COMMAND='fastfind || hg files 2>/dev/null || ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="z | awk '{print \$2}'"
export FZF_DEFAULT_OPTS="
  --extended
  --bind ctrl-f:page-down,ctrl-b:page-up
  --color=bg+:18,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
# }}}

# late local config (aliases, completions)
if [ -f ~/.zshrc.local.late ]; then
  source ~/.zshrc.local.late
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# vim: fen fdm=marker fdl=0
export PATH="/usr/local/sbin:$PATH"
