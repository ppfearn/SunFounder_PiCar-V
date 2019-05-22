#!/bin/bash
while :
do
        echo "Press [CTRL+C] to stop.."
        tail 10 /var/www/html/admin/log/picar.log.txt > /var/www/html/admin/log/picar.log.txt.old
        cat /var/www/html/admin/log/picar.log.txt.old > /var/www/html/admin/log/picar.log.txt
        sleep 5
done