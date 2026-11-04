#!/bin/bash

Usage() {
    cat <<EOF
Usage: $0 [command] [options]
commands:
    add [-p low|medium|high] TITLE    Add a new task
    list                                list all tasks
    done ID                             Mark a task as done
    delete ID                           Delete  a task
    help                                Show this help message
EOF
exit 1
}

cmd_add() {
    echo "Placeholder: "
}

cmd_list(){
    echo "Placeholder:"
}

cmd_done(){
    echo "Placeholder:"
}

cmd_delete() {
    echo "Placeholder:"
}

cmd_help(){
    Usage
}
#default to list if no arguments are provided
subcommand="${1:-list}"
if [[ $# -gt 0 ]]; then
    shift
fi

case $subcommand in
    add) 
        cmd_add "$@"
        ;;
    list) 
        cmd_list "$@"
        ;;
    done)
        cmd_done "$@"
        ;;
    delete)
        cmd_delete "$@"
        ;;
    help|-h|--help)
        cmd_help "$@"
        ;;
    *)
        echo "Error: Unknown subcommand '$subcommand'">&2
        usage
        ;;
esac 