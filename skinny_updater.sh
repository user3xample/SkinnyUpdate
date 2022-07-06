#!/usr/bin/bash
# ############################################################################
# Program name: skinny_updater.sh
# OS: Linux (uses apt not yum)
# Version: 0.0.3
# Author: User3xample
# State: it works.
# Description: Creates log files and updates, upgrades, autoremoves & lists
# Upgradables.
#
# Requirements: needs to be run in sudo or root.  No outside dependencies.
# ############################################################################

#  Start

#  Check we are runing in sudo or root if not exit.
if [ ! ${EUID} -eq 0 ]; then
  echo; echo "$0 : requires to be run in root or with sudo."; echo
  echo "Lets give that one more go, type 'sudo $0' ";echo
  exit  # where we exit 
fi


#  Variables
start=$(date +%m)  # Used to time script, and starts the timer at this point.
long_log=" /opt/updatelogs/update_log.txt"  # Location of our log files
mini_log=" /opt/updatelogs/mini_update_log.txt"
now="$(date)"  # get the date and time
hostDetails="$(hostnamectl)"  # a colection of usefull host details
MyIp="$(ip a | grep global | awk '{print $2}')"  # Outputs our IP addr
broke="$(systemctl list-units --failed)"  # Tells us what services are not running
h_name="Host: $(hostname)"  # outputs the hostname
line="-----------------------------------------------------------------------"
HashLine="#######################################################################"


#  Print to terminal
echo "$HashLine" 
echo "skinny Update Started: $now"
echo "Host Name: $(hostname)" 
echo "$line"


#  Basic log file creation
mkdir -p /opt/updatelogs/  # make directory if required.
echo "Log directory check... done"
touch $long_log  # make a long log file.
touch $mini_log  # make a mini log file.


#  Start the logs
#   long_log
echo "$HashLine" >> $long_log
echo >> $long_log
echo "$now : A skinny update was started. " >> $long_log  # update log file.
echo "Start Log file... done"  # Write to terminal.

#   mini_log
echo $line >> $mini_log
echo "$now : A skinny update was started. " >> $mini_log
echo  "ip: "$MyIp $h_name >> $mini_log
echo "Start mini_Log file... done"


#  Add some usefull details to our long_log file
echo >> $long_log
echo "--- Host Details ---"  >> $long_log
echo >> $long_log
echo "My Ip address currently is: $MyIp " >> $long_log  # update log file with ip addr.
echo "Write IP details to log... done"
echo "$hostDetails" >> $long_log  # update log file with  host details.
echo "Write host details to log... done"
echo "$line" >> $long_log


#  Run our update, upgrade , autoremove & Upgradeable and log

#   Update
echo "--- Update data ---"  >> $long_log  # Our title for the section
echo >> $long_log 
sudo apt autoclean  # Clean our cache out to start with.
sudo apt update | tee >> $long_log  # This reroutes the terminal text into our log file.
echo "Run update... done"  # Terminal update text
echo "$line" >> $long_log  # Draw a line and section of this section

#   Upgrade
echo "--- Upgrade data ---"  >> $long_log
echo >> $long_log
sudo apt -y upgrade| tee >> $long_log
echo "Run upgrade... done"
echo "$line" >> $long_log

#   Autoremove
echo "--- Autoremove data ---"  >> $long_log
echo >> $long_log
sudo apt -y autoremove | tee >> $long_log  
echo "Run autoremove... done"
echo "$line" >> $long_log

#   Upgradeable
echo "--- Upgradable data ---"  >> $long_log
echo >> $long_log
sudo apt -a list --upgradable | tee >> $long_log  
echo "Log upgradable... done"
echo "$line" >> $long_log
echo


#  Log what failed services we have before start.
echo "--- Services listed as failed at the start ---"  >> $long_log
echo >> $long_log
echo $broke >> $long_log
echo "Write the list of failed services @start to log... done"
echo "$line" >> $long_log


#  Log what failed services we have after update.
echo "--- Services Curently listed as failed ---"  >> $long_log
echo >> $long_log
broke="$(systemctl list-units --failed)"  # check again.
echo $broke >> $long_log
echo "Write the list of failed services @end to log... done"
echo "$line" >> $long_log


#  Update The log files

end=$(date +%m)  # Stop our timer
now="$(date)"  # get the date and time.
tellme=$(echo "$end - $start" | bc)
echo "The update took $tellme mins to complete" >> $long_log  # updates us on how long it took.
echo "$now : The skinny update was Finshed." >> $long_log  # update log file.
echo >> $long_log
echo "$now : The skinny update was Finshed." >> $mini_log  # update log file.


#  update terminal
echo "$line"
echo "$now : Finished"
echo "And breathe we are all done, maybe its bench trip time :-) "
echo "$HashLine"


#  test area 
# echo "---autofile clear active---"
# rm $mini_log
# rm $long_log


#  END #############

#----------------------------------------------------------------------------------------
# Notes / ideas

# - Is there a way that we can incoporate the apt mark and unmark cmds to hold back a
#   list of packages to use or skip maybe?
# - Config file?
 
#----------------------------------------------------------------------------------------
# -History-
# 0.0.3 - swapped the timmer around from calling date first before count down stopped.
# 0.0.2 - removed the use of ifconfig and switched to ip in the variable Myip.
# 0.0.1 - Wrote script and added comments and made readable for others.
