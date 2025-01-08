# Voor Proxmox CT container (debian)
## Stap 1: Update het systeem
```
apt update && apt upgrade -y
```
## Stap 2: Voeg Docker's officiële GPG-sleutel toe
```
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
```
## Stap 3: Voeg de Docker-repository toe aan Apt-bronnen
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
```
## Stap 4: Installeer Docker en benodigde tools
```
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git
```
## Stap 5: Ga naar de /opt-directory
```
cd /opt
```
## Stap 6: Clone de repository en ga naar de containers-directory
```
git clone https://github.com/De-Backer/docker-template.git containers && cd containers
```
## Stap 7: Verwijder ongewenste mappen
Gebruik de volgende opdracht om specifieke mappen te verwijderen:
```
rm -rf [folder]
```
## Stap 8: Pas compose.yaml-bestanden aan
Open en wijzig de bestanden naar wens.
## Stap 9: Maak start.sh uitvoerbaar
```
chmod +x start.sh
```
## Stap 10: Voer start.sh uit
```
./start.sh
```
_________________________________
Translate ChatGPT:
# For Proxmox CT Container (Debian)
## Step 1: Update the system
```
apt update && apt upgrade -y
```
## Step 2: Add Docker's official GPG key
```
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
```
## Step 3: Add the Docker repository to Apt sources
```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
```
## Step 4: Install Docker and required tools
```
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git
```
## Step 5: Navigate to the /opt directory
```
cd /opt
```
## Step 6: Clone the repository and Navigate to the containers directory
```
git clone https://github.com/De-Backer/docker-template.git containers && cd containers
```
## Step 7: Remove unwanted folders
Use the following command to delete specific folders:
```
rm -rf [folder]
```
## Step 8: Customize compose.yaml files
Open and edit the files to suit your requirements.

## Step 9: Make start.sh executable
```
chmod +x start.sh
```
## Step 10: Run start.sh
```
./start.sh
```
