# SkinnyUpdate
Linux SkinnyUpdate

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
#----------------------------------------------------------------------------------------
# Notes / ideas

# - Is there a way that we can incoporate the apt mark and unmark cmds to hold back a
#   list of packages to use or skip maybe?
# yes there is, this a really old basic script compared to what i ended up making for work.
# i may take another crack at making this again one day.
# - Config file?
 
#----------------------------------------------------------------------------------------
# -History-
# 0.0.3 - swapped the timmer around from calling date first before count down stopped.
# 0.0.2 - removed the use of ifconfig and switched to ip in the variable Myip.
# 0.0.1 - Wrote script and added comments and made readable for others.

