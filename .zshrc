ZSH_CUSTOM=.zsh_custom
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kasketis"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# generic aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias bk='cd $OLDPWD'
alias con='lsof -P -i -n'
alias lh='ls -a | egrep "^\."'
alias rmf='rm -f'
alias s='du -sh'
alias ttop='top -ocpu -R -F -s 2 -n30'

# git aliases
alias add='git add'
alias commit='git commit -m'
alias clone='git clone'
alias checkout='git checkout'
alias deploy='~/.deploy/post-push.sh'
alias diff='git diff'
alias log='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(green)(%cr) %C(red)%d%Creset %s %C(cyan)<%an>%Creset" --abbrev-commit'
alias merge='git merge'
alias push='git push'
alias pull='git pull'
alias status='git status'


# show/hide hidden files in Finder
function showh() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hideh() { defaults write com.apple.Finder AppleShowAllFiles NO ; }

# show/hide icons on Desktop
function showd() { defaults write com.apple.finder CreateDesktop -bool true ; killall Finder /System/Library/CoreServices/Finder.app;}
function hided() { defaults write com.apple.finder CreateDesktop -bool false ; killall Finder /System/Library/CoreServices/Finder.app;}

# displays mounted drive information in a nicely formatted manner
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

# myIP address
function myip() 
{
    curl -s ifconfig.co | awk '{print "wan       : " $1}'
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
    ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
 #   ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  #  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# start an HTTP server from a directory
function server() 
{
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

# create useful .gitignore files for your project
function gi() { curl -s -L http://www.gitignore.io/api/$@ >> .gitignore ;}

# generate random 12-16 digits passwords
function randpass() { digits=$((12 + RANDOM % 5)); for i in {1..5}; do LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c $digits | xargs; done }

#function translate() {
 #   curl "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
#}

# print help
function help()
{
    echo "generic aliases"
    echo "---------------"
    echo " ..\n ...\n ....\n bk\n con\n lh\n rmf\n s\n ttop"
    echo
    echo "git aliases"
    echo "-----------"
    echo " add\n commit\n clone\n checkout\n deploy\n diff\n log\n merge\n push\n pull\n status"
    echo
    echo "functions"
    echo "---------"
    echo " showh\n hideh\n showd\n hideh\n nicemount\n myip\n server\n gi\n randpass\n help"
}
