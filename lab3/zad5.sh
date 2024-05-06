#!/bin/bash -eu

filename="yolo.csv"

# Sprawdzenie czy plik istnieje
if [ ! -f "$filename" ]; then
    echo "Plik $filename nie istnieje."
    exit 1
fi

# Wypisanie imion osób o wartości $2.99, $5.99 lub $9.99 
# Nie wiem, czy tak miało być, ale w pliku nie ma osób z taką wartością, więc nie wyświetla nikogo, jak się zmieni u kogoś wartość na jedną z tych to wyświetla jego imię
awk -F ',' '$7 == "$2.99" || $7 == "$5.99" || $7 == "$9.99" {print $2}' "$filename"
