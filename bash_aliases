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


#------------------------------------------------------------------------------
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

#------------------------------------------------------------------------------
# Deprecated linux commands you should not use anymore (and their alternatives)
# https://itsfoss.com/deprecated-linux-commands/
alias scp="echo 'STOP. Use instead rsync'"
alias    egrep="echo 'STOP. Use instead grep -E'"
alias    fgrep="echo 'STOP. Use instead grep -F'"
alias  netstat="echo 'STOP. Use instead ss'"
alias ifconfig="echo 'STOP. Use instead ip'"
alias      arp="echo 'STOP. Use instead ip n'"
alias    route="echo 'STOP. Use instead ip tunnel'"
alias iptunnel="echo 'STOP. Use instead ip link'"
alias   nameif="echo 'STOP. Use instead ip route'"
alias iwconfig="echo 'STOP. Use instead iw'"
alias iptables="echo 'STOP. Use instead nftables'"

