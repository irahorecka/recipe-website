#!/bin/bash

## Takes input image filepath and returns image's width
## E.g.
## $ bash fetch_file_extension.sh -p 'path/to/this-image.png'
## > 600

while getopts p: filepath
do
    case "${filepath}" in
        p) path=${OPTARG};;
    esac
done

echo $(identify -ping -format '%w' ${path})
