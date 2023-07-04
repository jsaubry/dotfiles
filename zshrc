alias gclean='git branch --merged main | grep -v "\* main" | grep -v ".*main" | xargs -n 1 git branch -d'

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
alias devduc='dev d && dev u && dev c'
alias devv='dev typecheck && dev style --include-branch-commits && devt'
alias devvv='dev typecheck && dev style -a && dev t'
alias devuv='devu && devv'
alias devuv='devdu && devv'
alias t="dev test"
alias g="git"
alias secrets="systemctl restart gcs-secrets.service template-config.service"
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

export EDITOR='vim'

bindkey -v
bindkey fd vi-cmd-mode
# Timeout after escape
export KEYTIMEOUT=1
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line

# fzf
source ~/dotfiles/fzf.zsh

# Don't save commands starting with a space
setopt HIST_IGNORE_SPACE

export PATH=$PATH:~/Projects/bin

# Use arrow for history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
