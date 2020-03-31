#!/bin/bash

#Set persistent text field to hold different values required by the exam for generation an evaluation
exam_lab1_file="exam_lab1.txt"

set-default-target () {
	
	#Create our list of desired targets to be taken in account
	local targets_list=( graphical.target multi-user.target rescue.target)
	
	#Randomly pick one from the list
	default_target=${targets_list[$(( $RANDOM % ${#targets_list[@]} ))]}
	
	#Update persistent exam textfile exam.txt
	sed -i "s/target:.*/target:$default_target/" $exam_lab1_file	

	echo "1) Set $default_target as system's default target"
}

set-system-hostname () {

	#Create our list of desired targets to be taken in account
        local hostname_list=( claw voodoo zigzag quirk jinx skipper aqua viper serpent wrath)

        #Randomly pick one from the list
        random_hostname=${hostname_list[$(( $RANDOM % ${#hostname_list[@]} ))]}

	#Update persistent exam textfile exam.txt
        sed -i "s/hostname:.*/hostname:$random_hostname/" $exam_lab1_file


        echo "2) Set $random_hostname as system's hostname"


}

set-default-target
set-system-hostname

