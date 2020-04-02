#!/bin/bash

#Set persistent text field to hold different values required by the exam for generation an evaluation
EXAM=exam.txt
HIDDEN_EXAM=.hidden-exam.txt
question_default-target () {
	
	#Create our list of desired targets to be taken in account
	local targets_list=( graphical.target multi-user.target rescue.target)
	
	#Randomly pick one from the list
	default_target=${targets_list[$(( $RANDOM % ${#targets_list[@]} ))]}
	
	#Update persistent exam textfile exam.txt
#	sed -i "s/target:.*/target:$default_target/" $exam_lab1_file	

	echo "1) Set $default_target as system's default target" >> $EXAM
	echo "target:$default_target:0" >> $HIDDEN_EXAM
}

question_system-hostname () {

		#Create our list of desired targets to be taken in account
        local hostname_list=( claw voodoo zigzag quirk jinx skipper aqua viper serpent wrath)

        #Randomly pick one from the list
        random_hostname=${hostname_list[$(( $RANDOM % ${#hostname_list[@]} ))]}

		#Update persistent exam textfile exam.txt
 #       sed -i "s/hostname:.*/hostname:$random_hostname/" $exam_lab1_file


        echo "2) Set $random_hostname as system's hostname" >> $EXAM
	echo "hostname:$random_hostname:0" >> $HIDDEN_EXAM

}

question_network-configuration () {

	local dns_servers=( 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112 1.1.1.1 1.0.0.1 )
	local connections=( gawyn gale persivell huchon seri ludovicus zane )
	local interfaces
	for i in $(nmcli d s | sed '1d' | grep enp | cut -f 1 -d " ")
		do 
			interfaces+=($i)
		done
	
	interface=${interfaces[$(( $RANDOM % ${#interfaces[@]} ))]}			
	ip="192.168.20.$(( $RANDOM % 100 + 2 ))"
	connection=${connections[$(( $RANDOM % ${#connections[@]} ))]}
	dns_server=${dns_servers[$(( $RANDOM % ${#dns_servers[@]} ))]}

	echo "3) Create a new connection named: $connection via $interface device with static ip: $ip and dns: $dns_server" >> $EXAM
	echo "address:$ip:0" >> $HIDDEN_EXAM
	echo "device:$interface:0" >> $HIDDEN_EXAM
	echo "connection:$connection:0" >> $HIDDEN_EXAM
	echo "method:manual:0" >> $HIDDEN_EXAM
	echo "dns:$dns_server:0" >> $HIDDEN_EXAM
}

question_masked-units () {
	echo "4) Mask units named.service and systemd-timedated.service" >> $EXAM
}

create_empty-exam () {
	echo > $EXAM
	echo > $HIDDEN_EXAM
	echo "0) Break into the system to proceed with the exam" >> $EXAM
	question_default-target 
	question_system-hostname 
	question_network-configuration
	question_masked-units
}

create_empty-exam
