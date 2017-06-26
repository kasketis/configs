#!/bin/bash

#prereqs
#zsh
#oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)

git pull

cd "$(dirname "$0")"

for file in $(ls -a|grep "^\.[a-z]"|grep -v "^\.git$")
do
read -p "Create link for file: $file? [y/n] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      yes=true
    else 
      yes=false
    fi
  if [ "$yes" = true ]; then
    echo "Linking file $file"
    ln -v -sf `pwd`/$file ~
  fi
done
