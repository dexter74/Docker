###############################
Volume_1=portainer_data
Volume_2=Cloud9
Volume_3=MariaDB
Volume_4=Plex
Volume_5=Sonarr
Volume_6=Radarr
Volume_8=QbitTorrent
PARM=+i
##############################


# Nettoyage de la console
clear ;



# Activation de la protection:
chattr $PARM /home/docker/volumes/$Volume_1
chattr $PARM /home/docker/volumes/$Volume_2
#chattr $PARM /home/docker/volumes/$Volume_3
#chattr $PARM /home/docker/volumes/$Volume_4
#chattr $PARM /home/docker/volumes/$Volume_5
