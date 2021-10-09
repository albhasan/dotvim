# permanent bash aliases
# Ubuntu loads  ~/.bash_aliases, so, create as a symbolic link to this file

alias todo="todo.sh"

# https://www.lostsaloon.com/technology/12-useful-bash-aliases-that-you-can-make-you-more-productive-in-linux/

# Print only hidden files.
alias lh='ls -lisAd .[^.]*'

# Detailed print.
alias la='ls -lisA'

# Safe remove.
alias rm='rm -iv'

# Safe remove (less intrusive).
#alias rm='rm -Iv'

# Safe copy.
alias cp='cp -iv'

# Safe move.
alias mv='mv -iv'

# Remove file.
alias rms='shred -uz'

# Make folder and its parents.
#alias mkdir='mkdir -pv'

# Case insensitive search in history.
alias hs='history|grep -i '

# Untar.
alias tgz='tar -xvfz'

# Search file by name
alias ff='find . -type f -iname'

#---------------
# Linux essentials https://youtu.be/Ok_kD_sgNcs

# Pretty print mounted partitions 
alias lsmount="mount | column -t"

# Print my external ip address.
alias extip="curl icanhazip.com"

# Speed test
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

# Top 5 processes using the most memory.
alias mem5="ps auxf | sort -nr -k 4 | head -5"

# Top t processes using the most cpu.
alias cpu5="ps auxf | sort -nr -k 3 | head -5"
