#!/bin/bash
# @(#)$Id$
#
# Script to turn lead into gold
# Usage: script [options] ARG1
#   -h, --help    Display help message.
#   -n            Dry-run; only show what would be done.
#
# Copyright (C) 2014 $USER_FULLNAME - All Rights Reserved
# Permission to copy and modify is granted under the foo license
# Last revised 1/10/2014
#

## errexit: script on first error
## nounset: Treat references to unset variables as errors
## noclobber: Prevent mistakes for using > instead of <
## pipefail: Use first non-zero exit code from row of piped commands
## nullglob: prevent glob expansion like in ./foo/*
set -o errexit -o nounset -o noclobber -o pipefail
shopt -s nullglob

## this script name
declare -r SCRIPT=$(basename "$BASH_SOURCE" .sh)

## help message
declare -r HELPMSG="Usage: $SCRIPT_NAME [OPTION]... [ARG]...
  -h    display this help and exit
"


## exit the shell (default status code: 1) after printing the message to stderr
bail() {
    echo -ne "$1" >&2
    exit ${2-1}
} 

## print the usage and exit the shell(default status code: 2)
usage() {
    declare status=2
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        status=$1
        shift
    fi
    bail "${1}$HELPMSG" $status
}
## OR
usage() {
  [ "$*" ] && echo "$0: $*"
  sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0"
  exit 2
} 2>/dev/null


while getopts ":h" opt; do
    case $opt in
        h)
            usage 0
            ;;
        \?)
            usage "Invalid option: -$OPTARG \n"
            ;;
    esac
done

shift $(($OPTIND - 1))
[[ "$#" -lt 1 ]] && usage "Too few arguments\n"


#==========MAIN CODE BELOW==========

## EXAMPLEs NO IFs
## if $1 is 1 then ...some code:
[ $i = 1 ] && {
##    ... some code
}
## If $i not equal 1...:
[ $i = 1 ] || {
##   ... some code 
}
