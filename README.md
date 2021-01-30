____
![alt text][LOGO]
____
# **<p align=center>Mise en place de l'environnement</align>** #

La mise en place de l'environnement ce fait en plusieurs étapes.


Toute les commandes doivent être en :
```console
root@hostname:~$
````

____

##   :satellite:   1.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
#### Purge (User, Home, Group)
````console
deluser docker     ; 
rm -r /home/docker ;
delgroup docker    ;
````
#### Création du Groupe, utilisateur
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

____
##  :microscope:  2.**Installation de Samba**
````console
echo "deb http://ftp.de.debian.org/debian buster main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````
____
##  :petri_dish:  3. **Création du compte de partage Samba**
````console
SAMBA_USER=docker
SAMBA_PASS=admin

(echo $SAMBA_PASS; echo $SAMBA_PASS; echo ) | smbpasswd -a $SAMBA_USER ;
smbpasswd -e $SAMBA_USER ;
systemctl restart smbd ;
````
____

##  :alembic:     4. **Prise en charge de la découverte réseau pour Windows**
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

##  :test_tube:   5. **Installation de Docker, Samba.**

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
