#!/bin/bash


if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="$1"
count=1

for file in "$dir"/*; do
    if [ -f "$file" ]; then
        new_name="$dir/crash$count.nds"
        mv "$file" "$new_name"
        ((count++))
    fi
done

echo "Renaming done"
