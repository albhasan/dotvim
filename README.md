vim configuration files

Initialization:

    git clone https://github.com/albhasan/dotvim.git      /home/alber/dotvim
    git clone https://github.com/tony/tmux-config.git     /home/alber/dotvim/tmux-config
    git clone https://github.com/dense-analysis/ale.git   /home/alber/dotvim/pack/git-plugins/start/ale
    git clone https://github.com/tpope/vim-abolish.git    /home/alber/dotvim/pack/git-plugins/start/vim-abolish 
    git clone https://github.com/tpope/vim-commentary.git /home/alber/dotvim/pack/git-plugins/start/vim-commentary
    git clone https://github.com/tpope/vim-fugitive.git   /home/alber/dotvim/pack/git-plugins/start/vim-fugitive 

Create symlinks:

    ln -s /home/alber/dotvim/vimrc                  /home/alber/.vimrc
    ln -s /home/alber/dotvim                        /home/alber/.vim                          
    ln -s /home/alber/dotvim/tmux-config/.tmux.conf /home/alber/.tmux.conf
    ln -s /home/alber/dotvim/tmux-config            /home/alber/.tmux

Install TMUX commands:

    cd ~/.tmux/vendor/tmux-mem-cpu-load && cmake . && make && sudo make install

Resources:

- The Tao of tmux https://leanpub.com/the-tao-of-tmux/

