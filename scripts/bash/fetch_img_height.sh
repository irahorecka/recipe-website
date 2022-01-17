#!/bin/bash

## Takes input image filepath and returns image's height
## E.g.
## $ bash fetch_file_extension.sh -p 'path/to/this-image.png'
## > 400

while getopts p: filepath
do
    case "${filepath}" in
        p) path=${OPTARG};;
    esac
done

HEIGHT=$(identify -ping -format '%h' ${path})
echo $HEIGHT
