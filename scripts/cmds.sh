#!/bin/bash

SEQ='/usr/bin/seq'
IPT='/sbin/iptables'
CAT='/bin/cat'
GREP='/bin/grep'
AWK='/usr/bin/awk'
IFCONFIG='/sbin/ifconfig'
MODPROBE='/sbin/modprobe'
ECHO='/bin/echo'
PS='/bin/ps'
WC='/usr/bin/wc'
RM='/bin/rm'
SLEEP='/bin/sleep'
TOUCH='/usr/bin/touch'
NETSTAT='/bin/netstat'
SSH='/usr/bin/ssh'
SCP='/usr/bin/scp'
HEAD='/usr/bin/head'
TAIL='/usr/bin/tail'
SED='/bin/sed'
LAST='/usr/bin/last'
CP='/bin/cp'
MV='/bin/mv'
PON='/usr/bin/pon'
POFF='/usr/bin/poff'
ROUTE='/sbin/route'
WGET='/usr/bin/wget'
BRCTL='/sbin/brctl'
NSLOOKUP='/usr/bin/nslookup'
IP='/sbin/ip'
DATE='/bin/date'
KVM='/usr/bin/kvm'
TC='/sbin/tc'
TR='/usr/bin/tr'
IP='/sbin/ip'
CHMOD='/bin/chmod'
CHOWN='/bin/chown'
SORT='/usr/bin/sort'
NICE='/usr/bin/nice'
RENICE='/usr/bin/renice'
PING='/bin/ping'
PKILL='/usr/bin/pkill'
KILL='/bin/kill'

LOWPRIO="$NICE -n 19"


log() {
	$ECHO $@
	$ECHO `$DATE` \[$$\] $@ >> /var/log/scripts.log
}

#RENICE $$ 19 >/dev/null 2>/dev/null

