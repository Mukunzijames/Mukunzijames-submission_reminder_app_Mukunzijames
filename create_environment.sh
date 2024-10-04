#!/bin/bash

# Create main directory and subdirectories
mkdir -p submission_reminder_app/{app,modules,assets,config}

# Create files
touch submission_reminder_app/app/reminder.sh
touch submission_reminder_app/modules/functions.sh
touch submission_reminder_app/assets/submissions.txt
touch submission_reminder_app/config/config.env
touch submission_reminder_app/startup.sh

# Populate submissions.txt with existing and new records
cat << EOF > submission_reminder_app/assets/submissions.txt
Alice Johnson,alice.johnson@example.com,2023-10-01
Bob Smith,bob.smith@example.com,2023-10-02
Charlie Brown,charlie.brown@example.com,2023-10-03
Diana Prince,diana.prince@example.com,2023-10-04
Ethan Hunt,ethan.hunt@example.com,2023-10-05
Frank Castle,frank.castle@example.com,2023-10-06
Grace Hopper,grace.hopper@example.com,2023-10-07
Harry Potter,harry.potter@example.com,2023-10-08
Iris West,iris.west@example.com,2023-10-09
Jack Sparrow,jack.sparrow@example.com,2023-10-10
Lara Croft,lara.croft@example.com,2023-10-11
Max Payne,max.payne@example.com,2023-10-12
Natasha Romanoff,natasha.romanoff@example.com,2023-10-13
Oliver Queen,oliver.queen@example.com,2023-10-14
Peter Parker,peter.parker@example.com,2023-10-15
EOF

# Populate config.env
cat << 'EOF' > submission_reminder_app/config/config.env
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Populate functions.sh
cat << 'EOF' > submission_reminder_app/modules/functions.sh
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Populate reminder.sh
cat << 'EOF' > submission_reminder_app/app/reminder.sh
#!/bin/bash

# Source the config file
source ../config/config.env

# Source the functions file
source ../modules/functions.sh

# Call the check_submissions function
check_submissions "../assets/submissions.txt"

echo "Reminder: The $ASSIGNMENT assignment is due in $DAYS_REMAINING days!"
EOF

# Create startup.sh
cat << 'EOF' > submission_reminder_app/startup.sh
#!/bin/bash

echo "Starting Submission Reminder App..."
cd "$(dirname "$0")/app"
bash reminder.sh
EOF

# Make scripts executable
chmod +x submission_reminder_app/app/reminder.sh
chmod +x submission_reminder_app/startup.sh

echo "Environment setup complete. You can now run the app using ./submission_reminder_app/startup.sh"
