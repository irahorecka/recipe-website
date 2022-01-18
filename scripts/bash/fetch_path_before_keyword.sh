#!/bin/bash

## Takes input path with keyword 'flag' and returns string with and everything before 'flag'
## E.g.
## $ bash fetch_path_before_keyword.sh -p 'path/to/this-flag-boop.png' -k 'boop'
## > path/to/this-flag-

while getopts ":k:p:" filepath
do
    case "${filepath}" in
        p) path=${OPTARG};;
        k) keyword=${OPTARG}
    esac
done

echo ${path%%${keyword}*}
