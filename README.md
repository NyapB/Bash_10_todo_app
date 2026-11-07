# Day 10: To-do App

A lightweight, terminal-native task management application designed for developers to manage their daily workflows directly inside their favorite shell environments.

## Features

- Priority Sorting: Organizes tasks automatically by sorting high-priority items to the top.
- Safe State Manipulation: Uses atomic operations with temporary files ( mv ) to update or purge items safely.
- Robust Input Validation: Rejects delimiter injection (the  |  character) and invalid flag sequences.
- Flexible Environment Overrides: Respects the  $TODO_FILE  environment variable configuration.

---

## Installation & Setup

1. Make the script executable:

```bash
   chmod +x todo.sh
   ```

2.(Optional) Run the script globally by linking it to your local binary folder or alias it in your shell profile:

  ```bash
   alias todo=" ./todo.sh "
   ```

---

## Subcommands & Usage

### 1. help Displays the usage banner and command flags

- syntax: ./todo.sh help (or --help , -h )
- Example:

    ```bash
    \$ ./todo.sh help
    todo.sh - A terminal-based task manager

    Usage:
      ./todo.sh add [-p low|medium|high] TITLE
      ./todo.sh list
      ./todo.sh done ID
      ./todo.sh delete ID
      ./todo.sh help
    ```

### 2. add

Creates a new task. Assigns a status of `todoand increments the ID automatically from the highest current record.

- Syntax: ./todo.sh add [-p low|medium|high] TITLE `

- Examples:

    ```bash
    \$ ./todo.sh add Read the awk chapter
    Added task 1

    \$ ./todo.sh add -p high Submit Day 9 fixes
    Added task 2
    ```

### 3. list

Prints all tracking rows organized in clean, space-aligned columns. High-priority tasks always float to the top of the output table regardless of creation order. If no entries exist, a friendly fallback notice is shown.

- Syntax: ./todo.sh list (or invoke ./todo.sh without arguments)

-Example:

```bash
    \$ ./todo.sh list
    ID   STATUS   PRIORITY  TITLE
    2    todo     high      Submit Day 9 fixes
    1    todo     medium    Read the awk chapter
```

### 4. done

Marks a specific task item as completed by swapping its internal status state string to done.

- Syntax: ./todo.sh done ID
- Example:

    ```bash
    \$ ./todo.sh done 1
    Task 1 done
    ```

### 5. delete

Completely scrubs and drops a target line path row entirely from the underlying system storage.

Syntax: ./todo.sh delete ID
Example:

```bash
    \$ ./todo.sh delete 1
    Task 1 deleted
```

---

## Custom Database Storage Overrides

By default, data saves inside the user workspace folder path:
~/.local/share/todo/todo.txt

To point data manipulation pipelines to an alternative sandbox environment dynamically, export the $TODO_FILE path sequence:

```bash
export TODO_FILE=" /tmp/my_test_todos.txt "
./todo.sh add " Run production database stress checks "
```
