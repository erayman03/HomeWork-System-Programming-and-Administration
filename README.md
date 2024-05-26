# Todo Project

## Overview
This project is a simple command-line todo list manager written in bash. It allows users to manage their tasks by creating, updating, deleting, listing, searching, and marking tasks as completed. The tasks are stored in a text file named `todo_tasks.txt`.

## Design Choices
### Data Storage
Tasks are stored in a plain text file (`todo_tasks.txt`) with each task on a new line. Each task has fields separated by commas:
- **title**: The title of the task.
- **description**: A brief description of the task.
- **location**: The location where the task needs to be performed.
- **due date**: The due date of the task in `YYYY-MM-DD` format.
- **status**: The status of the task, either `PENDING` or `DONE`.

### Code Organization
The script is organized into functions for each major operation:
- `display_tasks`: Displays today's tasks, separated into completed and uncompleted.
- `create_task`: Prompts the user to enter task details and appends the task to the `TODO_FILE`.
- `update_task`: Prompts the user to update an existing task by title.
- `delete_task`: Prompts the user to delete a task by title.
- `list_tasks`: Lists tasks for a specific date.
- `search_task`: Searches for a task by title.
- `mark_completed`: Marks a task as completed by updating its status.

A case statement at the end of the script handles command-line arguments to call the appropriate function.

