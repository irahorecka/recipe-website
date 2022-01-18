#!/bin/bash

## Takes input filepath and returns file's extension
## E.g.
## $ bash fetch_file_extension.sh -p 'path/to/this-flag.png'
## > png

while getopts p: filepath
do
    case "${filepath}" in
        p) path=${OPTARG};;
    esac
done

echo ${path#*.}
