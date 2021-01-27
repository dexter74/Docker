### Mise en place de l'environnement ###

##### Etape 1: Création d'utilisateur sous le NAS #####
##### Etape 2: Création de partage (Video et DL)  #####
##### Etape 3: Modification des permissions sur le partage  #####
````
Activer le mode ACL
````
##### Etape 4: Vérification des permissions #####

##### Etape 5: Installation de Docker, Docker-compose #####
##### Etape 6: Création du conteneur Portainer #####
##### Etape 7: Création des volumes contenant les accès aux partages  #####

````
Les volumes DL et Video sont les partages, il suffit de les montées dans un conteneur et le tour est jouer.
````

##### Etape 8: Création du STACK  #####
````
Pour les conteneur Plex,Sonarr, Radarrc c'est le partage Video qui est monté.
Pour le conteneur Qbitorrent, c'est le partage DL qui est monté.
````

##### Etape 9: Reverse Proxy via Pfsense  #####
