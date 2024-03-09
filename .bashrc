
# Colorize ls
alias ls='ls --color=auto'

# limit ping count
alias ping='ping -c2'

# show all routes.
alias ipr='ip r ; ip -6 r'

# show all inet stuff.
alias ipar='ip a ; ipr'

# Edit and reload firewall.
alias fwedit='nano /etc/nftables.conf ; nft -f /etc/nftables.conf'

# Show firewall rules with nice colors.
function fwcheck {
  if [ $1 == 'counter' ] ; then
    /usr/sbin/nftcheck.sh | column -t -s '?'
  else
    nft list ruleset | sed -r '
      s/([sd]addr) ([a-z.:0-9/]+([0-9]{2,3})?) /\x1b[38;5;214m\1\x1b[0m \x1b[1;37m\2\x1b[0m /g
      s/(icmp type) \{ [a-z, -]+ }/\1 {…}/
      s/jump ([a-z_0-9]+)/jump \x1b[01;34m\1\x1b[0m/
      s/(accept)$/?\x1b[01;32m\1\x1b[0m/
      s/(reject|drop)$/\x1b[01;31m\1\x1b[0m/
      s/packets ([0-9]+)/packets \x1b[1;33m\1\x1b[0m/
      s/bytes ([0-9]+)/bytes \x1b[1;33m\1\x1b[0m/
      s/(tcp)/\x1b[1;36m\1\x1b[0m/g
      s/(udp)/\x1b[1;35m\1\x1b[0m/g
      s/([ds]port) ([0-9]{1,5})/\x1b[38;5;67m\1\x1b[0m \x1b[1;37m\2\x1b[0m/g
      s/([oi]if(name)?) ("?[a-z0-9]+"?)/\x1b[38;5;140m\1\x1b[0m \x1b[1;37m\3\x1b[0m/g '
  fi
}
