#!/bin/bash -eu

# Przejście do katalogu groovies (jeśli istnieje)
groovies_dir="./groovies"
if [ -d "$groovies_dir" ]; then
    cd "$groovies_dir" || exit

    # Zamiana $HEADER$ na /temat/ we wszystkich plikach
    find . -type f -exec sed -i 's/\$HEADER\$/\/temat\//g' {} +
    echo "Zamiana zakończona."
else
    echo "Katalog 'groovies' nie istnieje w pobranym repozytorium."
fi
