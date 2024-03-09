
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

# Show firewall counters with nice colors.
alias nftcheck="/root/nftcheck.sh | column -t -s '?'"
