#!/bin/bash -eu

# UWAGA 2 
if [ "$#" -ne 2 ]; then
    echo "Podaj dwie sciezki!"
    exit 1
fi

DIR_UNO="${1}"
DIR_DUO="${2}"

if [[ -e "$DIR_UNO" && -e "$DIR_DUO" ]]; then
    FILES=$(find "$DIR_UNO")
    for ITEM in $FILES; do
        if [[ -d "$ITEM" ]]; then 
            echo "$(basename "$ITEM") jest katalogiem"
            DIRNAME=$(echo "$(basename "$ITEM")" | tr '[:lower:]' '[:upper:]')
            ln -s "../$ITEM" "$DIR_DUO/${DIRNAME}_ln"
        elif [[ -L "$ITEM" ]]; then
            echo "$(basename "$ITEM") jest dowiazaniem symbolicznym"
        elif [[ -f "$ITEM" ]]; then
            echo "$(basename "$ITEM") jest plikiem regularnym"
            FILENAME=$(basename "$ITEM")
            MY_NAME=${FILENAME%.*}
            MY_NAME_UPPER=$(echo "$MY_NAME" | tr '[:lower:]' '[:upper:]')
            MY_TYPE=${FILENAME#*.}
            ln -s "../$ITEM" "$DIR_DUO/${MY_NAME_UPPER}_ln.$MY_TYPE"
        else
            echo "Nie wiem czym jest $ITEM"
        fi 
    done
else
    echo "Katalogi nie istnieja!"
    exit 1
fi
