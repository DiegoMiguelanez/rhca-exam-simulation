#!/bin/bash




set-default-target () {
	
	#Create our list of desired targets to be taken in account
	local targets_list=( graphical.target multi-user.target rescue.target)
	
	#Randomly pick one from the list
	default_target=${targets_list[$(( $RANDOM % ${#targets_list[@]} ))]}
	

	echo "1) Set $default_target as system's default target"
}

set-system-hostname () {

	#Create our list of desired targets to be taken in account
        local hostname_list=( claw voodoo zigzag quirk jinx skipper aqua viper serpent wrath)

        #Randomly pick one from the list
        random_hostname=${hostname_list[$(( $RANDOM % ${#hostname_list[@]} ))]}


        echo "2) Set $random_hostname as system's hostname"


}

set-default-target
set-system-hostname

