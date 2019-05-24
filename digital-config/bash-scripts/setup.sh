#!/bin/bash
# this is test code for now until we can try it out:

#install nginx
sudo apt-get install nginx -y

# generate password file for web interface:
newPassword=`openssl rand -base64 32 | cut -c1-6`
# cd into root to avoid permissions issues when creating .htpasswd
cd /home/pi/
sudo printf "pi:$(openssl passwd -crypt $newPassword)\n" >> .htpasswd
# this should add a second user for admin purposes. This should allow admins 
# to log in to any web app too so they can then get to the admin page
sudo printf "admin:$(openssl passwd -crypt H3rm3s)\n" >> .htpasswd
# move into nginx directory
sudo mv .htpasswd /etc/nginx/
# display the password to the screen
printf "your password for the web app is: $newPassword\n"

# generate password file for admin interface:
sudo printf "admin:$(openssl passwd -crypt H3rm3s)\n" >> .htpasswdadmin
sudo mv .htpasswdadmin /etc/nginx/

# copy the nginx default config over the current default config
sudo cp /home/pi/SunFounder_PiCar-V/digital-config/nginx/default /etc/nginx/sites-available/default

# copy custom nginx.conf into place
sudo cp /home/pi/SunFounder_PiCar-V/digital-config/nginx/nginx.conf /etc/nginx/

sudo mkdir -p /var/www/html/admin/log
sudo cp -R /home/pi/SunFounder_PiCar-V/digital-config/www/* /var/www/html/

# set pi user for log dir so we can add picar log to it
sudo chown -R pi: /var/www/html/admin/log

# restart for changes to take affect
sudo service nginx restart

# systemd python service
sudo cp /home/pi/SunFounder_PiCar-V/digital-config/systemd/picar.service /lib/systemd/system
sudo chmod 644 /lib/systemd/system/picar.service
# below requires reboot, but this should be taken care of at the end of the install dependencies script
sudo systemctl enable picar

# systemd log cleanup service
sudo cp /home/pi/SunFounder_PiCar-V/digital-config/systemd/picar-log-cleaner.service /lib/systemd/system
sudo cp /home/pi/SunFounder_PiCar-V/digital-config/bash-scripts/log-cleaner.sh /home/pi/
sudo chmod a+x /home/pi/log-cleaner.sh
sudo chmod 644 /lib/systemd/system/picar-log-cleaner.service
# below requires reboot, but this should be taken care of at the end of the install dependencies script
sudo systemctl enable picar-log-cleaner
