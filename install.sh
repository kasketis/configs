#!/bin/bash

# prereqs
# zsh
# oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
# chsh -s $(which zsh) to set zsh as login shell

echo "Script started"

read -p "Install oh-my-zsh? [y/n] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "oh-my-zsh installation finished."
fi

for file in $(ls -a | grep "^\.[a-z]" | grep -v "^\.git.*")
do
read -p "Create link for file: $file? [y/n] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Linking file $file: " 
        cp ~/$file ~/$file".old" 2>>/dev/null #backup old 
        ln -v -sf `pwd`/$file ~
        echo
    fi
done

# copy themes
cp -rf .zsh_custom/themes/* ~/.oh-my-zsh/themes/
echo "Themes copied"
echo 
echo "You are ready to go!"
