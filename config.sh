#!/bin/bash

# Haal een lijst van de mappen in de huidige directory
folders=(*/)
if [ ${#folders[@]} -eq 0 ]; then
    echo "Geen mappen gevonden in de huidige directory."
    exit 0
fi

for folder in "${folders[@]}"; do
    cd "$folder" || continue
    echo "  map: $folder"
    read -p "druk op enter"

    # Zoek en open setup.sh en compose.yaml
    find . -type f \( -name "setup.sh" -o -name "compose.yaml" \) -execdir nano {} \; || echo "Fout bij het openen van bestanden"

    cd ./../ || exit
done
