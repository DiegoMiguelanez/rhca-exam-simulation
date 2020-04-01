#!/bin/bash

#Constants
EXAM_FILE="exam_lab1.txt"
#Global variables
keyValue=""

#We pass the key which value we're looking for to set it to keyValue global variable
get_key-value () {
	keyValue=$(cat $EXAM_FILE | grep $1 | cut -d ":" -f 2)	
}


#Example: set_key-value_completion-state hostname 1
#You have to pass the key's name to change it's completion state column to 1 so we know the user completed the task 
set_key-value_completion-state () {
	#Set third $EXAM_FILE column completion state to 1
	sed -i "s/$(grep $1 $EXAM_FILE)/$(grep $1 $EXAM_FILE | sed 's/[0-1]$/'$2'/')/" $EXAM_FILE

}

#Test if an element from $EXAM_FILE and a string match
evaluate_key-value_against_string () {
	
	get_key-value $1 

	if [[ $keyValue == $2 ]]
	then	
		set_key-value_completion-state $1 1
	else
		set_key-value_completion-state $1 0
	fi

	keyValue=""
}

#Test default-target
evaluate_key-value_against_string target $(systemctl get-default)	

#Test hostname
evaluate_key-value_against_string hostname $(hostname)


#test-network () {

#	for available_connection in $(nmcli connection s | sed '1d' | awk '{ print $1}')
#		do
#			test-function $available_connection $()
#			if [[ $available_connection ==   ]]
#	local connection=$(nmcli connection s | sed '1d' | awk '{ print $1}')
#	local device=$(nmcli connection s | sed '1d' | awk '{ print $4}')
#	local address=$(nmcli c s enp0s4 | grep ipv4.addresses | awk '{ print $2 }')
#	local method=$()
#	local gateway=$()
#	local dns=$()
#}

#Test device and connection
#nmcli connection s | sed '1d' | awk '{ print $1, $4 }'

#[root@viper lab-1]# nmcli c s enp0s4 | grep ipv4.addresses | awk '{ print $2 }'
#>192.168.20.10/32


