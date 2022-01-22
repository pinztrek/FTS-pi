#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive

echo "FTS script: setup.sh start" `date`

echo "FTS script: disable unattended upgrades for now"
# disable unattended upgrades for now
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer

# leave cloud-init installed for now. iscsi removal triggers kernel rebuild, don't remove
echo "FTS script: cleanup cloud-init files"
# apt-get -y purge\
#  cloud-init cloud-guest-utils\
#  cloud-initramfs-copymods cloud-initramfs-dyn-netconf\
#  open-iscsi
# rm -rf /etc/cloud/ /var/lib/cloud/

echo "FTS script: update package index"
apt-get update

#apt-get -y\
#-o Dpkg::Options::="--force-confdef"\
# -o Dpkg::Options::="--force-confold"\
# upgrade

echo "FTS script: install key packages"
apt-get -y install\
 wget vim net-tools
 

# Workaround for usbmount bug on Bionic
#mkdir -p /etc/systemd/system/systemd-udevd.service.d
#echo "[Service]\nMountFlags=shared\n" >\
# /etc/systemd/system/systemd-udevd.service.d/override.conf
#systemctl daemon-reload
#service systemd-udevd --full-restart

# Install FTS
echo `date` "Installing FTS"
su - fts -c "wget -qO - https://raw.githubusercontent.com/FreeTAKTeam/FreeTAKHub-Installation/main/scripts/easy_install.sh | bash"
#su - fts -c "w"
echo `date` "FTS install completed"

# reset sudoers back to a reasonable value
# Note this overrides any settings made in user-data cloud-init
echo "FTS script: reset sudoers back to reasonable default"

echo "fts ALL=NOPASSWD: /sbin/shutdown, /sbin/reboot, /bin/ls, /bin/cat" \
    > /etc/sudoers.d/90-cloud-init-users

echo "FTS script: *** setup.sh run complete ***" `date`
