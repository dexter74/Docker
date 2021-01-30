____
![alt text][LOGO]
____
# **<p align=center>Mise en place de l'environnement</align>** #

La mise en place de l'environnement ce fait en plusieurs étapes.
____

##   :satellite:   1.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
````console
root@host:~$ deluser docker     ; 
             rm -r /home/docker ;
             delgroup docker    ;

root@host:~$ addgroup docker --gid 2000 ;
             useradd docker --uid 2000 --home /home/docker/ --create-home --groups root,sudo,docker --gid root --shell /bin/bash ;
             echo "docker:admin" | chpasswd ;
````


____
##  :microscope:  2.**Installation de Samba**
````console
root@host:~$ 
echo "deb http://ftp.de.debian.org/debian buster main" > /etc/apt/sources.list.d/Buster.list ;
apt update ;
apt install -y samba ;
rm /etc/apt/sources.list.d/Buster.list ;
````
____
##  :petri_dish:  3. **Création du Partage.**
````console
root@host:~$ 
(echo docker; echo docker; echo ) | smbpasswd -a docker ;
smbpasswd -e docker ;
systemctl restart smbd ;
````
____

##  :alembic:     4. **Création du compte de partage Samba.**
____

##  :test_tube:   5. **Installation de Docker, Samba.**

____

##  :gear:        6. **Création du conteneur Portainer.**
____

##  :magnet:      7. **Création des volumes contenant les accès aux partages.**
____

##  :chains:      8. **Ajout des Endpoints dans Portainer.**
____

##  :shield:      9. **Création du stack applicatif.**  
____

##  :axe:       10. **Reverse Proxy via Pfsense.**
____
***
Liens: [ICI][LINES_1]
****




[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LINES_1]: #
