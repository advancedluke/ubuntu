### References
# http://behindtheracks.com/2014/04/redundant-load-balancers-haproxy-and-keepalived/
# http://support.severalnines.com/entries/23612682-Install-HAProxy-and-Keepalived-Virtual-IP-
# https://raymii.org/s/tutorials/Keepalived-Simple-IP-failover-on-Ubuntu.html
###

## vi /etc/sysctl.conf
# net.ipv4.ip_nonlocal_bind=1
##

sysctl -p

## Install Packeages
sudo apt-get update && apt-get install keepalived
