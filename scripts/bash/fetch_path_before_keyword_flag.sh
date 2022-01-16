#!/bin/bash

## Takes input path with keyword 'flag' and returns string with and everything before 'flag'
## E.g.
## $ bash fetch_path_before_keyword_flag.sh -p 'path/to/this-flag-boop.png'
## > path/to/this-flag

while getopts p: flag
do
    case "${flag}" in
        p) path=${OPTARG};;
    esac
done

CORE_PATH="${path%%flag*}flag"
echo $CORE_PATH
