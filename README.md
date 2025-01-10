# Voor Proxmox CT container (debian)
## Stap 1: install Git.
```
apt update && apt install -y git
```
of met sudo
```
sudo apt update && sudo apt install -y git
```
## Stap 2: Ga naar de /opt-directory
```
cd /opt
```
## Stap 3: Clone de repository en ga naar de containers-directory
```
git clone --depth 1 https://github.com/De-Backer/docker-template.git containers && cd containers
```
## Stap 4: Maak install.sh uitvoerbaar
```
chmod +x install.sh
```
## Stap 5: Voer install.sh uit
```
./install.sh
```

## Als je al install.sh gebruikt hebt, dan gebruik je build.sh voor bulk rebuild docker container's
```
./build.sh
```
