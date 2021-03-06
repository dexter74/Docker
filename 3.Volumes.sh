##############################################
# Volume pour le montage dans les conteneurs #
##############################################

# Permission:
# Qbitorrent peux écrire dans DL     (Racine = Squelette = Verrouillé)
# Medias     peux écrire dans Videos (Racine = Squelette = Verrouillé)

USER_DL=Qbitorrent
PASS_DL=Admindu74@

USER_VIDEO=Medias
PASS_VIDEO=Azertydu74@


# Protection Anti-suppression OFF
chattr -i /home/docker/volumes/Video ;
chattr -i /home/docker/volumes/DL ;

# Supprimer Volume:
docker volume rm Video ;
docker volume rm DL ;

# Dossier DL et Video
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//192.168.1.2/dl \
        --opt o=username=$USER_DL,password=$PASS_DL,vers=3.0,file_mode=0777,dir_mode=0777 \
        --name DL

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//192.168.1.2/Video \
        --opt o=username=$USER_VIDEO,password=$PASS_VIDEO,vers=3.0,file_mode=0777,dir_mode=0777 \
        --name Video


# Protection Anti-suppression ON
chattr +i /home/docker/volumes/Video ;
chattr +i /home/docker/volumes/DL ;




####################################################################################################################################################################################################
# Creation d'un volume (Partage Windows 10)
# docker volume create --driver local --opt type=cifs --opt device=//192.168.1.10/Films  --opt o=username=Partage,password=Partage74,vers=2.0,file_mode=0777,dir_mode=0777  --name Films
####################################################################################################################################################################################################
#
#  ...
#  volumes:
#    - Video:/mnt/Video
#    - DL:/mnt/DL
#   ...
