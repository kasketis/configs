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
alias cl="clear"
alias con='lsof -P -i -n'
alias lh='ls -a | egrep "^\."'
alias s='du -sh'
alias ttop='top -ocpu -R -F -s 2 -n30'

# git aliases
alias add='git add'
alias commit='git commit -m'
alias clone='git clone'
alias checkout='git checkout'
alias deploy='~/.deploy/post-push.sh'
alias diff='git diff'
alias info='echo `git config --local remote.origin.url`'  
alias log='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(green)(%cr) %C(red)%d%Creset %s %C(cyan)<%an>%Creset" --abbrev-commit'
alias merge='git merge'
alias push='git push'
alias pull='git pull'
alias status='git status'


# safe remove
function rm() { mv $1 ~/.Trash/$1\-\-`date +%Y-%m-%d:%H:%M:%S` }

# empty trash
function rmtrash()
{ 
    local go_ahead
    read -q "go_ahead?Are you sure want to empty trash? [y/n] "
    echo
    if [[ "$go_ahead" = "y" ]]; then
        command rm -rf ~/.Trash/* #execute real rm
    fi
}

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

# make a package
function pk() 
{
    echo "Packing $1 ..."
    if [ $1 ] ; then
        case $1 in
            tbz)       tar cjvf $2.tar.bz2 $2 ;;
            tgz)       tar czvf $2.tar.gz  $2 ;;
            tar)       tar cpvf $2.tar  $2 ;;
            bz2)       bzip $2 ;;
            gz)        gzip -c -9 -n $2 > $2.gz ;;
            zip)       zip -r $2.zip $2 ;;
            7z)        7z a $2.7z $2 ;;
            *)         echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# extract a packed file
function extract () 
{
    echo "Extracting $1 ..."
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1 ;;
            *.tar.gz)    tar xzf $1 ;;
            *.bz2)       bunzip2 $1 ;;
            *.rar)       unrar x $1 ;;
            *.gz)        gunzip $1 ;;
            *.tar)       tar xf $1  ;;
            *.tbz2)      tar xjf $1 ;;
            *.tbz)       tar -xjvf $1 ;;
            *.tgz)       tar xzf $1 ;;
            *.zip)       unzip $1 ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1 ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
} 

# show/hide hidden files in Finder
function showh() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hideh() { defaults write com.apple.Finder AppleShowAllFiles NO ; }
 
# show/hide icons on Desktop
function showd() { defaults write com.apple.finder CreateDesktop -bool true ; killall Finder /System/Library/CoreServices/Finder.app;}
function hided() { defaults write com.apple.finder CreateDesktop -bool false ; killall Finder /System/Library/CoreServices/Finder.app;}
 
# displays mounted drive information in a nicely formatted manner
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

# print help
function help()
{
    echo "generic aliases"
    echo "---------------"
    echo " ..\n ...\n ....\n bk\n con\n lh\n s\n ttop"
    echo
    echo "git aliases"
    echo "-----------"
    echo " add\n commit\n clone\n checkout\n deploy\n diff\n info\n log\n merge\n push\n pull\n status"
    echo
    echo "functions"
    echo "---------"
    echo " rm\n rmtrash\n myip\n server\n gi\n randpass\n pk\n extract\n showh\n hideh\n showd\n hideh\n nicemount\n help"
}
