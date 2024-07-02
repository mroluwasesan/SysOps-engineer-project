# SysOps-engineer-project
Project for setting up new users to access linux server 

## Purpose:
The script is designed to manage user accounts and groups on a Linux system.
It creates users, assigns them to groups, generates secure passwords, and logs actions.

## Key Actions:
- Root Check: The script checks if it’s run as the root user (superuser) to ensure proper permissions.
Input File: It expects an input file (specified as an argument) containing usernames and associated groups (in the format user;groups).

- User Creation:
Creates a user account for each specified username.
Sets the user’s shell to /bin/bash.

- Group Creation:
Creates a group with the same name as the username.
Adds the user to their personal group.

- Additional Groups:
If additional groups are specified, the script creates those groups and adds the user to them.

- Password Generation:
Generates a random secure password for each user.
Sets the password for the user.

- Logging:
Logs user creation details in the specified log file.
Appends usernames and passwords to a secure password file.

- Permissions:
Sets appropriate permissions (600) for the password file.

## Use Cases:
- System Administration: Useful for system administrators managing user accounts.
- Automation: Can be part of an automated user provisioning process.
- Security Auditing: Helps track user creation and password changes.
