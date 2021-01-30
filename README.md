________________________________________________________________________________________________________________________________________________________________
![alt text][LOGO]
________________________________________________________________________________________________________________________________________________________________
# **<p align=center>Mise en place de l'environnement</align>** #
________________________________________________________________________________________________________________________________________________________________

La mise en place de l'environnement ce fait en plusieurs étapes.
Toute les commandes doivent être en :
```console
root@hostname:~$
````
________________________________________________________________________________________________________________________________________________________________

##   :satellite:   X.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
#### 1.Purge (User, Home, Group)
````console
deluser docker     ; 
rm -r /home/docker ;
delgroup docker    ;
````
#### 2.Création du Groupe, utilisateur
````console
ADD_GROUP=docker
ADD_USER=docker
ID_GROUP=5000
ID_USER=2000
USER_PASS=admin

addgroup $ADD_GROUP --gid $ID_GROUP ;
useradd $ADD_USER --uid $ID_USER --home /home/docker/ --create-home --groups root,sudo,$ADD_GROUP --gid root --shell /bin/bash ;
echo "ADD_USER:$USER_PASS" | chpasswd ;
````
________________________________________________________________________________________________________________________________________________________________




##  :microscope:  X.**Installation Samba**
#### 1. Installation de Samba
````console
echo "deb http://ftp.de.debian.org/debian buster main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````

#### 2. Création du compte de partage Samba
````console
SAMBA_USER=docker
SAMBA_PASS=admin

(echo $SAMBA_PASS; echo $SAMBA_PASS; echo ) | smbpasswd -a $SAMBA_USER ;
smbpasswd -e $SAMBA_USER ;
systemctl restart smbd ;
````




____
##  :petri_dish:   X. **Prise en charge de la découverte réseau pour Windows**

____



##  :alembic:     X. 
````console
apt install -y unzip ;
rm -r /tmp/* ;
wget https://github.com/christgau/wsdd/archive/master.zip -O /tmp/master.zip ;
unzip /tmp/master.zip -d /tmp ;
mv /tmp/wsdd-master/src/wsdd.py /tmp/wsdd-master/src/wsdd ;
cp /tmp/wsdd-master/src/wsdd /usr/bin ;
cp /tmp/wsdd-master/etc/systemd/wsdd.service /etc/systemd/system ;
sed -i 's/User=nobody/User=root/g' /etc/systemd/system/wsdd.service ;
sed -i 's/Group=nobody/Group=root/g' /etc/systemd/system/wsdd.service ;
systemctl daemon-reload ;
systemctl start wsdd ;
systemctl enable wsdd ;
service wsdd status ;
````

**Projet:** [WSDD][LIEN_WSDD]

____

##  :test_tube:   7. **Installation de Docker**

____

##  :gear:        6. **Création du conteneur Portainer.**
____

##  :magnet:      7. **Création des volumes contenant les accès aux partages.**
____

##  :chains:      8. **Ajout des Endpoints dans Portainer.**
____

##  :shield:      9. **Création du stack applicatif.**  
____

##  :axe:       10. **Reverse Proxy via Pfsense.**
____
***
Liens: [ICI][LINES_1]
****




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LIEN_WSDD]:https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/ 
[LIEN_1]: # 
