#!/bin/bash -eu

# UWAGA 2
if [ "$#" -ne 1 ]; then
    echo "Podaj sciezke jako argument!"
    exit 1
fi

MY_DIR="${1}"
if [[ -e "$MY_DIR" && -d "$MY_DIR" ]]; then
    for ITEM in "$MY_DIR"/*.bak; do
        if [[ -f "$ITEM" ]]; then
            chmod uo-w "$ITEM"
        elif [[ -d "$ITEM" ]]; then
            chmod o+rx,ug-rx "$ITEM"
        fi
    done
    for ITEM in "$MY_DIR"/*.tmp; do
        if [[ -d "$ITEM" ]]; then
            chmod ug+wx,o-wx "$ITEM"
        fi
    done
    for ITEM in "$MY_DIR"/*.txt; do
        if [[ -f "$ITEM" ]]; then
            chmod u=r,g=w,o=x "$ITEM"
        fi
    done
    for ITEM in "$MY_DIR"/*.exe; do
    if [ -f "$ITEM" ]; then
        chmod a+x "$ITEM"
        chmod u+s "$ITEM" # ustawienie bitu setuid, aby plik zawsze był uruchamiany z uprawnieniami właściciela --> -rwsr-xr-x suid.exe
    fi
done
else
    echo "Sciezka nie istnieje!"
    exit 1
fi
