###########################
# Nettoyage de la console #
###########################
clear ;

########################
# Deblocage Qbitorrent #
########################
FOLDER_DL=mnt/DL/Qbitorrent


# Arreter le conteneur
docker stop QBitTorrent ;

# Deblocage IP
echo "WebUI\HostHeaderValidation=false" >> /home/docker/volumes/QBitTorrent/qBittorrent/qBittorrent.conf ;

# Chemin de Telechargement
echo "Downloads\SavePath=/mnt/DL/$FOLDER_DL" >> /home/docker/volumes/QBitTorrent/qBittorrent/qBittorrent.conf ;

# Definir Langue Interface
echo "General\Locale=fr_FR" >> /home/docker/volumes/QBitTorrent/qBittorrent/qBittorrent.conf ;


# Demarrer le conteneur
docker start QBitTorrent ;
