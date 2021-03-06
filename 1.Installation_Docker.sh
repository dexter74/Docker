#####################################################################################################################################
# Guide:                                                                                                                            #
# - Non Root  : https://julienc.io/blog/utiliser_le_client_docker_sans_etre_root/                                                   #
# - Volume    : https://stackoverflow.com/questions/36014554/how-to-change-the-default-location-for-docker-create-volume-command    #
#####################################################################################################################################

########################################
# Editer les identifiants des partages #
########################################

########################
# Nettoyage du système #
########################
apt autoremove --purge -y docker-ce docker-ce-cli containerd.io ;
rm -rf /var/lib/docker ;
rm -rf /var/lib/containerd ;
rm -rf /etc/docker ;
clear ;


################################
# Installation des dépendances #
################################
apt install -y apt-transport-https ca-certificates gnupg-agent gnupg2 software-properties-common sudo curl ;


############################################
# Ajout de la clé Dépôt docker pour Debian #
############################################
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - ;

#####################################
# Ajout du dépôt Docker pour Debian #
#####################################
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" ;

#################################
# Installation de Docker-Engine #
#################################
apt update ;
apt install -y docker-ce docker-ce-cli containerd.io ;

#######################################################
# Modifier l'utilisateur qui lancer le service Docker #
#######################################################
sed -i 's/SocketUser=root/User=docker/g' /lib/systemd/system/docker.socket ;
sed -i 's/SocketGroup=docker/SocketGroup=docker/g' /lib/systemd/system/docker.socket ;
systemctl daemon-reload ;

# Appartenenance du socket (Défaut: root:systemd-coredump)
sudo chown docker:docker /var/run/docker.sock ;


##################################
# Vérification du fonctionnement #
##################################
# systemctl reboot  ;
docker run hello-world ;


##################################
# Installation de Docker-compose #
##################################
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose ;
chmod +x /usr/local/bin/docker-compose ;
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose ;

#####################
# Check des version #
#####################
docker --version ;
docker-compose --version ;

###############################
# Nettoyage du contenu Docker #
###############################
docker kill $(docker ps -q) ;
docker rm $(docker ps -a -q) ;
docker rmi $(docker images -q) ;


##########################
# Connexion à Docker-hub #
##########################
docker login -u dexter74 -p 382000 ;


###################################
# Changer emplacement des volumes #
###################################
# Dossier par defaut : /var/lib/docker/volumes
# nano /lib/systemd/system/docker.service
# Avant : ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
# Apres : ExecStart=/usr/bin/dockerd --data-root /home/docker/ -H fd:// --containerd=/run/containerd/containerd.sock
# systemctl daemon-reload
# systemctl restart docker.*


#####################################
# Volumes de Partage Windows, Samba #
#####################################
# Protection anti-suppression desactiver
#chattr -i /home/docker/volumes/Video ;
#chattr -i /home/docker/volumes/Films ;

# Suppression des Volumes
#docker volume rm Video ;
#docker volume rm Films ;

# Partage Windows depuis Drthrax74
#docker volume create --driver local --opt type=cifs --name Films \
#     --opt device=//192.168.1.10/Films/ \
#     --opt o=username=Partage,password=XXXX,vers=2.0,file_mode=0777,dir_mode=0777


# Partage Samba depuis le NAS
#docker volume create --driver local --opt type=cifs  --name Video \
#     --opt device=//192.168.1.2/Video \
#     --opt o=username=Drthrax74,password=XXXX,vers=3.0,file_mode=0777,dir_mode=0777


# Protection anti-suppression activer
#chattr +i /home/docker/volumes/Films
#chattr +i /home/docker/volumes/Video
