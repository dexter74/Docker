____
![alt text][LOGO]
____
# **<p align=center>Mise en place de l'environnement</align>** #

La mise en place de l'environnement ce fait en plusieurs étapes.
____

##   :satellite:   1.**Création d'un groupe d'utilisateur avec son utilisateur dédiée.**
````console
root@host:~$ deluser docker     ; 
root@host:~$ rm -r /home/docker ;
root@host:~$ delgroup docker    ;

root@host:~$ addgroup docker --gid 2000 ;
root@host:~$ useradd docker --uid 2000 --home /home/docker/ --create-home --groups root,sudo,docker --gid root --shell /bin/bash ;
root@host:~$ echo "docker:admin" | chpasswd ;
````
____
##  :microscope:  2.**Installation de Samba**
````console
root@host:~$ 
root@host:~$ echo "deb http://ftp.de.debian.org/debian buster main" > /etc/apt/sources.list.d/Buster.list ;
root@host:~$ apt update ;
root@host:~$ apt install -y samba ;
root@host:~$ rm /etc/apt/sources.list.d/Buster.list ;
````
____
##  :petri_dish:  3. **Création du compte de partage Samba**
````console
root@host:~$ SAMBA_USER=docker
root@host:~$ SAMBA_PASS=admin
root@host:~$ (echo $SAMBA_PASS; echo $SAMBA_PASS; echo ) | smbpasswd -a $SAMBA_USER ;
root@host:~$ smbpasswd -e $SAMBA_USER ;
root@host:~$ systemctl restart smbd ;
````
____

##  :alembic:     4. **Prise en charge de la découverte réseau pour Windows**
````console
root@host:~$ apt install -y unzip ;
root@host:~$ rm -r /tmp/* ;
root@host:~$ wget https://github.com/christgau/wsdd/archive/master.zip -O /tmp/master.zip ;
root@host:~$ unzip /tmp/master.zip -d /tmp ;
root@host:~$ mv /tmp/wsdd-master/src/wsdd.py /tmp/wsdd-master/src/wsdd ;
root@host:~$ cp /tmp/wsdd-master/src/wsdd /usr/bin ;
root@host:~$ cp /tmp/wsdd-master/etc/systemd/wsdd.service /etc/systemd/system ;
root@host:~$ sed -i 's/User=nobody/User=root/g' /etc/systemd/system/wsdd.service ;
root@host:~$ sed -i 's/Group=nobody/Group=root/g' /etc/systemd/system/wsdd.service ;
root@host:~$ systemctl daemon-reload ;
root@host:~$ systemctl start wsdd ;
root@host:~$ systemctl enable wsdd ;
root@host:~$ service wsdd status ;
````

**Projet WSDD:** ['ici'][WSDD]

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
[WSDD]: #
[LINES_1]: #
