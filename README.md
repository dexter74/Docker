________________________________________________________________________________________________________________________________________________________________
<p align="center"><img width="460" height="300" src="https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png"></p>
________________________________________________________________________________________________________________________________________________________________
# **<p align=center>Mise en place de l'environnement</align>** #
________________________________________________________________________________________________________________________________________________________________
Toutes les commandes doivent être taper en root ou avec le paramètre sudo <macommande>
```console
root@hostname:~$
````
________________________________________________________________________________________________________________________________________________________________
##  :alembic:     X. Déclaration des variables pour la suite
`Tout les variables seront utilisées pour la suite`

````console
USERS=docker
PASSWORD=admin

GROUP=docker
GROUP_ID=5000

SAMBA_USER=docker
SAMBA_PASS=admin

USERS_ID=2000
USER_HOME=/home/docker
RELEASE_DEBIAN=buster

````
________________________________________________________________________________________________________________________________________________________________
##   :satellite:   X.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
#### 1.Purge de l'utilisateur, de son dossier propre et du Groupe
````console
deluser $USERS ; 
rm -r $USER_HOME ;
delgroup $GROUP_ID ;
````
#### 2.Création du Groupe, Utilisateur
````console
addgroup $GROUP --gid $GROUP_ID ;
useradd $USERS --uid $USERS_ID --home $USER_HOME --create-home --groups root,sudo,$GROUP --gid root --shell /bin/bash ;
echo "$USERS:$PASSWORD" | chpasswd ;
````

________________________________________________________________________________________________________________________________________________________________
##  :microscope:  X.**Installation Samba**
#### 1. Installation de Samba
````console
echo "deb http://ftp.de.debian.org/debian $RELEASE_DEBIAN  main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````
#### 2. Création du compte de partage Samba
````console
(echo $SAMBA_PASS; echo $SAMBA_PASS; echo ) | smbpasswd -a $SAMBA_USER ;
smbpasswd -e $SAMBA_USER ;
systemctl restart smbd ;
````
________________________________________________________________________________________________________________________________________________________________
##  :petri_dish:   X. **Prise en charge de la découverte réseau pour Windows**

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
________________________________________________________________________________________________________________________________________________________________

##  :test_tube:   7. **Installation de Docker**
________________________________________________________________________________________________________________________________________________________________

##  :gear:        6. **Création du conteneur Portainer.**
________________________________________________________________________________________________________________________________________________________________
##  :magnet:      7. **Création des volumes contenant les accès aux partages.**
________________________________________________________________________________________________________________________________________________________________
##  :chains:      8. **Ajout des Endpoints dans Portainer.**
________________________________________________________________________________________________________________________________________________________________

##  :shield:      9. **Création du stack applicatif.**  
________________________________________________________________________________________________________________________________________________________________
##  :axe:       10. **Reverse Proxy via Pfsense.**
________________________________________________________________________________________________________________________________________________________________

***
Liens: [ICI][LINES_1]
****




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LIEN_WSDD]:https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/ 
[LIEN_1]: # 
