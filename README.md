________________________________________________________________________________________________________________________________________________________________
<p align="center"><img width="460" height="300" src="https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png"></p>

________________________________________________________________________________________________________________________________________________________________

# **<p align=center>Mise en place de l'environnement</align>** #
Se connecter en root :
````console
root@host:$ sudo -i
````

________________________________________________________________________________________________________________________________________________________________
##  :alembic:     X. Déclaration des variables pour la suite

````console
RELEASE_DEBIAN=buster

USERS=docker
PASSWORD=admin
USERS_ID=2000
USER_HOME=/home/docker

GROUP=docker
GROUP_ID=5000

SAMBA_USER=docker
SAMBA_PASS=admin
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

#### 3. Configuration des partages Samba
**Explication :**
````
Nom du partage : homes
Descriptif     : Dossier de l'utilisateur (/home/XXXX)

Nom du partage : SYSTEm
Information    : Le compte docker utilise les droits du compte root pour ce partage
Descriptif     : Dossier Racine de l'utilisateur
````

##### **/etc/samba/smb.conf** (C'est une commande)
````console
echo "#======================= Global Settings =======================
[global]
   workgroup = WORKGROUP
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   panic action = /usr/share/samba/panic-action %d
   server role = standalone server
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user
   usershare allow guests = yes
#====================== Partage home ========================
[homes]
   comment = Dossier Utilisateurs
   browseable = no
   read only = no
   writable = yes
   create mask = 0700
   directory mask = 0700
   guest ok = no
#====================== Partage Volumes =====================
[Volumes]
   comment = Utilisateur docker qui prend les droits root
   path = /home/docker/volumes
   browseable = yes
   writable = yes
   read only = no
   valid users = docker
   force user = root
#====================== Partage System ======================
[SYSTEM]
   comment = Utilisateur docker qui prend les droits root
   path = /
   browseable = yes
   writable = yes
   read only = no
   valid users = docker
   force user = root
#============================================================
#======================= No Delete Line Next =======================
;   write list = root, @lpadmin
#===================================================================" > /etc/samba/smb.conf ;
systemctl restart smbd ;
systemctl status smbd ;
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

````
https://github.com/dexter74/Docker/blob/main/1.Installation_Docker.sh
````
________________________________________________________________________________________________________________________________________________________________
##  :gear:        6. **Création du conteneur Portainer.**
````
https://github.com/dexter74/Docker/blob/main/2.Install_Portainer.sh:
````
________________________________________________________________________________________________________________________________________________________________
##  :magnet:      7. **Création des volumes contenant les accès aux partages.**
````
https://github.com/dexter74/Docker/blob/main/3.Volumes.sh
````
________________________________________________________________________________________________________________________________________________________________
##  :chains:      8. **Ajout des Endpoints dans Portainer.**
````
Commande:
````
________________________________________________________________________________________________________________________________________________________________
##  :shield:      9. **Création du stack applicatif.**  
````
Commande:
````
________________________________________________________________________________________________________________________________________________________________
##  :axe:       10. **Reverse Proxy via Pfsense.**
````
Commande:
````
________________________________________________________________________________________________________________________________________________________________




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LIEN_WSDD]:https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/ 
