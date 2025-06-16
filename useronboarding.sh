#!/bin/bash
#Author: Fayaz Shaik


#1. Take the username as input 
#2. check if user already exists
#3. Create user without home directory or with custom home
#4. Create a password which expires on first login automatically with username+123
#5. Set restricted shell
#6. Create necessary directories
#7. Set permissions
#8. Create symlinks 
#9. Update PATH 
#10. Set environment , git config etc., 


#1. Take the username as input 
read -p "Enter username:" username

#2. check if user already exits 
if id "$username" &> /dev/null;then
   echo "User '$username' already exits."
   exit 1
fi

#3. crate a shell with restricted access. 
#ln -s /bin/bash /bin/rbash
if [ ! -f /bin/rbash ]; then
   ln -s /bin/bash /bin/rbash
   echo "Created symlink:/bin/rbash -> /bin/bash"
else
   echo "Symlink /bin/rbash already exists"
fi

#3. Create user without homedirectory or with custom home 
user_home="/home/$username"
useradd -m -d "$user_home" -s /bin/rbash "$username"

# check if user was created successfully 

if [ $? -ne 0 ]; then
   echo "Failed to create user"
   exit 1
fi

echo "User '$username' created successfully"

#4. set a temporary passwd. 

password=$(openssl rand -base64 12) 
echo $password
echo "$username:$password" |sudo chpasswd

#expire the password to force reset on first login 

sudo chage -d 0 "$username"

echo "Password set and marked for reset on first login" 


