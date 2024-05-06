#!/bin/bash -eu

logfile="access_log"

# Sprawdzenie czy plik access_log istnieje
if [ ! -f "$logfile" ]; then
    echo "Plik $logfile nie istnieje."
    exit 1
fi

# Wyszukanie adresów IP w pliku access_log i wyfiltrowanie unikalnych wartości
ip_addresses=$(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$logfile" | sort -u)

# Wypisanie 10 pierwszych unikalnych adresów IP
echo "$ip_addresses" | head -n 10
