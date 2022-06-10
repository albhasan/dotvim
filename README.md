# **vim** configuration files



## Pre-requisites


### Install software:

```
#sudo apt install vim
#sudo apt install neovim
sudo apt install ack-grep
sudo apt install bibclean
sudo apt install clang
sudo apt install clang-tidy
sudo apt install git
sudo apt-get install exuberant-ctags
sudo apt install tmux 
```


### Install linters:

```
pip3 install vim-vint                              # vim script
pip3 install pylint                                # python
R -e "install.packages('styler')"                  # R
R -e "devtools::install_github('jimhester/lintr')" # R
sudo apt-get install shellcheck                    # bash
sudo apt-get install chktex                        # latex
sudo apt-get install python3-proselint             # latex, html, markdown
#sudo apt-get install flake8                        # python
sudo apt-get install libxml2-utils                 # xml
sudo apt install yamllint                          # yaml
sudo npm install -g eslint                         # javascript
sudo npm install -g write-good                     # text, html, markdown
sudo npm install -g prettier                       # yaml
sudo npm install -g jsonlint                       # json
```


### Configure ctags to work with R:

```
/bin/cat <<EOM > ~/.ctags
--langdef=R
--langmap=r:.R.r
--regex-R=/^[ \t]*"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t]function/\1/f,Functions/
--regex-R=/^"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/g,GlobalVars/
--regex-R=/[ \t]"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/v,FunctionVariables/
EOM
```


## Initialization


### Get vim configuration:

```
cd ~
git clone https://github.com/albhasan/dotvim.git
mkdir -p ~/dotvim/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git ~/dotvim/pack/minpac/opt/minpac
# Don't forget to update the plugins! Run from inside vim :call minpac#update()
```


### Get TMUX configuration:

```
cd ~/dotvim
git clone https://github.com/tony/tmux-config.git
cd ~/dotvim/tmux-config
cd ~/dotvim/tmux-config/vendor
rm -rf ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load
git clone https://github.com/thewtex/tmux-mem-cpu-load.git
cd ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load
cmake .
make
sudo make install
```


### Create symlinks:

```
ln -s ~/dotvim                        ~/.vim                          
ln -s ~/dotvim/tmux-config            ~/.tmux
ln -s ~/dotvim/tmux-config/.tmux.conf ~/.tmux.conf
ln -s ~/dotvim/bash_aliases             ~/.bash_aliases

# neovim
mkdir -p ~/.config/nvim
echo "set runtimepath^=~/.vim/ runtimepath+=~/.vim/after" >  ~/.config/nvim/init.vim
echo "let &packpath = &runtimepath"                       >> ~/.config/nvim/init.vim
echo "source ~/.vim/vimrc"                                >> ~/.config/nvim/init.vim
```


### Install or update plugins from inside vim:

`:call minpac#update()`


### Activate vim's optional packages (from inside vim):

`:packadd vim-fugitive`
`:packadd vim-scriptease`


### Make the Caps Lock behave as the Ctrl key by adding the following to `.bashrc`

`setxkbmap -option ctrl:ctrl_modifier`




## Usage notes vim:

+ Change background using `:set background=dark`
+ Cange colors using `:colorscheme solarized8`
+ Show invisible characters `:set list`
+ Set the tab configuration `:Stab`
+ Toggle search highlight using F4
+ Remove white spaces at the end of lines using F5.
+ Use F7 or to toggle the spelling using F7 and to move between suggestion using `]s`. To see spelling suggestions use `z=`
+ Update all the plugins using `:call minpac#update()`
+ Use `Ctrl + p` and `Crtl + n` to navigate history (first call `Esc` and `:`)
+ Use `Ctrl + ]` to jump to function definitions and `Ctrl + t` to get back.
+ Use `gc` to comment lines of code.
+ Use `Ctrl + r 0` to paste yanked text.


## Usage notes tmux:

+ List sessions `tmux ls`
+ Attach session `Ctrl + at -t session_name`
+ Dettach session `Ctrl + d`
+ New session `tmux new -s session_name`

+ New window `Ctrl + A + c`
+ Show windows `Ctrl + A + x`
+ Rename window `Ctrl + A + ,`
+ Move to next window `Ctrl + n`

+ Split panel horizontally ` Ctrl + A + "`
+ Split panel vertically ` Ctrl +A + %`
+ Switch panes (e.g. horizontal to vertical) `Ctrl + A + space bar`
+ Zoom to pane `Ctrl + A + z`
+ Change focus to panel below `Ctrl + A + j`
+ Change focus to panel up `Ctrl + A + j`
+ Change focus to panel right `Ctrl + A + l`
+ Change focus to panel left `Ctrl + A + r`
+ Resize panel (keep Ctrl + A down) `Ctrl + A + arrow`



## Resources:

+ [Practical Vim](https://pragprog.com/book/dnvim/practical-vim) by Drew Neil.
+ [Vim cast](http://vimcasts.org)
+ [Getting Vim and Ctags working with R](https://tinyheero.github.io/2017/05/13/r-vim-ctags.html#testing-vim--ctags-with-r)
+ The [Tao of tmux](https://leanpub.com/the-tao-of-tmux)


## TODO:

+ Move color schemas to the right place in the directory tree.
+ Prettier lint is not working. ALE has no vim files about its configuration. Either remove it or fix it.
+ styler is not working. Either remove it or fix it.
+ define a linter for text file. Either write-good or proselint. Is ALE using the file extension to figure the file type?

