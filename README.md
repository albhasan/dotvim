vim configuration files

Initialization:

    git clone https://github.com/albhasan/dotvim.git      ~/dotvim
    git clone https://github.com/tony/tmux-config.git     ~/dotvim/tmux-config
    git clone https://github.com/dense-analysis/ale.git   ~/dotvim/pack/git-plugins/start/ale
    git clone https://github.com/tpope/vim-abolish.git    ~/dotvim/pack/git-plugins/start/vim-abolish 
    git clone https://github.com/tpope/vim-commentary.git ~/dotvim/pack/git-plugins/start/vim-commentary
    git clone https://github.com/tpope/vim-fugitive.git   ~/dotvim/pack/git-plugins/start/vim-fugitive 

Create symlinks:

    ln -s ~/dotvim/vimrc                  ~/.vimrc
    ln -s ~/dotvim                        ~/.vim                          
    ln -s ~/dotvim/tmux-config/.tmux.conf ~/.tmux.conf
    ln -s ~/dotvim/tmux-config            ~/.tmux

Install TMUX commands:

    rm ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load
    cd ~/dotvim/tmux-config/vendor
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git
    cd ~/dotvim/tmux-config/vendor/tmux-mem-cpu-load && cmake . && make && sudo make install

Resources:

- The Tao of tmux https://leanpub.com/the-tao-of-tmux/

