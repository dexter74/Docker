____
![alt text][LOGO]
____
# **<p align=center>Mise en place de l'environnement</align>** #

La mise en place de l'environnement ce fait en plusieurs étapes.
____

##   :satellite:   1.**Création d'un groupe d'utilisateur avec son utilisateur dédiée pour le partage.**

____
##  :microscope:  2.**Création du partage avec prise en charge ACL.**
____

##  :petri_dish:  3. **Modification des permissions sur le partage.**
____

##  :alembic:     4. **Vérification des Permissions.**
____

##  :test_tube:   5. **Installation de Docker.**

**Nettoyage:**
````console
root@host:~$ deluser docker     ; 
root@host:~$ rm -r /home/docker ;
root@host:~$ delgroup docker    ;
````

**Création du Groupe Supervsion**
````console
root@host:~$ addgroup docker --gid 74240 ;
````
**Création du compte:** (Changement de mot de passe)
````console
root@host:~$ useradd docker --uid 1001 --home /home/docker/ --create-home --groups root,sudo,docker --gid root --shell /bin/bash ;
root@host:~$ echo "docker:admin" | chpasswd
````



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
