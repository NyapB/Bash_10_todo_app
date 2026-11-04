#!/usr/bin/env bash

# Resolve storage file path (use $TODO_FILE if set, otherwise default path)
STORAGE_FILE="${TODO_FILE:-$HOME/.local/share/todo/todo.txt}"

# Helper function to print errors and exit
die() {
    echo "Error: $1" >&2
    exit 1
}

# Ensure storage directory and file exist
init_storage() {
    local dir
    dir=$(dirname "$STORAGE_FILE")
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir" || die "Could not create storage directory: $dir"
    fi
    if [[ ! -f "$STORAGE_FILE" ]]; then
        touch "$STORAGE_FILE" || die "Could not create storage file: $STORAGE_FILE"
    fi
}

# Subcommand: Help
cmd_help() {
    echo "todo.sh - A terminal-based task manager"
    echo
    echo "Usage:"
    echo "  ./todo.sh add [-p low|medium|high] TITLE"
    echo "  ./todo.sh list"
    echo "  ./todo.sh done ID"
    echo "  ./todo.sh delete ID"
    echo "  ./todo.sh help"
}

# Subcommand: Add Task
cmd_add() {
    init_storage

    # Basic check for empty title
    if [[ -z "$*" ]]; then
        die "Missing title."
    fi

    local title="$*"
    local status="todo"
    local priority="medium"
    local next_id=1

    # Only run awk if the file actually has content inside it
    if [[ -s "$STORAGE_FILE" ]]; then
        next_id=$(awk -F'|' 'BEGIN {max=0} {if($1>max) max=$1} END {print max+1}' "$STORAGE_FILE")
    fi

    # Append directly to storage file
    echo "${next_id}|${status}|${priority}|${title}" >> "$STORAGE_FILE" || die "Failed to write to storage file."
    echo "Added task ${next_id}"
}

# Subcommand: List (Stub for Slice 2)
cmd_list() {
    init_storage
    if [[ ! -s "$STORAGE_FILE" ]]; then
        echo "No tasks found."
        return
    fi
    echo "--- Raw Storage Contents ---"
    cat "$STORAGE_FILE"
}

# Main Command Router
if [[ $# -eq 0 ]]; then
    cmd_list
else
    case "$1" in
        add)
            shift
            cmd_add "$@"
            ;;
        list)
            cmd_list
            ;;
        help|--help|-h)
            cmd_help
            ;;
        *)
            die "Unknown subcommand '$1'. Use './todo.sh help' for usage details."
            ;;
    esac
fi
