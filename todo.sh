#!/bin/bash

TODO_FILE="todo_tasks.txt"

display_tasks() {
    echoter task title: " title
    read -p "Enter description: " description
    read -p "Enter location: " location
    read -p "Enter due date (YYYY-MM-DD): " due_date
    echo "$title "Tasks for today:"
    echo "Completed Tasks:"
    grep "$(date +%Y-%m-%d)" "$TODO_FILE" | grep -w "DONE"
    echo "Uncompleted Tasks:"
    grep "$(date +%Y-%m-%d)" "$TODO_FILE" | grep -v "DONE"
}

create_task() {
    echo "Creating a new task..."
    read -p "En,$description,$location,$due_date,PENDING" >> "$TODO_FILE"
}

update_task() {
    read -p "Enter task title to update: " title
    grep -v "$title" "$TODO_FILE" > tmpfile && mv tmpfile "$TODO_FILE"
    echo "Enter new details for the task"
    create_task
}

delete_task() {
    read -p "Enter task title to delete: " title
    grep -v "$title" "$TODO_FILE" > tmpfile && mv tmpfile "$TODO_FILE"
}

list_tasks() {
    read -p "Enter the date (YYYY-MM-DD) to list tasks for: " date
    echo "Completed tasks on $date:"
    grep "$date" "$TODO_FILE" | grep "DONE"
    echo "Uncompleted tasks on $date:"
    grep "$date" "$TODO_FILE" | grep "PENDING"
}

search_task() {
    read -p "Enter task title to search for: " title
    grep "$title" "$TODO_FILE"
}

mark_completed() {
    read -p "Enter task title to mark as completed: " input_title
    temp_file=$(mktemp)
    
    found=0  
    while IFS=, read -r id t desc loc due status
    do
        
        if [[ "${t,,}" == "${input_title,,}" && "$status" != "DONE" ]]; then
            echo "$id,$t,$desc,$loc,$due,DONE" >> "$temp_file"
            found=1
        else
            echo "$id,$t,$desc,$loc,$due,$status" >> "$temp_file"
        fi
    done < "$TODO_FILE"

    if [ $found -eq 1 ]; then
        mv "$temp_file" "$TODO_FILE"
        echo "Task marked as completed."
    else
        rm "$temp_file"
        echo "Task not found or already completed."
    fi
}

case "$1" in
    create)
        create_task
        ;;
    update)
        update_task
        ;;
    delete)
        delete_task
        ;;
    list)
        list_tasks
        ;;
    search)
        search_task
        ;;
   complete)
        mark_completed
        ;;
    *)
        display_tasks
        ;;
esac
