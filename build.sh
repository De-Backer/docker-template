#!/bin/bash

# Functie voor vraag en controle
ask_confirmation() {
    local question="$1"
    echo "$question (y/n)"
    read antwoord
    if [[ "$antwoord" != "y" && "$antwoord" != "yes" ]]; then
        echo "Actie geannuleerd."
        return 1
    fi
    return 0
}

# Stop alle draaiende containers
ask_confirmation "Stop alle draaiende containers"
if [ $? -eq 0 ]; then
    echo "- stop -------------------------"
    docker stop $(docker ps -q) || echo "Fout bij het stoppen van containers."
fi

# Verwijder alle containers
ask_confirmation "Verwijder alle containers"
if [ $? -eq 0 ]; then
    echo "- rm container -----------------"
    docker rm $(docker ps -a -q) -f || echo "Fout bij het verwijderen van containers."
fi

# Verwijder alle images
ask_confirmation "Verwijder alle images"
if [ $? -eq 0 ]; then
    echo "- rm image ---------------------"
    docker image rm $(docker image ls -a -q) -f || echo "Fout bij het verwijderen van images."
fi

# Verwijder ongebruikte netwerken
ask_confirmation "Verwijder ongebruikte netwerken"
if [ $? -eq 0 ]; then
    echo "- rm network -------------------"
    docker network prune -f || echo "Fout bij het verwijderen van netwerken."
fi

# Status tonen van huidige images, containers, en netwerken
echo "- status -----------------------"
docker image ls -a
docker ps -a
docker network ls
echo "--------------------------------"

# Create network frontend
ask_confirmation "Create network frontend"
if [ $? -eq 0 ]; then
    docker network create frontend || echo "Network 'frontend' already exists."
fi

# Run docker-compose up in alle sub-dirs
ask_confirmation "Run chmod +x setup.sh && setup.sh in alle sub-dirs"
if [ $? -eq 0 ]; then
    echo "- build -----------------------"
    find . -type f -name "setup.sh" -execdir chmod +x setup.sh \; || echo "Fout bij het uitvoeren van chmod +x setup.sh"
    find . -type f -name "setup.sh" -execdir ./setup.sh \; || echo "Fout bij het uitvoeren van setup.sh"
fi

# Run docker-compose up in alle sub-dirs
ask_confirmation "Run docker-compose up -d in alle sub-dirs"
if [ $? -eq 0 ]; then
    echo "- build -----------------------"
    find . -type f -name "compose.yaml" -execdir docker compose up -d \; || echo "Fout bij het uitvoeren van docker-compose."
fi

# Status na build
echo "- status image ------------------"
docker image ls -a
echo "- status ps ---------------------"
docker ps -a
echo "- status network ----------------"
docker network ls
