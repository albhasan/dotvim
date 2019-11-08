# **vim** configuration files

## Initialization:



```

    git clone https://github.com/albhasan/dotvim.git               ~/dotvim
    mkdir -p ~/dotvim/pack/bundle/start
    mkdir -p ~/dotvim/pack/bundle/opt
    git clone https://github.com/tpope/vim-abolish.git             ~/dotvim/pack/bundle/start/vim-abolish
    git clone https://github.com/tpope/vim-commentary.git          ~/dotvim/pack/bundle/start/vim-commentary
    git clone https://github.com/tpope/vim-surround.git            ~/dotvim/pack/bundle/start/vim-surround
    git clone https://github.com/tpope/vim-unimpaired.git          ~/dotvim/pack/bundle/start/vim-unimpaired
    git clone https://github.com/machakann/vim-highlightedyank.git ~/dotvim/pack/bundle/start/vim-highlightedyank
    git clone https://github.com/tpope/vim-fugitive.git            ~/dotvim/pack/bundle/opt/vim-fugitive
    git clone https://github.com/tpope/vim-scriptease.git          ~/dotvim/pack/bundle/opt/vim-scriptease
    git clone https://github.com/dense-analysis/ale.git            ~/dotvim/pack/bundle/opt/ale
```



## TMUX commands:

```
    git clone https://github.com/tony/tmux-config.git     ~/dotvim/tmux-config
    rmdir ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load
    cd ~/dotvim/tmux-config/vendor
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git
    cd ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load && cmake . && make && sudo make install
```



## Create symlinks:

```
    ln -s ~/dotvim/vimrc                  ~/.vimrc
    ln -s ~/dotvim                        ~/.vim                          
    ln -s ~/dotvim/tmux-config/.tmux.conf ~/.tmux.conf
    ln -s ~/dotvim/tmux-config            ~/.tmux
```



## Activate vim's optional packages

`:packadd vim-fugitive`
`:packadd vim-scripteade`
`:packadd ale`



## Install styles

```
mkdir -p ~/dotvim/pack/themes/opt
git clone https://github.com/lifepillar/vim-solarized8.git ~/dotvim/pack/themes/opt/solarized8

```

Activate style using 
`set background=dark`  
`colorscheme solarized8`



## Deactivate Caps Lock by adding the following to .bashrc

`setxkbmap -option ctrl:nocaps`



## Resources:

- The [Tao of tmux](https://leanpub.com/the-tao-of-tmux)

