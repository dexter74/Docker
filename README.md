________________________________________________________________________________________________________________________________________________________________
<p align="center"><img width="460" height="300" src="https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png"></p>

________________________________________________________________________________________________________________________________________________________________

# **<p align=center>Mise en place de l'environnement</align>** #


________________________________________________________________________________________________________________________________________________________________
##  :alembic:     0. Déclaration des variables pour la suite

#### A. Se connecter en root:
````console
root@host:$ sudo -i
````

#### B. Insertion des varables:
````console
root@host:$
RELEASE_DEBIAN=buster
USERS=docker
PASSWORD=admin
USERS_ID=2000
USER_HOME=/home/docker
GROUP=docker
GROUP_ID=5000
SAMBA_USER=Drthrax74
SAMBA_PASS=Azerty74@
````
________________________________________________________________________________________________________________________________________________________________
##   :satellite:   1.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
#### A.Purge de l'utilisateur, de son dossier propre et du Groupe
````console
root@host:$ 
deluser $USERS ; 
rm -r $USER_HOME ;
delgroup $GROUP_ID ;
````
#### B.Création du Groupe, Utilisateur
````console
root@host:$ 
addgroup $GROUP --gid $GROUP_ID ;
useradd $USERS --uid $USERS_ID --home $USER_HOME --create-home --groups root,sudo,$GROUP --gid root --shell /bin/bash ;
echo "$USERS:$PASSWORD" | chpasswd ;
````
________________________________________________________________________________________________________________________________________________________________
##  :microscope:  2.**Installation Samba**
#### A. Installation de Samba

````console
root@host:$
echo "deb http://ftp.de.debian.org/debian $RELEASE_DEBIAN  main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````

#### B. Création du compte de partage Samba

````console
root@host:$
smbpasswd -d $SAMBA_USER ;
smbpasswd -x $SAMBA_USER ;

(echo $SAMBA_PASS; echo $SAMBA_PASS; echo ) | smbpasswd -a $SAMBA_USER ;
smbpasswd -e $SAMBA_USER ;
systemctl restart smbd ;
````

#### C. Configuration des partages Samba
**Note d'information:**
````
Nom du partage : homes
Descriptif     : Dossier de l'utilisateur (/home/XXXX)

Nom du partage : SYSTEm
Information    : Le compte docker utilise les droits du compte root pour ce partage
Descriptif     : Dossier Racine de l'utilisateur
````
***Commandes Terminal:**
````console
root@host:$
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
##  :petri_dish:   3. **Prise en charge de la découverte réseau pour Windows**
````console
root@host:$
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
##  :test_tube:   4. **Installation de Docker**

````
https://github.com/dexter74/Docker/blob/main/1.Installation_Docker.sh
````

#### A.Nettoyage du système:
````console
root@host:$
apt autoremove --purge -y docker-ce docker-ce-cli containerd.io ;
rm -rf /var/lib/docker ;
rm -rf /var/lib/containerd ;
rm -rf /etc/docker ;
clear ;
````

#### B. Installation des dépendances:
````console
root@host:$
apt install -y apt-transport-https ca-certificates gnupg-agent gnupg2 software-properties-common sudo curl ;
````

####  C. Ajout de la clé
````console
root@host:$
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - ;
````
#### D. Ajout du dépôt Docker pour Debian
````console
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" ;
````

#### E. Installation de Docker-Engine
````console
root@host:$
apt update ;
apt install -y docker-ce docker-ce-cli containerd.io ;
````
#### F. Modifier l'utilisateur qui lancer le service Docker
````console
root@host:$
sed -i 's/SocketUser=root/User=docker/g' /lib/systemd/system/docker.socket ;
sed -i 's/SocketGroup=docker/SocketGroup=docker/g' /lib/systemd/system/docker.socket ;
systemctl daemon-reload ;
````
#### G. Modification des permissions:
````console
root@host:$
sudo chown docker:docker /var/run/docker.sock ;

````
#### H. Vérification du lancement:
````console
root@host:$
docker run hello-world ;

````
#### I. Installation de Docker-compose (En date du 30-01-2021 : La version est 1.27.4)
````console
root@host:$
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose ;
chmod +x /usr/local/bin/docker-compose ;
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose ;
````

#### J. Vérification des versions
````console
root@host:$
docker --version ;
docker-compose --version ;
````

#### K. nettoyage des conteneurs
````console
root@host:$
docker kill $(docker ps -q) ;
docker rm $(docker ps -a -q) ;
docker rmi $(docker images -q) ;
````

#### L. Connexion au Docker-hub
````console
root@host:$
docker login -u <user> <password> ;
````

________________________________________________________________________________________________________________________________________________________________
##  :gear:        5. **Création du conteneur Portainer.**
````
https://github.com/dexter74/Docker/blob/main/2.Install_Portainer.sh:
````
________________________________________________________________________________________________________________________________________________________________
##  :magnet:      6. **Création des volumes contenant les accès aux partages.**
````
https://github.com/dexter74/Docker/blob/main/3.Volumes.sh
````
________________________________________________________________________________________________________________________________________________________________
##  :chains:      8. **Ajout des Endpoints dans Portainer.**
````
Un endpoint est l'URL de sortie du conteneur. (Exemple.com)
Si un conteneur a comme port 80 en sortie, l'URL http://Exemple.com:80
````
________________________________________________________________________________________________________________________________________________________________
##  :shield:      9. **Création du stack applicatif.**  
````
Aller dans Endpoints désirer puis aller dans Stack.
Une fois dans le Stack Coller le code docker-compose
Puis cliquer Déployer.
Les images seront télécharger et le conteneur créer avec les paramètres.
Le docker-hub est le site de référence.
````
________________________________________________________________________________________________________________________________________________________________
:octocat:        10. ** Pfsense - Acme
````
Aller dans Pfsense > Général > Paquet > Acme.
````
________________________________________________________________________________________________________________________________________________________________
##  :axe:        11. **Pfsense - Reverse Proxy**

````
Aller dans Pfsense > Général > Paquet  > Ha-proxy
````
________________________________________________________________________________________________________________________________________________________________




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LIEN_WSDD]:https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/ 
[Markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#tables
[EMOTICONE]: https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md#science
[COLOR]: https://stackoverflow.com/questions/11509830/how-to-add-color-to-githubs-readme-md-file
