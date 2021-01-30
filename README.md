****
![alt text][LOGO]
****
# **<p align=center>Mise en place de l'environnement</align>** #

La mise en place de l'environnement ce fait en plusieurs étapes.


:satellite:	  1. Création d'un groupe d'utilisateur avec son utilisateur dédiée pour le partage.
````console
+ drthrax74@Debian:~$ /usr/adduser marc \
                    addgroup marc
````
:microscope:  2.Création du partage avec prise en charge ACL.
  
:petri_dish:	3. Modification des permissions sur le partage.
  
:alembic:     4. Vérification des Permissions.
  
:test_tube:   5. Installation de Docker.
  
:gear:        6. Création du conteneur Portainer.
  
:magnet:	    7. Création des volumes contenant les accès aux partages.

:chains:      8. Ajout des Endpoints dans Portainer.
  
:shield:      9. Création du stack applicatif.
  
:axe:         10. Reverse Proxy via Pfsense.
  

- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `#test`


****
Liens: [ICI][LINES_1]
****





[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LINES_1]: #
