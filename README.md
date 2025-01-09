# Voor Proxmox CT container (debian)
## Stap 1: Ga naar de /opt-directory
```
cd /opt
```
## Stap 2: Clone de repository en ga naar de containers-directory
```
git clone --depth 1 https://github.com/De-Backer/docker-template.git containers && cd containers
```
## Stap 3: Maak install.sh uitvoerbaar
```
chmod +x install.sh
```
## Stap 4: Voer install.sh uit
```
./install.sh
```

## Als je al install.sh gebruikt hebt, dan gebruik je build.sh voor bulk rebuild docker container's
```
./build.sh
```
