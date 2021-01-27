########################################
# Nettoyage / Suppression de Portainer #
########################################
clear ; 
# Relance de Docker
systemctl restart docker.* ;

# Arret et suppression du conteneur Portainer
docker kill portainer ;
docker rm portainer ;

# Desactivation de la Protection Anti-suppression du volume
# chattr -i /home/docker/volumes/portainer_data ;

# Purge de portainer (volume, conteneur et image)
docker volume rm portainer_data ;
docker container rm portainer ;
docker image rm portainer/portainer -f ;
docker image rm portainer/portainer-ce -f ;

#############################
# Installation de Portainer #
#############################

# Creer le volume
docker volume create portainer_data ;

# Telecharger l'image
docker pull portainer/portainer-ce ;

# Cree le conteneur Portainer (--no-auth)
docker run -d -p 8000:8000 -p 9000:9000 --label container="portainer" --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce ;

# Activation de la Protection Anti-suppression du volume
# chattr +i /home/docker/volumes/portainer_data ;
