source "${HOME}/.zplug/init.zsh"
export HGEDITOR=vim
export EDITOR=vim

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
zplug "hlissner/zsh-autopair"

zplug "djui/alias-tips"

# Load some oh-my-zsh plugins
zplug "plugins/sudo", from:oh-my-zsh, nice:10
zplug "plugins/git", from:oh-my-zsh, nice:10
zplug "plugins/python", from:oh-my-zsh, nice:10
zplug "plugins/tmux", from:oh-my-zsh, nice:10

zplug "chrissicool/zsh-256color"
zplug "zlsun/solarized-man"
zplug "hchbaw/zce.zsh"
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh

GENCOMPL_FPATH=$HOME/.zsh/complete
zplug "RobSis/zsh-completion-generator"

zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:bullet-train.zsh-theme
zplug "zsh-users/zsh-syntax-highlighting", nice:12
zplug "knu/z", use:z.sh, nice:10
zplug "supercrabtree/k"
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
setopt auto_cd
# BULLET TRAIN {{{
# host-type icon in custom part
BULLETTRAIN_CUSTOM_FG=007
hostname="$(hostname)"
BULLETTRAIN_CUSTOM_MSG="$(hostname -s)"
if [[ "${hostname}" =~ "^aaronmiller-mbp" ]]; then
  BULLETTRAIN_CUSTOM_MSG=""
fi
BULLETTRAIN_HG_SHOW=false
BULLETTRAIN_PROMPT_ORDER=(
  custom
  git
  context
  dir
)

BULLETTRAIN_DIR_BG=024
BULLETTRAIN_GIT_BG=011
BULLETTRAIN_GIT_UNTRACKED="%F{green}✭%F{black}"
BULLETTRAIN_DIR_EXTENDED=0
# }}}

# aliases/helpers

function s() {
  ssh root@$1 "${@:2}"
}

# keybinds
bindkey '^K' zce
bindkey '^W' kill-word

# dircolors {{{
if type dircolors 2>&1 >/dev/null; then
  eval `dircolors ~/mydots/dircolors/dircolors.ansi-dark`
fi

ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
# }}}

# FZF {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='
  --extended
  --bind ctrl-f:page-down,ctrl-b:page-up
'
# }}}

# late local config (aliases, completions)
if [ -f ~/.zshrc.local.late ]; then
  source ~/.zshrc.local.late
fi

# vim: fen fdm=marker fdl=0
