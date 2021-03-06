#################################################
# Etape 0: Suppression du compte dedie à Docker #
#################################################
deluser docker ;
rm -r /home/docker ;
delgroup docker ;

################################################
# Etape 0: Création d'un compte dédié à Docker #
################################################
addgroup docker --gid 74240 ;
useradd docker --uid 1001 --home /home/docker/ 	--create-home --groups root,sudo,docker --gid root --shell /bin/bash ;
echo "docker:admin" | chpasswd ;

################################################
# Etape 2: Rendre le dossier accessible à tous #
################################################
chmod 777 /home/docker ;

##################################
# Etape 3: Installation de Samba #
##################################
# echo "deb http://ftp.de.debian.org/debian buster main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;

############################################
# Etape 4: Création d'un utilisateur Samba #
############################################
# Ajout, activation du compte de partage docker et relance du samba:
(echo docker; echo docker; echo ) | smbpasswd -a docker ;
smbpasswd -e docker ;
systemctl restart smbd ;

##########################################
# Etape 5 : Activer la découverte réseau #
##########################################
# https://devanswers.co/discover-ubuntu-machines-samba-shares-windows-10-network/
apt install -y unzip ;

# Purge du dossier Temportaire:
rm -r /tmp/* ;

# Telechargement et decompression:
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


###################################
# Etape 5: Configuration de Samba #
###################################
mv /etc/samba/smb.conf /etc/samba/smb.conf.old ;


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
#
#====================== Partage Volumes =====================
[Volumes]
comment = Utilisateur docker qui prend les droits root
path = /home/docker/volumes
browseable = yes
writable = yes
read only = no
valid users = docker
force user = root
#
#====================== Partage System ======================
[SYSTEM]
comment = Utilisateur docker qui prend les droits root
path = /
browseable = yes
writable = yes
read only = no
valid users = docker
force user = root
#
#============================================================

#======================= No Delete Line Next =======================
;   write list = root, @lpadmin
#===================================================================" > /etc/samba/smb.conf ;

systemctl restart smbd ;
systemctl status smbd ;

#########################################################################################################
