#!/bin/bash

#Constants
EXAM_FILE="exam_lab1.txt"
#Global variables
local keyValue=""
local keyState=0

#We pass the key which value we're looking for to set it to keyValue global variable
get_keyValue () {
	keyValue=$(cat $EXAM_FILE | grep $1 | cut -d ":" -f 2)	
}

get_keyState () {
         keyState=$(cat $EXAM_FILE | grep $1 | cut -d ":" -f 3)
}

#Example: set_key-value_completion-state hostname 1
#You have to pass the key's name to change it's completion state column to 1 so we know the user completed the task 
set_keyState () {
	#Set third $EXAM_FILE column completion state to 1
	sed -i "s/$(grep $1 $EXAM_FILE)/$(grep $1 $EXAM_FILE | sed 's/[0-1]$/'$2'/')/" $EXAM_FILE

}

#Test if an element from $EXAM_FILE and a string match
#test_keyValue keyValue string_value
test_keyValue () {
	
	#Add 
	get_key-value $1 

	if [[ $keyValue == $2 ]]
	then	
		set_keyState $1 1
	else
		set_keyState $1 0
	fi

}

#Test default-target
test_keyValue target $(systemctl get-default)	

#Test hostname
test_keyValue hostname $(hostname)


test-network () {
	#We get value for key="connection"
	get_keyValue connection

	for available_connection in $(nmcli connection s | sed '1d' | awk '{print $1}')
		do
			#We compare connection's value with the connection being tested in loop
			if [[ $available_connection == $keyValue ]]
			then
				test_keyValue connection $available_connection
				test_keyValue device $(nmcli c s $available_connection | grep GENERAL.DEVICES | awk '{ print $2 }')
                test_keyValue method $(nmcli c s $available_connection | grep ipv4.method | awk '{ print $2 }')
                test_keyValue address $(nmcli c s $available_connection | grep ipv4.addresses | awk '{ print $2 }' | cut -f 1 -d '/')

			fi
		done		
}


test-network
#printf "%s\n" "${array[@]}"
#for i in array
#	do 
#		echo $i
#	done


#test-network 
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


