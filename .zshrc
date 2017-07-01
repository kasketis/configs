ZSH_CUSTOM=.zsh_custom
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kasketis"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias s='du -sh'
alias bk='cd $OLDPWD'
alias ttop='top -ocpu -R -F -s 2 -n30'
alias lh='ls -a | egrep "^\."'

#git aliases
alias ga='git add'
alias gaa='git add .'
alias gcl='git clone'
alias gm='git commit -m'
alias gma='git commit -am'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias gdp='~/.deploy/post-push.sh'
