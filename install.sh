#!/bin/bash

#prereqs
#zsh
#oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)

echo "Pulling the repo.."
git reset --hard
git pull

echo "Installlation started"

for file in $(ls -a|grep "^\.[a-z]"|grep -v "^\.git$")
do
read -p "Create link for file: $file? [y/n] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      yes=true
    else 
      yes=false
    fi
  if [ "$yes" = true ]; then
    echo "Linking file $file: " 
    ln -v -sf `pwd`/$file ~
    echo ""
  fi
done
