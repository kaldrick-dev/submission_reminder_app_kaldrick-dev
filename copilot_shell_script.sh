#!/bin/bash

# Find the submission_reminder_* directory
SUBMISSION_DIR=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

if [ -z "$SUBMISSION_DIR" ]; then
    echo "Error: No submission_reminder_* directory found!"
    echo "Try running ./create_environment first."
    exit 1
fi

echo "Found directory: $SUBMISSION_DIR"

# Prompt user to enter the assignment name
read -p "Enter the assignment name: " assignment

# Check if assignment name is empty
if [ -z "$assignment" ]; then
    echo "Error: Assignment name cannot be empty!"
    exit 1
fi

# Check if config/config.env exists
if [ ! -f "$SUBMISSION_DIR/config/config.env" ]; then
    echo "Error: $SUBMISSION_DIR/config/config.env file not found!"
    echo "Try running ./create_environment and re-run the script. "
    exit 1
fi

sed -i '' "2s/^ASSIGNMENT=.*/ASSIGNMENT=\"$assignment\"/" "$SUBMISSION_DIR/config/config.env"

echo "Assignment updated successfully to: $assignment"

# Check if startup.sh exists
if [ ! -f "$SUBMISSION_DIR/startup.sh" ]; then
    echo "Error: $SUBMISSION_DIR/startup.sh not found!"
    exit 1
fi

echo "Running startup.sh to check submission status..."
cd "$SUBMISSION_DIR" && ./startup.sh
