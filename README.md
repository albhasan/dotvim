# **vim** configuration files



## Pre-requisites

+ `sudo apt install vim`
+ `#sudo apt install neovim`
+ `sudo apt install ack-grep`
+ `sudo apt install git`
+ `sudo apt-get install exuberant-ctags`



## Initialization:


### vim's plugins:

```
cd ~
git clone https://github.com/albhasan/dotvim.git
mkdir -p ~/dotvim/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git ~/dotvim/pack/minpac/opt
# Don't forget to update the plugins! Run from inside vim :call minpac#update()
```


### TMUX:

```
git clone https://github.com/tony/tmux-config.git     ~/dotvim/tmux-config
rmdir ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load
cd ~/dotvim/tmux-config/vendor
git clone https://github.com/thewtex/tmux-mem-cpu-load.git
cd ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load && cmake . && make && sudo make install
```


### Create symlinks:

```
ln -s ~/dotvim                        ~/.vim                          
ln -s ~/dotvim/ctags                  ~/.ctags
ln -s ~/dotvim/tmux-config            ~/.tmux
ln -s ~/dotvim/tmux-config/.tmux.conf ~/.tmux.conf
# neovim
mkdir -p ~/.config/nvim
echo "set runtimepath^=~/.vim/ runtimepath+=~/.vim/after" >  ~/.config/nvim/init.vim
echo "let &packpath = &runtimepath"                       >> ~/.config/nvim/init.vim
echo "source ~/.vim/vimrc"                                >> ~/.config/nvim/init.vim
```


### Install or update plugins from inside vim:

`:call minpac#update()`



### Activate vim's optional packages

`:packadd vim-fugitive`
`:packadd vim-scripteade`
`:packadd ale`


### Deactivate Caps Lock by adding the following to `.bashrc`

`setxkbmap -option ctrl:nocaps`



## Usage notes:

+ Change background using `:set background=dark`
+ Cange colors using `:colorscheme solarized8`
+ Show invisible characters `:set list`
+ Set the tab configuration `:Stab`
+ Toggle search highlight using F4
+ Remove white spaces at the end of lines using F5.
+ Use F7 or ,s to toggle the spelling using F7 and to move between suggestion using `]s`
+ To see suggestions use `z=`
+ Update the plugins using `:call minpac#update()`


## Resources:

- The [Tao of tmux](https://leanpub.com/the-tao-of-tmux)



## TODO:

+ Move colors to the right place in the directory tree.

