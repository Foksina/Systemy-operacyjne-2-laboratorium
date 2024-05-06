#!/bin/bash -eu

# Uruchomienie skryptu fakaping.sh i zapisanie wyniku do pliku tymczasowego
./fakaping.sh > temp.log

# Wyfiltrowanie unikalnych linii i zapisanie ich do pliku all.log
sort -u temp.log > all.log

# Wyświetlenie unikalnych linii na konsoli
cat all.log

# Usunięcie pliku tymczasowego
rm temp.log
