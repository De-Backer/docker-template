#!/bin/bash

# Controleer of de benodigde tools zijn geïnstalleerd
echo "Stap 1: Controleer of de benodigde tools zijn geïnstalleerd"
VEREISTE_PROGRAMMAS=("ca-certificates" "curl" "dialog" "git")
for vereiste_programma in "${VEREISTE_PROGRAMMAS[@]}"; do
    echo "---------------------------------------------------------------------"
    echo "Controleer of $vereiste_programma geïnstalleerd is."
    if ! command -v $vereiste_programma &> /dev/null; then
        echo "$vereiste_programma is niet geïnstalleerd."
        read -p "Wil je $vereiste_programma installeren? (y/n): " install_choice
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            if command -v sudo &> /dev/null; then
                if command -v apt &> /dev/null; then
                    sudo apt update && sudo apt install -y $vereiste_programma
                elif command -v yum &> /dev/null; then
                    sudo yum install -y $vereiste_programma
                elif command -v dnf &> /dev/null; then
                    sudo dnf install -y $vereiste_programma
                else
                    echo "Geen bekende pakketbeheerder gevonden. Installeer $vereiste_programma handmatig."
                    exit 1
                fi
            else
                if command -v apt &> /dev/null; then
                    apt update && apt install -y $vereiste_programma
                elif command -v yum &> /dev/null; then
                    yum install -y $vereiste_programma
                elif command -v dnf &> /dev/null; then
                    dnf install -y $vereiste_programma
                else
                    echo "Geen bekende pakketbeheerder gevonden. Installeer $vereiste_programma handmatig."
                    exit 1
                fi
            fi
        else
            echo " $vereiste_programma  is vereist voor dit script. Beëindigen."
            exit 1
        fi
    else
        echo "$vereiste_programma  is er."
    fi
done

echo "---------------------------------------------------------------------"
echo "Stap 2: Voeg Docker's officiële GPG-sleutel toe"
if command -v sudo &> /dev/null; then
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
else
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
fi
echo "---------------------------------------------------------------------"
echo "Stap 3: Voeg de Docker-repository toe aan Apt-bronnen"
if command -v sudo &> /dev/null; then
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
else
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
fi

echo "---------------------------------------------------------------------"
echo "Stap 4: Installeer Docker en benodigde tools"
VEREISTE_PROGRAMMAS=("docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin")
for vereiste_programma in "${VEREISTE_PROGRAMMAS[@]}"; do
    echo "---------------------------------------------------------------------"
    echo "Controleer of $vereiste_programma geïnstalleerd is."
    if ! command -v $vereiste_programma &> /dev/null; then
        echo "$vereiste_programma is niet geïnstalleerd."
        read -p "Wil je $vereiste_programma installeren? (y/n): " install_choice
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            if command -v sudo &> /dev/null; then
                if command -v apt &> /dev/null; then
                    sudo apt update && sudo apt install -y $vereiste_programma
                elif command -v yum &> /dev/null; then
                    sudo yum install -y $vereiste_programma
                elif command -v dnf &> /dev/null; then
                    sudo dnf install -y $vereiste_programma
                else
                    echo "Geen bekende pakketbeheerder gevonden. Installeer $vereiste_programma handmatig."
                    exit 1
                fi
            else
                if command -v apt &> /dev/null; then
                    apt update && apt install -y $vereiste_programma
                elif command -v yum &> /dev/null; then
                    yum install -y $vereiste_programma
                elif command -v dnf &> /dev/null; then
                    dnf install -y $vereiste_programma
                else
                    echo "Geen bekende pakketbeheerder gevonden. Installeer $vereiste_programma handmatig."
                    exit 1
                fi
            fi
        else
            echo " $vereiste_programma  is vereist voor dit script. Beëindigen."
            exit 1
        fi
    else
        echo "$vereiste_programma  is er."
    fi
done

echo "---------------------------------------------------------------------"
echo "Stap 5: Verwijder ongewenste mappen"
read -p "druk op enter"

# Haal een lijst van de mappen in de huidige directory
folders=(*/)
if [ ${#folders[@]} -eq 0 ]; then
    echo "Geen mappen gevonden in de huidige directory."
    exit 0
fi

# Maak een lijst voor dialog (label, map)
dialog_list=()
for folder in "${folders[@]}"; do
    dialog_list+=("$folder" " " on)
done

# Vraag de gebruiker om mappen te selecteren
selected_folders=$(dialog --checklist "welke mappen wil je behouden? (mappen zonder * worden verwijderd):" 20 50 10 "${dialog_list[@]}" 3>&1 1>&2 2>&3)

# Controleer of de gebruiker heeft geannuleerd
if [ $? -ne 0 ]; then
    echo "Actie geannuleerd."
    exit 0
fi

# Zet de geselecteerde mappen in een array, verwijder quotes
IFS=' ' read -r -a keep_folders <<< "${selected_folders//\"/}"

# Loop door de mappen en verwijder degene die niet zijn geselecteerd
for folder in "${folders[@]}"; do
    folder_cleaned="$folder" # Geen trailing slash verwijderen
    match_found=false
    for keep_folder in "${keep_folders[@]}"; do
        if [[ "$folder_cleaned" == "$keep_folder" ]]; then
            match_found=true
            break
        fi
    done

    if ! $match_found; then
        rm -rf "$folder"
    fi
done

clear

# Feedback aan gebruiker
echo "Overgebleven mappen:"
for folder in "${folders[@]}"; do
    folder_cleaned="$folder"
    for keep_folder in "${keep_folders[@]}"; do
        if [[ "$folder_cleaned" == "$keep_folder" ]]; then
            echo "  - $folder"
        fi
    done
done

if command -v sudo &> /dev/null; then
    sudo chmod +x build.sh
    sudo chmod +x config.sh
else
    chmod +x build.sh
    chmod +x config.sh
fi

./config.sh
./build.sh
