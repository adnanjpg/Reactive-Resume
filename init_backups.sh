#!/bin/bash

# Define the path for the new script
NEW_SCRIPT="/tmp/cron_script.sh"
CRON_JOB="0 * * * * $NEW_SCRIPT"


MY_SCRIPT_CODE='docker exec -t "reactive-resume-postgres-1" pg_dumpall -c -U postgres > ~/bac/dump_`date +%Y-%m-%d"_"%H_%M_%S`.sql'

# Create the new bash script
echo '#!/bin/bash' > "$NEW_SCRIPT"
echo $MY_SCRIPT_CODE >> "$NEW_SCRIPT"

# Make the new script executable
chmod +x "$NEW_SCRIPT"

# Check if the cron job already exists
CRON_EXISTS=$(crontab -l | grep -F "$CRON_JOB")

if [ -z "$CRON_EXISTS" ]; then
    # Add the cron job if it does not exist
    (crontab -l; echo "$CRON_JOB") | crontab -
    echo "Cron job added: $CRON_JOB"
else
    echo "Cron job already exists: $CRON_JOB"
fi