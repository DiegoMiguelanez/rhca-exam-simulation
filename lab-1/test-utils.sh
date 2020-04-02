#!/bin/bash

#Constants
EXAM_FILE=".hidden-exam.txt"
#Global variables
keyValue=""
keyState=0

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
        get_keyValue $1

        if [[ $keyValue == $2 ]]
        then
                set_keyState $1 1
        else
                set_keyState $1 0
        fi

}

