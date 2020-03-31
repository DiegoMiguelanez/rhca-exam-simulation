#!/bin/bash

user=$1

list=( ja Ka ma Sa Rex TO per stack 23 234 52 sok q2 qdf 23 SER3wr 243 )

#Generate our own password from a custom list
generate_password () {
	random1=$(( $RANDOM % ${#list[@]} ))
	random2=$(( $RANDOM % ${#list[@]} ))
	pass="${list[$random1]}${list[$random2]}"
}

change_user_password () {
	echo "Nueva pass: $pass"
	echo $pass | passwd $user --stdin
}

