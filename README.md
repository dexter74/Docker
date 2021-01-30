****
![alt text][LOGO]
****

**Mise en place de l'environnement**

  1. Création d'un groupe d'utilisateur et de son utilisateur sous le NAS
    [ICI][LINES_1]
    
  2. Création de partage
  3. Modification des permissions sur le partage 
  4. Vérification des Permissions
  
  




__________

##### Etape 2:  #####

##### Etape 3: M #####
````Activer le mode ACL````

##### Etape 4:  #####
````Depuis un poste Windows, aller dans le partage avec les compte utilisateurs associciés. (Création, Suppression, Déplacement)````

##### Etape 5: Installation de Docker, Docker-compose #####


##### Etape 6: Création du conteneur Portainer #####
````La création du conteneur Portainer avec son volume Portainer_DATA doit être créer puis protéger.````

##### Etape 7: Création des volumes contenant les accès aux partages  #####

````La création de volume CIFS contenant les accès au partages Video et DL.````

##### Etape 8: Ajout des Endpoints dans Portainer #####
````Les Endpoints ou Points d'entrée serve d'URL pour le conteneur . (<MONENDPOINT>:PORT)````

##### Etape 9: Création du STACK  #####
````
Pour les conteneur Plex,Sonarr, Radarrc c'est le partage Video qui est monté.
Pour le conteneur Qbitorrent, c'est le partage DL qui est monté.
````

##### Etape 10: Reverse Proxy via Pfsense  #####





[LOGO]: https://www.clipartmax.com/png/full/146-1469802_logo-logo-docker.png
[LINES_1]: #
