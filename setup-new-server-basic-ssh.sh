# meant to be run on a brand new VPS
# creates a sudoer user, allows only them to login via ssh, and only with key auth
# sets a new root password and disables root ssh login

# don't save shell history for this script
set +o history

echo -n "Enter password for root (should be 32 random chars):" && read -s rootpw
echo "root:$rootpw" | chpasswd
echo -n "Enter username for the non-root user (will be added to sudoers):" && read username
echo -n "Enter password for $username: " && read -s userpw
echo

# create the new user and set the pw
useradd -m -U -s /bin/bash "$username"
echo "user $username created"
echo "$username:$userpw" | chpasswd
echo "password for $username set"
echo "$username ALL=(ALL:ALL) ALL" >> "/etc/sudoers.d/$username"
chmod 600 "/etc/sudoers.d/$username"
echo "$username added to sudoers"

# prompt the user to copy the SSH pubkey to the server
echo -n "Use ssh-copy-id to copy your SSH public key to $username@hostname, and ensure that you can SSH to the server with the pubkey. If you cannot, open a new SSH session, leaving this one open, and correct it. Press enter when complete" && read
echo

# set SSH settings
sed -i 's/^#*PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
if grep -q "^AllowUsers" /etc/ssh/sshd_config; then
    # If AllowUsers already exists, append the new user
    sed -i "/^AllowUsers/ s/$/ $username/" /etc/ssh/sshd_config else
    # If AllowUsers doesn't exist, add it
    echo "AllowUsers $username" >> /etc/ssh/sshd_config
fi
echo "sshd settings written"

# reload the sshd daemon to take effect
service sshd reload
echo "sshd reloaded"

echo "ssh setup complete"
