#!/bin/bash
#Author: Fayaz Shaik

#1. remove the user along with user directory 
#read -p "Enter username to be removed:" username

#2. delete the user along with the home directory 

#userdel -r $username


while IFS= read -r username; do
  if id "$username" &> /dev/null; then
	sudo userdel -r "$username"
	echo "Deleted user: $username"
  else
     echo "User $username doesnot exist"
  fi
done < users_to_delete.txt
