#/bin/sh

cd ~/.vim
# Git
export GIT_PROXY_COMMAND=/usr/local/bin/proxy-wrapper %h %p
git submodule update --init
git submodule foreach git pull origin master

ln -nfs ~/.vim/.vimrc ~/.vimrc

# Command-T
cd ~/.vim/bundle-`uname -i`/command-t/ruby/command-t
ruby extconf.rb
make clean && make
cd -

# Here we go :)
echo "Installed !"
