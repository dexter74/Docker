________________________________________________________________________________________________________________________________________________________________
<p align="center"><img width="460" height="300" src="https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png"></p>

________________________________________________________________________________________________________________________________________________________________

# **<p align=center>Mise en place de l'environnement</align>** 

La mise en place de l'environnement se fait en plusieurs étape .

________________________________________________________________________________________________________________________________________________________________
##  :alembic:     I. **Déclaration des variables pour la suite.**

#### A. Se connecter en root:
````console
root@host:$ sudo -i
````

#### B. Installation de paquet indispensable
````console
root@host:$ 
apt install -y -qq 

````
#### C. Insertion des varables:
````console
root@host:$
RELEASE_DEBIAN=buster
USERS=docker
PASSWORD=admin
USERS_ID=2000
USER_HOME=/home/docker
GROUP=docker
GROUP_ID=5000
SAMBA_USER=$USERS
SAMBA_PASS=Admindu74
````
________________________________________________________________________________________________________________________________________________________________
##   :satellite:   II. **Création d'un groupe d'utilisateur avec son utilisateur dédiée.**

#### A.Purge de l'utilisateur, de son dossier propre et du Groupe
````console
root@host:$
/usr/sbin/deluser $USERS ;
rm -r $USER_HOME ;
/usr/sbin/delgroup $GROUP_ID ;
````
#### B.Création du Groupe, Utilisateur
````console
root@host:$
/usr/sbin/addgroup $GROUP --gid $GROUP_ID ;
/usr/sbin/useradd $USERS --uid $USERS_ID --home $USER_HOME --create-home --groups root,sudo,$GROUP --gid root --shell /bin/bash ;
echo "$USERS:$PASSWORD" |  /usr/sbin/chpasswd ;
````
________________________________________________________________________________________________________________________________________________________________
##  :microscope:  III. **Installation Samba.**

#### A. Installation de Samba

````console
root@host:$
echo "deb http://ftp.de.debian.org/debian $RELEASE_DEBIAN  main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y qq samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````

#### B. Création du compte de partage Samba

````console
root@host:$
smbpasswd -d $SAMBA_USER ;
smbpasswd -x $SAMBA_USER ;

(echo $SAMBA_PASS; echo $SAMBA_PASS) | smbpasswd -a $SAMBA_USER ;
smbpasswd -e $SAMBA_USER ;
systemctl restart smbd ;
pdbedit -L ;
````

#### C. Configuration des partages Samba
**Note d'information:**
````
Nom du partage : homes
Descriptif     : Dossier de l'utilisateur (/home/XXXX)

Nom du partage : SYSTEM
Information    : Le compte docker utilise les droits du compte root pour ce partage
Descriptif     : Dossier Racine de l'utilisateur
````

**Commandes Terminal:**
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
##  :petri_dish:   IV. **Prise en charge de la découverte réseau pour Windows.**

````console
root@host:$
apt install -y -qq unzip ;

# Purger le service:
rm -r /tmp/* ;
systemctl stop wsdd ;
systemctl disable wsdd ;
rm /etc/systemd/system/wsdd.service ;
rm /usr/bin/wsdd ;
systemctl daemon-reload ;

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
systemctl status wsdd ;
````

**Projet:** [WSDD][LIEN_WSDD]
________________________________________________________________________________________________________________________________________________________________
##  :test_tube:   V. **Installation de Docker.**

#### A. Nettoyage du système
````console
root@host:$
apt autoremove --purge -y docker-ce docker-ce-cli containerd.io ;
rm -rf /var/lib/docker ;
rm -rf /var/lib/containerd ;
rm -rf /etc/docker ;
clear ;
````

#### B. Installation des dépendances
````console
root@host:$
apt install -y -qq apt-transport-https ca-certificates gnupg-agent gnupg2 software-properties-common sudo curl ;
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
apt install -y -qq docker-ce docker-ce-cli containerd.io ;
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
systemctl restart docker.s* ;
systemctl | grep "docker.service\|docker.socket" | grep running ;
````

#### H. Vérification du lancement:
````console
root@host:$
docker run hello-world ;
````
________________________________________________________________________________________________________________________________________________________________
## VI. Installation de Docker-compose (En date du 30-01-2021 : La version est 1.27.4)

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
docker login -u <user> -p <password> ;
````

#### M. Modifier l'emplacement des volumes par défaut de Docker
````console
echo '[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service containerd.service
Wants=network-online.target
Requires=docker.socket containerd.service

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still exists and systemd currently does not support the cgroup feature set required for containers run by docker

# Ligne commenter: ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
ExecStart=/usr/bin/dockerd --data-root /home/docker/ -H fd:// --containerd=/run/containerd/containerd.sock
ExecReload=/bin/kill -s HUP $MAINPID
TimeoutSec=0
RestartSec=2
Restart=always

# Note that StartLimit* options were moved from "Service" to "Unit" in systemd 229.
# Both the old, and new location are accepted by systemd 229 and up, so using the old location
# to make them work for either version of systemd.
StartLimitBurst=3

# Note that StartLimitInterval was renamed to StartLimitIntervalSec in systemd 230.
# Both the old, and new name are accepted by systemd 230 and up, so using the old name to make
# this option work for either version of systemd.
StartLimitInterval=60s

# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

# Comment TasksMax if your systemd version does not support it.
# Only systemd 226 and above support this option.
TasksMax=infinity

# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes

# kill only the docker process, not all processes in the cgroup
KillMode=process
OOMScoreAdjust=-500

[Install]
WantedBy=multi-user.target' > /lib/systemd/system/docker.service ; systemctl daemon-reload ; systemctl restart docker.* ;
````


**Erreur**
````console
root@hostname:$
systemctl status docker.* | grep docker ;
Your kernel does not support swap memory limit
level=warning msg="Your kernel does not support CPU realtime scheduler"
level=warning msg="Your kernel does not support cgroup blkio weight"
level=warning msg="Your kernel does not support cgroup blkio weight_device"
````

**Information Système**
````console
root@hostname:$
uname -r ;
4.19.0-13-amd64
````

**Correctif:**
````console
root@hostname:$
systemctl reboot ; # En général sa suffit


echo deb http://deb.debian.org/debian buster-backports main contrib non-free | sudo tee /etc/apt/sources.list.d/buster-backports.list ;
sudo apt update ;
sudo apt install -y -t buster-backports linux-image-amd64 ;
sudo apt install -y -t buster-backports firmware-linux firmware-linux-nonfree ;
sudo rm /etc/apt/sources.list.d/buster-backports.list ;
systemctl reboot ;
````

**Information Système**
La mise à niveau du kernel à corriger le problème.
````console
root@hostname:$
uname -r ;
5.9.0-0.bpo.5-amd64
````


________________________________________________________________________________________________________________________________________________________________
##  :gear:        VII. **Création du conteneur Portainer.**

#### A. Arret de Portainer (Securite)
````console
root@host:$
docker kill portainer ;
docker rm portainer ;
````

#### B. Nettoyage de Portainer (Securité)
````console
root@host:$
docker volume rm Portainer_Data ;
docker container rm portainer ;
docker image rm portainer/portainer -f ;
docker image rm portainer/portainer-ce -f ;
clear ;
````

#### C. Création du Volume Portainer_Data
````console
root@host:$
docker volume create Portainer_Data ;
````

#### D. Téléchargement de l'image de Portainer
````console
root@host:$
docker pull portainer/portainer-ce ;
````

#### E. Création du Conteneur Portainer
````console
root@host:$
docker run -d -p 8000:8000 -p 9000:9000 \
      --label container="portainer" \
      --name=Portainer-CE \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v Portainer_Data:/data portainer/portainer-ce ;
````

`http://192.168.1.X:9000`

#### F. Protéger le Volume Portainer contre la suppression accidentel
````console
root@host:$
chattr +i /home/docker/volumes/Portainer_Data ;
````


#### G. Supprimer la Protection du volume de Portainer (Option)
````console
root@host:$
chattr -i /home/docker/volumes/Portainer_Data ;
````

________________________________________________________________________________________________________________________________________________________________
##  :magnet:      VIII. **Création des volumes contenant les accès aux partages.**
````
https://github.com/dexter74/Docker/blob/main/3.Volumes.sh
````
________________________________________________________________________________________________________________________________________________________________
##  :chains:      IX. **Ajout des Endpoints dans Portainer.**
````
Un endpoint est l'URL de sortie du conteneur. (Exemple.com)
Si un conteneur a comme port 80 en sortie, l'accès au service se fera sur l'URL suivante : http://Exemple.com:80
````
________________________________________________________________________________________________________________________________________________________________
##  :shield:      X. **Création du stack applicatif.**  
````
Aller dans Endpoints désirer puis aller dans Stack.
Une fois dans le Stack Coller le code docker-compose
Puis cliquer Déployer.
Les images seront télécharger et le conteneur créer avec les paramètres.
Le docker-hub est le site de référence.
````
________________________________________________________________________________________________________________________________________________________________
:octocat:        XI. ** Pfsense - Acme
````
Aller dans Pfsense > Général > Paquet > Acme.
````
________________________________________________________________________________________________________________________________________________________________
##  :axe:        XII. **Pfsense - Reverse Proxy**

````
Aller dans Pfsense > Général > Paquet  > Ha-proxy
````
________________________________________________________________________________________________________________________________________________________________




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LIEN_WSDD]:https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/ 
[Markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#tables
[EMOTICONE]: https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md#science
[COLOR]: https://stackoverflow.com/questions/11509830/how-to-add-color-to-githubs-readme-md-file
