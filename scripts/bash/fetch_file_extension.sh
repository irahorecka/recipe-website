#!/bin/bash

## Takes input filepath and returns file's file extension
## E.g.
## $ bash fetch_file_extension.sh -p 'path/to/this-flag-boop.png'
## > png

while getopts p: filepath
do
    case "${filepath}" in
        p) path=${OPTARG};;
    esac
done

EXT="${path#*.}"
echo $EXT
