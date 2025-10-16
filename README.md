# Submission Reminder App

A shell-based application that helps track and remind students who haven't submitted their assignments. The app reads from a submissions file and generates reminders for students with pending submissions.

## Overview

This project contains two main scripts that work together to set up and run a submission reminder system:

1. **Environment Setup Script** - Creates the complete application structure
2. **Copilot Script** - Runs the application with dynamic assignment configuration

## Scripts

### 1. create_environment.sh

This script sets up the entire project structure and generates all necessary files for the submission reminder application.

**What it does:**

- Prompts for a user name to create a personalized directory
- Creates a directory structure: `submission_reminder_<name>/`
  - `app/` - Contains the main reminder application
  - `modules/` - Contains reusable shell functions
  - `assets/` - Contains the submissions data file
  - `config/` - Contains configuration and environment variables
- Generates the following files:
  - `config/config.env` - Configuration file with assignment name and days remaining
  - `modules/functions.sh` - Shell functions for checking submissions
  - `assets/submissions.txt` - Sample student submission data
  - `app/reminder.sh` - Main application that processes and displays reminders
  - `startup.sh` - Entry point script that launches the application
- Sets executable permissions on all shell scripts

**Usage:**

```bash
./create_environment.sh
```

You'll be prompted to enter your name, and the script will create a complete working environment.

**Example:**

```bash
$ ./create_environment.sh
Enter your name: john
Creating directory structure in: submission_reminder_john
Setting executable permissions...
Environment setup complete
To test the application, run:
cd submission_reminder_john && ./startup.sh
```

### 2. copilot_shell_script.sh

This script provides a convenient way to update the assignment name and run the reminder application.

**What it does:**

- Automatically finds the `submission_reminder_*` directory
- Prompts for an assignment name to check
- Updates the `config/config.env` file with the new assignment name
- Executes the `startup.sh` script to show reminders for students who haven't submitted that assignment

**Usage:**

```bash
./copilot_shell_script.sh
```

**Example:**

```bash
$ ./copilot_shell_script.sh
Found directory: ./submission_reminder_john
Enter the assignment name: Shell Navigation
Assignment updated successfully to: Shell Navigation
Running startup.sh to check submission status...
Starting reminder app...
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ../assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
Application execution completed.
```

## Project Structure

After running `create_environment.sh`, the generated structure looks like this:

```
submission_reminder_<name>/
├── app/
│   └── reminder.sh          # Main application script
├── modules/
│   └── functions.sh         # Reusable functions (check_submissions)
├── assets/
│   └── submissions.txt      # Student submission data (CSV format)
├── config/
│   └── config.env          # Configuration file
└── startup.sh              # Application entry point
```

## How It Works

1. **Configuration**: The `config/config.env` file stores the assignment name and days remaining
2. **Data Source**: The `assets/submissions.txt` file contains student records in CSV format:
   ```
   student, assignment, submission status
   ```
3. **Processing**: The `check_submissions` function in `modules/functions.sh` reads the CSV file and filters students who haven't submitted the specified assignment
4. **Execution**: The `reminder.sh` script sources the config and functions, then generates reminders
5. **Startup**: The `startup.sh` script serves as the entry point and executes the reminder application

## Quick Start

1. Create the environment:

   ```bash
   ./create_environment.sh
   ```

2. Run the application:

   ```bash
   ./copilot_shell_script.sh
   ```

3. Or manually navigate and run:
   ```bash
   cd submission_reminder_<your_name>
   ./startup.sh
   ```

## Customization

### Adding Students

Edit the `assets/submissions.txt` file to add or modify student records:

```csv
student, assignment, submission status
John Doe, Shell Navigation, submitted
Jane Smith, Git, not submitted
```

### Changing Assignment

You can either:

- Run `./copilot_shell_script.sh` and enter the assignment name
- Manually edit `config/config.env` and update the `ASSIGNMENT` variable

### Modifying Days Remaining

Edit `config/config.env`:

```bash
DAYS_REMAINING=5
```

## Requirements

- Bash shell (macOS, Linux, or WSL on Windows)
- Basic Unix utilities (sed, find, chmod)

## Notes

- The `copilot_shell_script.sh` uses `sed -i ''` which is macOS-specific. For Linux, change it to `sed -i`
- All scripts use `#!/bin/bash` shebang and should be executable
- The CSV parser in `functions.sh` handles whitespace and skips the header row
