#!/bin/bash

# Controleer of mappen bestaan, en maak ze aan als ze ontbreken
mkdir -p ./data

# Optioneel: geef rechten zodat containers toegang hebben
chmod -R 755 ./data

echo "De mappen in $(pwd) zijn voorbereid. Start nu je containers met 'docker-compose up'."
