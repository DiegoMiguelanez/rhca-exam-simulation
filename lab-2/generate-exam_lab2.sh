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
	
	echo > $EXAM
	echo "(Block 2)" >> $EXAM

	echo "You will need an empty disk with at least $disk_space MG free space and you have to create a $partition_table_type partition table" >> $EXAM
}

question_simple-partition () {
	local partition_size=$(($RANDOM % 250 + 10))
	local mount_points=( "/mnt/ironwood" "/myrtle" "/mnt/drake"  "/root/marie"   "/media/fiddlesticks"   "/capricorn"   "/mnt/ora/aurora"   "/flint/willows"   "/root/flint/willows"   "/ocean/stems"   "/home/fairy"   "/home/orchard/bitterwood"  )
	local filesystem_types=( ext4 xfs vfat )
	
	disk_space=$(($disk_space - $partition_size)) 
	local mount_point=${mount_points[$(( $RANDOM % ${#mount_points[@]} ))]}
	local filesystem_type=${filesystem_types[$(( $RANDOM % ${#filesystem_types[@]} ))]}
		
	if [[ $1 == "simple" ]]
	then 
		echo "1) Create a new $partition_size MB $filesystem_type Physical Partition mounted under $mount_point" >> $EXAM
	elif [[ $1 == "swap" ]]
	then

		echo "2) Create a new partition_size $partition_size MB swap partition and add it to the system to increase systems swap space" >> $EXAM
	fi	


}

question_lvm () {

	local vg_size=$(($RANDOM % 250 + 10))
	local mount_points=( "/mnt/zeta" "/eridanus" "/mnt/sagitta"  "/root/galaxy"   "/media/starsystem"   "/jellyfish"   "/mnt/dc-96"   "/draconis/capella"   "/root/fv-642"   "/strawberry/nebula"   "/home/BNH-51B"   "/home/epsilon/delta"  )

	local volume_groups=( vg_lion vg_lightbulb vg_delta vg_epsilon vg_zagreus vg_nebula vg_zodiak vg_alatheia vg_ursa )
	local logical_volumes=( lv_thetha lv_sagittarius lv_eridani lv_orion lv_ichnaea lv_asteropaios lv_oculus lv_virgo lv_librae lv_sirius )
	local filesystem_types=( ext4 xfs vfat )


	#####################
	
	local lv_size=$(( $RANDOM % $vg_size + 20 ))
	local mount_point=${mount_points[$(( $RANDOM % ${#mount_points[@]} ))]}
	local volume_group=${volume_groups[$(( $RANDOM % ${#volume_groups[@]} ))]}
	local mount_point=${mount_points[$(( $RANDOM % ${#mount_points[@]} ))]}
	local logical_volume=${logical_volumes[$(( $RANDOM % ${#mount_points[@]} ))]}
	local filesystem_type=${filesystem_types[$(( $RANDOM % ${#filesystem_types[@]} ))]}

	######################
	echo "3) Create a volume group called $volume_group with $vg_size MG and a logic volume called $logical_volume of $lv_size $filesystem_type mounted under $mount_point" >> $EXAM



}


question_info
question_simple-partition simple
question_simple-partition swap
question_lvm


