#!/bin/bash

# Controleer of mappen bestaan, en maak ze aan als ze ontbreken
mkdir -p ./config

# Optioneel: geef rechten zodat containers toegang hebben
chmod -R 755 ./config

echo "Mappen zijn voorbereid. Start nu je containers met 'docker-compose up'."
