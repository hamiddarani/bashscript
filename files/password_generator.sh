#!/bin/bash

password_length=$1

help() {
    echo "Bad usage"
    echo "usage: $0 <password length>"
}

check_integer() {
    if [[ $# -ne 1 ]]; then
        echo "Need exactly one argument."
        exit 1
    fi

    if [[ $1 =~ ^[[:digit:]]+$ ]]; then
        return 0
    else
        echo "invalid argument '$1' please enter a number"
        return 1
    fi
}

if [[ $# -ne 1 ]]; then
    help
    exit 1
fi

check_integer $1

if [[ $? -ne 0 ]]; then
    help
    exit 1
fi

password=$(tr -dc "a-zA-Z0-9" < /dev/urandom | head -c ${password_length})

echo $password
