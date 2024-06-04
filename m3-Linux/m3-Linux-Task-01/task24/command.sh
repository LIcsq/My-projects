#!/bin/bash
directory="$1"
cd "$directory" || { echo "Не вдалося перейти до директорії $directory"; exit 1; }
find . -type l ! -exec test -e {} \; -print | while read -r broken_symlink; do
    echo "Видалення зламаного посилання: $broken_symlink"
    rm "$broken_symlink"
done

