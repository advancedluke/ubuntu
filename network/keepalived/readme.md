
# Keepalived Configuration


#### Preperation on both Servers
/etc/sysctl.conf
~~~
net.ipv4.ip_nonlocal_bind=1
~~~

sysctl -p

#### Install Packages

~~~
sudo apt-get update && apt-get install keepalived
~~~

#### Configuration 1 on Server 01
/etc/keepalived/keepalived.conf
~~~
global_defs {
  router_id proxy01
}
vrrp_script haproxy {
  script "killall -0 haproxy"
  interval 2
  weight 2
}
vrrp_instance 50 {
  virtual_router_id 50
  advert_int 1
  priority 101
  state MASTER
  interface eth0
  virtual_ipaddress {
    <vip_address> dev eth0
  }
  track_script {
    haproxy
  }
}
~~~

#### Configuration 2 on Server 02
/etc/keepalived/keepalived.conf
~~~
global_defs {
  router_id proxy02
}
vrrp_script haproxy {
  script "killall -0 haproxy"
  interval 2
  weight 2
}
vrrp_instance 50 {
  virtual_router_id 50
  advert_int 1
  priority 100
  state MASTER
  interface eth0
  virtual_ipaddress {
    <vip_address> dev eth0
  }
  track_script {
    haproxy
  }
}
~~~

#### Restart Services 

sudo service keepalived restart
sudo service haproxy restart

#### Check Status
ip a | grep eth0

status example :
~~~
@proxy01:/etc/default$ ip a | grep bond1
2: p3p1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
5: em2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
7: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    inet 10.10.10.12/24 brd 10.10.10.255 scope global bond1
    inet 10.10.10.11/32 scope global bond1

@proxy02:~$ ip a | grep bond1
2: p3p1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
5: em2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP group default qlen 1000
7: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    inet 10.10.10.13/24 brd 10.10.10.255 scope global bond1
~~~

#### Check Logs

sudo tail -f /var/log/syslog | grep VRRP


#### References
http://behindtheracks.com/2014/04/redundant-load-balancers-haproxy-and-keepalived/
http://support.severalnines.com/entries/23612682-Install-HAProxy-and-Keepalived-Virtual-IP-
https://raymii.org/s/tutorials/Keepalived-Simple-IP-failover-on-Ubuntu.html
