#!/bin/bash

#---------------------------------------------------------------------
#
# Copyright © 2014 Joerg Tinner
#
# Author: Jörg Tinner <joerg.tinner@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Script to execute commands what need an IP, instead with a Mac-Address
#
# Notes:
# I hope that will solve the "computer name"-Problem in Linux. Made for
# people using DHCP (with changing IP's) without running their own DNS. 
# 
# Dependencies:
#    ifconfig
#    ping
#    arp
#


# Proof syntax
if [ -z "$2" ]; then
	echo
	echo "Running programs with the MAC instead of the IP."
	echo
	echo "SYNTAX: mac2ip MAC \"CMD\""
	echo 
	echo "MAC - is the Mac-Address (or distinctive[!] part)"
	echo "      you want to get substituted by the related IP."
	echo "CMD - is the command you want to execute. Please write"
	echo "      it in quotes and use \"IP\" instead of the IP."
	echo
	echo "Examples: mac2ip A1:B2:C3:D4:E5:F6 \"ssh root@IP\""
	echo "          mac2ip B2:C3:D4 \"vncviewer IP:1\""
	echo "          mac2ip A1:B2:C3:D4:E5:F6 \"krdc IP\""
	echo "Tip:      mac2ip x x (will give you a MAC list.)"
        echo "Note:     depends on ping, ifconfig and arp."
else
	# Cut matching IP from arp (TIP - Target IP)
	TIP=`arp | grep $1 | cut -d' ' -f1`

	# If MAC already exists in arp table, skip this...
	if [ -z "$TIP" ]; then
	
		# Getting IP and subnet from ifconfig
		myIP=`ifconfig | grep Bcast | cut -d':' -f 2 | cut -d' ' -f 1`
		echo "Your IP: "$myIP
		SUB=`echo $myIP | cut -d'.' -f1-3`.

		# Ping subnet to complete arp information
		echo "(To add another subnet, edit ADDITIONAL SUBNET section.)"
		echo -n "Gathering informations in subnet "$SUB
		for a in {1..254}
		do
		  ping -c 1 $SUB$a > null &
		done

		# To ping ADDITIONAL SUBNET to complete arp information
		# edit next line! (Copy this block for more subnets)
		# SUB=192.168.3.
		# echo -n "Ping subnet "$SUB
		# for a in {1..254}
		# do
		#   ping -c 1 $SUB$a > null &
		# done

		# Wait for ping to be done
		while pgrep ping > /dev/null; 
			do sleep 1;
			echo -n .
		done

		# Wait for arp to be done
		ARP="00:00:00:00:00:00"
		while [ ! -z "$ARP" ]; do 
			ARP=`cat /proc/net/arp | grep 00:00:00:00:00:00`;
			sleep 1;
	  		echo -n .;
		done

		# Line feed
		echo

		# Cut matching IP from arp
		TIP=`arp | grep $1 | cut -d' ' -f1`
	fi

	# if MAC is not in the list
	if [ -z "$TIP" ]; then
		# show arp list
		arp
		echo "MAC $1 not known!"
	else 
		# show MAC --> IP
		echo $1 "-->" $TIP

		# Replace MAC with IP
		CMD=$2
		CMD=${CMD/IP/$TIP}
		echo "Command: "$CMD

		# Execute command
		bash -c "$CMD"
	fi
fi
echo

# insert this in your script to see error massages
# sleep 5

# ... or this
# read
