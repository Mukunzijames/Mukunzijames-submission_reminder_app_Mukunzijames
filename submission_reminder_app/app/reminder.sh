#!/bin/bash

# Source the config file
source ../config/config.env

# Source the functions file
source ../modules/functions.sh

# Call the check_submissions function
check_submissions "../assets/submissions.txt"

echo "Reminder: The $ASSIGNMENT assignment is due in $DAYS_REMAINING days!"
