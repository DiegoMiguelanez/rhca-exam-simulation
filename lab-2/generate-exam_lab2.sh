#!/bin/bash

EXAM=exam.txt
HIDDEN_EXAM=.hidden-exam.txt

#fdisk -l /dev/vdb | grep Disklabel | awk "{ print $3 }"
#gpt
#dos
disk_space=1200

question_info () {
	local partition_table_types=( dos gpt )
	
	local partition_table_type=${partition_table_types[$(( $RANDOM % ${#partition_table_types[@]} ))]}
	
	echo "You will need an empty disk with at least $disk_space MG free space and you have to create a $partition_table_type partition table"
}

question_simple-partition () {
	local partition_size=$(($RANDOM % 500 + 10))
	local mount_points=( "/mnt/ironwood" "/myrtle" "/mnt/drake"  "/root/marie"   "/media/fiddlesticks"   "/capricorn"   "/mnt/ora/aurora"   "/flint/willows"   "/root/flint/willows"   "/ocean/stems"   "/home/fairy"   "/home/orchard/bitterwood"  )
	local filesystem_types=( ext4 xfs vfat )
	
	disk_space=$(($disk_space - $partition_size)) 
	local mount_point=${mount_points[$(( $RANDOM % ${#mount_points[@]} ))]}
	local filesystem_type=${filesystem_types[$(( $RANDOM % ${#filesystem_types[@]} ))]}
		
	if [[ $1 == "simple" ]]
	then 
		echo "Create a new $partition_size MB $filesystem_type Physical Partition mounted under $mount_point"
	elif [[ $1 == "swap" ]]
	then

		echo "Create a new partition_size $partition_size MB swap partition and add it to the system to increase systems swap space"
	fi	


}

question_info
question_simple-partition simple
question_simple-partition swap



