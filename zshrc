# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias gclean='git remote prune origin && git branch -vv | grep "\[origin/.*: gone\]" | awk "{print \$1}" | xargs git branch -D'

alias devdus='dev down && dev up && dev s'
alias devdut='dev down && dev up && dev t'
alias devdu='dev down && dev up'
alias devus='dev up && dev s'
alias devut='dev up && devt'
alias devst='dev style --include-branch-commits --all-cops'
alias devt='dev t --include-branch-commits '
alias devs='dev s'
alias devu='dev u'
alias devd='dev d'
alias devc='dev c'
alias devuc='dev u && dev c'
alias devur='dev up && dev restart'
alias devduc='dev d && dev u && dev c'
alias devv='dev typecheck && dev style --include-branch-commits && devt'
alias devvv='dev typecheck && dev style -a && dev t'
alias devuv='devdu && devv'
function t {
    if [ -f "Gemfile" ]; then
        dev test "$@"
    else
        yarn test --silent "$@"
    fi
}
alias g="git"
alias tap="bin/tapioca"
my() {
  mycli -u root -h 127.0.0.1 shopify_dev -P $MYSQL_PORT
}
mys() {
  mycli -u root -h 127.0.0.1 shopify_dev_shard_0 -P $MYSQL_PORT
}
bump() {
  git s main
  git pull

  local date=$(date +"%m-%d-%Y")
  git switch -c "bump-$date"

  update && bundle update && dev update-rbis && devvv && git A && git cm "Bump" && g pu && dev open pr
}
shipped() {
  dev cd //areas/core/shopify
  dev conveyor is-it-shipped "$@"
}
killz() {
  kill -9 %1
}

export EDITOR='vim'

bindkey -v
bindkey fd vi-cmd-mode
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
# Timeout after escape
export KEYTIMEOUT=1
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line

# Don't save commands starting with a space
setopt HIST_IGNORE_SPACE

export PATH=$PATH:~/Projects/bin
export PATH=$PATH:~/dotfiles/bin

# Use arrow for history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# fzf
source ~/dotfiles/fzf.zsh

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/js/.kube/config:/Users/js/.kube/config.shopify.cloudplatform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=$(( 2**31 - 1 ))
SAVEHIST=$HISTSIZE
