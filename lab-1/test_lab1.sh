#!/bin/bash
source test-utils.sh
#Test default-target
test_default-target () {
	test_keyValue target $(systemctl get-default)	
}

#Test hostname
test_hostname () {
	test_keyValue hostname $(hostname)
}

test-network () {
	#We get value for key="connection"
	get_keyValue connection

	for available_connection in $(nmcli connection s | sed '1d' | awk '{print $1}')
		do
			#We compare connection's value with the connection being tested in loop
			if [[ $available_connection == $keyValue ]]
			then
				test_keyValue connection $available_connection
				test_keyValue device  $(nmcli c s $available_connection | grep GENERAL.DEVICES | awk '{ print $2 }')
		                test_keyValue method  $(nmcli c s $available_connection | grep ipv4.method     | awk '{ print $2 }')
		                test_keyValue address $(nmcli c s $available_connection | grep ipv4.addresses  | awk '{ print $2 }' | cut -f 1 -d '/')
                                test_keyValue dns     $(nmcli c s $available_connection | grep ipv4.dns        | awk '{ print $2 }' | cut -f 1 -d '/')

			fi
		done		
}

test_default-target
test_hostname
test-network

