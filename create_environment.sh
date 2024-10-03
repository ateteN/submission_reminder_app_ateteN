mkdir -p submission_reminder_app/app
mkdir -p submission_reminder_app/modules
mkdir -p submission_reminder_app/assets
mkdir -p submission_reminder_app/config

echo "Directories are well  created!"

touch submission_reminder_app/app/reminder.sh
touch submission_reminder_app/modules/functions.sh
touch submission_reminder_app/assets/submissions.txt
touch submission_reminder_app/config/config.env
touch submission_reminder_app/startup.sh

echo "Files are also created!"

echo 'ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' > submission_reminder_app/config/config.env

echo '#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
                                                      
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file' > submission_reminder_app/app/reminder.sh


echo '#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is "not submitted"
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' > submission_reminder_app/modules/functions.sh
echo '#!/bin/bash

# Step 1: Make sure we are in the correct directory
cd "$(dirname "$0")"

# Step 2: Start the reminder app
echo "Starting the Reminder App..."

# Execute the reminder script
bash ./app/reminder.sh

echo "Reminder App has been executed successfully!"' > submission_reminder_app/startup.sh

cat <<EOL >> submission_reminder_app/assets/submissions.txt
Student Name, Assignment, Status
Beyonce Queenofpop, Shell Navigation, not submitted
2pack Shakur, Shell Navigation, submitted
Jay Z, Shell Navigation, not submitted
Princess Aliyaah, Shell Navigation, submitted
Sean Diddy Combs, Shell Navigation, not submitted
EOL

echo "Submission  with new records!"

chmod +x submission_reminder_app/startup.sh
