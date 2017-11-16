#! /bin/bash

#Update the Repositories
sudo apt-get update

#Install figlet
sudo apt-get install -y figlet

#Remove previous versions and other motd things
sudo rm /etc/update-motd.d/10-help-text
sudo rm /etc/update-motd.d/00-header
sudo rm /etc/update-motd.d/00-logo
sudo rm /etc/update-motd.d/01-distro
sudo rm /etc/update-motd.d/01-info

#Script to make the logo
sudo cat <<EOF00 >> /etc/update-motd.d/00-logo
#! /bin/bash

figlet "Hullfire Systems"
EOF00

#Script to display system info
sudo cat <<EOF01 >> /etc/update-motd.d/01-info
#!/bin/sh

UPTIME_DAYS=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 / 86400)
UPTIME_HOURS=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 % 86400 / 3600)
UPTIME_MINUTES=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 % 86400 % 3600 / 60)

cat << EOF
%                                                                            %
%+++++++++++++++++++++++++++++++ SERVER INFO ++++++++++++++++++++++++++++++++%
%                                                                            %
	Name: `hostname`
	Uptime: $UPTIME_DAYS days, $UPTIME_HOURS hours, $UPTIME_MINUTES minutes

	CPU: `cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d':' -f2`
	Memory: `free -m | head -n 2 | tail -n 1 | awk {'print $2'}`M
	Swap: `free -m | tail -n 1 | awk {'print $2'}`M
	Disk: `df -h / | awk '{ a = $2 } END { print a }'`
	Distro: `lsb_release -s -d` with `uname -r`

	CPU Load: `cat /proc/loadavg | awk '{print $1 ", " $2 ", " $3}'`
	Free Memory: `free -m | head -n 2 | tail -n 1 | awk {'print $4'}`M
	Free Swap: `free -m | tail -n 1 | awk {'print $4'}`M
	Free Disk: `df -h / | awk '{ a = $2 } END { print a }'`

	External Address: `ifconfig ens160 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
	Internal Address: `ifconfig ens192 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
EOF
EOF01

#Make the above executable
sudo chmod +x /etc/update-motd.d/00-logo
sudo chmod +x /etc/update-motd.d/01-info

#Clean out other shell customisations
sed -i.bak '/export PS1/d' $HOME/.bashrc

#Colour for bash
cat <<EOFBASHRC >> ~/.bashrc

MYRED="\[\033[38;5;196m\]"
MYGREY="\[\033[38;5;243m\]"
MYWHITE="\[\033[38;5;15m\]"

export PS1="$MYWHITE[$MYRED\h$MYGREY \u$MYWHITE] [$MYRED\w$MYWHITE] "

EOFBASHRC