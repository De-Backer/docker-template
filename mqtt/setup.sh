#!/bin/bash

# Controleer of mappen bestaan, en maak ze aan als ze ontbreken
mkdir -p ./config
mkdir -p ./data
mkdir -p ./log

# Optioneel: geef rechten zodat containers toegang hebben
chmod -R 755 ./config
chmod -R 755 ./data
chmod -R 755 ./log

echo "Mappen zijn voorbereid. Start nu je containers met 'docker-compose up'."
