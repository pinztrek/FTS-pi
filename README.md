# FTS-pi
## cloud-init files to setup a FTS Ubuntu server on raspberry pi

### The two configuration files inform cloud-init to automatically setup an FTS server including the following steps:

- Create an FTS user, with appropriate permissions
- Change the host name to FTS
- Configure Wi-Fi if desired.  
*(Edit ***user-data*** carefully, it's yaml and extremely picky about spaces and tabs! Use of a smart editor like *code* is recommended)*
- Inhibit unattended upgrades which is a problem on the default Ubuntu distribution when trying to install FTS
- Inhibit cloud-net from future execution
- Tune sshd
- Install key packages needed to execute the FTS install script
- Call the one touch FTS install script

### Usage:
- Flash the Ubuntu 20.04 server image for raspberry pi (64 bit version)
- Remove your SD card, then reinsert  
You'll see some error messages about partitions, you can close those out
- You should now see a drive with a name of system-boot. This is the boot partition on the sd card. 
- There should be a file down at the very bottom called user-data. And no setup.sh file.
- Copy the two files (*user-data* and *setup.sh*) into the boot partition. It should replace the default user-data.
- After it completes writing eject the SD card
- Boot the SD card. If you have access to the console you'll be able to follow the installation. Otherwise look for it on your network, using ping as needed

### Once you see it on the network you can SSH in as the FTS user
> *ssh -l fts 192.168.x.x*

- The default password is *deadparrot*, you will be prompted to change it after first login.

- You can review the results of the cloud-net configuration run in:  
 */var/log/cloud-init-output.log*

If you think it still running you can use tail -f on that file to watch it execute:
> *tail -f /var/log/c\*out\*log*
