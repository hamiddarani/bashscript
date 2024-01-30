#!/usr/bin/bash

INTERVAL=10
NUM=5
VERBOSE=0
SUCCESS=1

function help {
    cat << EOL
Usage: $0 [OPTIONS] COMMAND
Available options:
    -h: Show this help and exit 0
    -v: Verbose mode
    -n: Number of tries (DEFAULT: 5)
    -i: interval seconds (DEFAULD: 10)
Example:
    $0 -v -n 5 -i 10
EOL
}

function check_number {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

if [[ $# -eq 0 ]]; then
    help
    exit 0
fi

while [[ $# -ne 0 ]]; do
    case $1 in
        -h)
            help
            exit 0
            ;;
        -v)
            VERBOSE=1
            shift
            ;;
        -n)
            check_number $2
            if [[ $? -ne 0 ]]; then
                help
                exit 1
            fi
            NUM=$2
            shift 2
            ;;
        -i)
            check_number $2
            if [[ $? -ne 0 ]]; then
                help
                exit 1
            fi
            INTEVAL=$2
            shift 2
            ;;
        *)
            COMMAND=$@
            break
            ;;
    esac     
done

if [[ -z $COMMAND ]]; then
    help
    exit 0
fi

echo $COMMAND

for i in $(seq 1 $NUM); do
    $COMMAND
    if [[ $? -eq 0 ]]; then
        SUCCESS=0
        break
    else
        if [[ $VERBOSE -eq 1 ]]; then
            echo "[INFO] Try $i was faild"
        fi
        sleep $INTERVAL

    fi
done

if [[ $SUCCESS -eq 0 ]]; then
    if [[ $VERBOSE -eq 1 ]]; then
        echo "[INFO] Command got executed successfuly"
    fi
    exit 0
else
    if [[ $VERBOSE -eq 1 ]]; then
        echo "[ERROR] Command operation faild"
    fi
    exit 1
fi