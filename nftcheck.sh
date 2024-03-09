#!/bin/sh

# Strip everything but counters in nft ruleset ouput,
# and add colors for better reading.
#
# Usage: ./root/nftcheck.sh | column -t -s '?'
#
# You can add this to .bashrc or .bash_aliases:
# alias nftcheck="/path-to/nftcheck.sh | column -t -s '?'"

F=/tmp/ruleset

  nft list ruleset | sed -nr '/counter/ {
    s/counter //
    s/([sd]addr) ([a-z.:0-9/]+([0-9]{2,3})?) /\\\\033\[38;5;214m\1\\\\033\[0m \\\\033\[1;37m\2\\\\033\[0m /g 
    s/(icmp type) \{ [a-z, -]+ }/\1 {…}/
    s/jump ([a-z_0-9]+)$/?jump \\\\033\[01;34m\1\\\\033\[0m/
    s/(accept)$/?\\\\033\[01;32m\1\\\\033\[0m/
    s/(reject|drop)$/?\\\\033\[01;31m\1\\\\033\[0m/
    s/packets ([0-9]+)/?packets \\\\033\[1;33m\1\\\\033\[0m/
    s/bytes ([0-9]+)/?bytes \\\\033\[1;33m\1\\\\033\[0m/
    s/(tcp)/\\\\033\[1;36m\1\\\\033\[0m/g
    s/(udp)/\\\\033\[1;35m\1\\\\033\[0m/g
    s/([ds]port) ([0-9]{1,5})/\\\\033\[38;5;67m\1\\\\033\[0m \\\\033\[1;37m\2\\\\033\[0m/g
    s/([oi]if(name)?) ("?[a-z0-9]+"?)/\\\\033\[38;5;140m\1\\\\033\[0m \\\\033\[1;37m\3\\\\033\[0m/g
    p }' > $F
  while read line ; do
    echo $line
  done < $F
