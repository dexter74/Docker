## Guide utilisation Docker ##
--------------

#### Etape 0: Préparatif du serveur ####


--------------

**Montage Réseaux**
--------------
````
net use * /delete /y
# Label + Montage
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##192.168.1.20#docker /v _LabelFromReg /t REG_SZ /f /d "Docker"
net use X: \\192.168.1.20\docker

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##192.168.1.20#SYSTEM /v _LabelFromReg /t REG_SZ /f /d "SYSTEM"
net use Y: \\192.168.1.20\SYSTEM
```` 



#### Etape 1: Installer Docker, Docker composer et Portainer ####
--------------
#### Etape 2: Configuration de Portainer ####
--------------
