#!/bin/bash -eu

# Nazwa pliku access_log
logfile="access_log"

# Wyrażenie regularne do wyszukania adresów IP
ip_address_pattern='^([0-9]{1,3}\.){3}[0-9]{1,3}'

# Sprawdzenie czy plik access_log istnieje
if [ ! -f "$logfile" ]; then
    echo "Plik $logfile nie istnieje."
    exit 1
fi

# Wyszukiwanie zapytań HTTP z FQDN i wyświetlanie wyników
grep -vE "$ip_address_pattern" "$logfile" | grep -oE '^[^[:space:]]+[[:space:]]+[^[:space:]]+[^0-9.]+' | sort -u
