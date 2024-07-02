#!/bin/bash
# This is a script to add users and groups, set up home directories, generate passwords, and log actions

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Please run as root."
    exit 1
fi

# Input file containing usernames and groups (format: user;groups)
INPUT_FILE="$1"
PASSWORD_FILE="/var/secure/user_passwords.csv"
LOG_FILE="/var/log/user_management.log"


# Creating log file if it doesn't exist
touch "$LOG_FILE"

# Function to generate a random password
generate_password() {
     tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/urandom | head -c 8
}

# Running through the list of users in the txt file
while IFS=';' read -r username groups; do
    # Creating user
    useradd -m -s /bin/bash "$username" &>> "$LOG_FILE"

    # Creating group with the same name as the username
    groupadd "$username" &>> "$LOG_FILE"

    # Adding user to personal group
    usermod -aG "$username" "$username" &>> "$LOG_FILE"

    # checking to see if user has additional groups 
    IFS=',' read -ra group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        groupadd "$group" &>> "$LOG_FILE"
        usermod -aG "$group" "$username" &>> "$LOG_FILE"
    done

    # Generating and set password
    password=$(generate_password)
    echo "$username:$password" | chpasswd &>> "$LOG_FILE"

    # Log user creation details
    echo "User '$username' created with groups: $groups" >> "$LOG_FILE"

    # Append username and password to the secure password file
    echo "$username,$password" >> "$PASSWORD_FILE"
done < "$INPUT_FILE"

# Set permissions for password file
chmod 600 "$PASSWORD_FILE"

echo "User creation completed." 
echo "You can find details logs in $LOG_FILE."
echo "Passwords is securely stored in $PASSWORD_FILE."