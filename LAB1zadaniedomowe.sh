#!/bin/bash

# +0.24 – napisać skrypt, który pobiera 3 argumenty: SOURCE_DIR, RM_LIST, TARGET_DIR o wartościach domyślnych: lab_uno, 2remove, bakap
SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

echo "SOURCE_DIR: $SOURCE_DIR"
echo "RM_LIST: $RM_LIST"
echo "TARGET_DIR: $TARGET_DIR"

# +0.24 – jeżeli TARGET_DIR nie istnieje, to go tworzymy
if [[ ! -d $TARGET_DIR ]]
    then 
    mkdir "$TARGET_DIR"
    echo "Utworzono katalog: $TARGET_DIR"
else
    echo "Katalog $TARGET_DIR juz istnieje"
fi

# +0.5 – iterujemy się po zawartości pliku RM_LIST i tylko jeżeli plik o takiej nazwie występuje w katalogu SOURCE_DIR, to go usuwamy
if [[ -e "$RM_LIST" ]]                          # sprawdzenie czy plik RM_LIST istnieje, zeby miec po czym iterowac
    then
    while IFS= read -r FILENAME; do             # iterujemy się po zawartości pliku RM_LIST
        if [[ -e "$SOURCE_DIR/$FILENAME" ]]     # tylko jeżeli plik o takiej nazwie występuje w katalogu SOURCE_DIR (jesli katalog nie istnieje, to pliki w nim tez)
            then 
            rm -rf "$SOURCE_DIR/$FILENAME"      # to go usuwamy
            echo "Usunieto: $SOURCE_DIR/$FILENAME"
        else
            echo "W $RM_LIST nie ma pliku/katalogu, ktory znajduje sie w $SOURCE_DIR"
        fi
    done < "$RM_LIST"
else
    echo "Plik $RM_LIST nie istnieje."
fi

# +0.5 - jeżeli jakiegoś pliku nie ma na liście, ale: 
# ale jest plikiem regularnym, to przenosimy go do TARGET_DIR
# ale jest katalogiem, to kopiujemy go do TARGET_DIR z zawartością
for ENTRY in "$SOURCE_DIR"/*; do                                    # jeżeli jakiegoś pliku (ktory jest w SOURCE_DIR) 
    FILENAME =$(basename "$ENTRY")
    if [[ ! -f "$RM_LIST" || ! $(grep -q "$FILENAME" "$RM_LIST") ]] # nie ma na liście  (lub RM_LIST nie istnieje = tego pliku nie ma na liscie) 
        then
        if [[ -f "$ENTRY" ]]                                        # ale jest plikiem regularnym 
            then               
            mv "$ENTRY" "$TARGET_DIR/"                              # to przenosimy go do TARGET_DIR
            echo "Przeniesiono plik $ENTRY do $TARGET_DIR"
        elif [[ -d "$ENTRY" ]]                                      # ale jest katalogiem
            then              
            cp -r "$ENTRY" "$TARGET_DIR/"                           # to kopiujemy go do TARGET_DIR z zawartością
            echo "Skopiowano katalog $ENTRY do $TARGET_DIR"
        fi
    fi
done

# +0.5  – jeżeli po zakończeniu operacji są jeszcze jakieś pliki w katalogu SOURCE_DIR to:
# piszemy np. „jeszcze coś zostało” na konsolę oraz
# jeżeli co najmniej 2 pliki, to wypisujemy: „zostały co najmniej 2 pliki”
# jeżeli więcej niż 4, to wypisujemy: „zostało więcej niż 4 pliki” (UWAGA: 4, to też więcej niż 2)
# jeżeli nie więcej, niż 4, ale co najmniej 2, to też coś piszemy
# Jeżeli nic nie zostało, to informujemy o tym słowami np. „tu był Kononowicz”
if [[ -e "$SOURCE_DIR" ]]                          # sprawdzenie czy katalog SOURCE_DIR istnieje
    then
    REMAINING_FILES=$(find "$SOURCE_DIR" -type f | wc -l)   # find wyszukuje pliki w katalogu
                                                        # -type f ogranicza wyniki tylko do plików regularnych  
                                                        # wc word count
                                                        # -l zlicza wiersze tekstu
    if [[ "$REMAINING_FILES" -gt 0 ]]                       # jeżeli po zakończeniu operacji są jeszcze jakieś pliki w katalogu SOURCE_DIR
        then
        echo "Jeszcze coś zostało."                         # piszemy np. „jeszcze coś zostało” na konsolę
        if [[ "$REMAINING_FILES" -ge 2 ]]                   # jeżeli co najmniej 2 pliki (ge - greater or equal)
            then
            echo "Zostały co najmniej 2 pliki"              # to wypisujemy: „zostały co najmniej 2 pliki”
        fi
        if [[ "$REMAINING_FILES" -gt 4 ]]                   # jeżeli więcej niż 4 (gt - greater) (osobny if, bo 4 to tez wiecej niz 2)
            then
            echo "Zostało więcej niż 4 pliki"              # to wypisujemy: „zostało więcej niż 4 pliki”
        fi
        if [[ "$REMAINING_FILES" -le 4 && "$REMAINING_FILES" -ge 2 ]]   # jeżeli nie więcej, niż 4, ale co najmniej 2
            then
            echo "Zostało co najmniej 2 pliki, ale nie więcej niż 4."   # to też coś piszemy
        fi
    else
        echo "Tu był Kononowicz"                          # jeżeli nic nie zostało, to informujemy o tym słowami np. „tu był Kononowicz”
    fi
else
    echo "Katalog $SOURCE_DIR nie istnieje."
fi
