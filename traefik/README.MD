### Guide ####

***Il existe deux type d'écriture de configuration: Statique et Dynamique***

***Problème :***
````
Le montage des volumes de partage provoque des lags. Montage du volume sur le host puis monté sur le conteneur
````


````
https://doc.traefik.io/traefik/routing/overview/
- Entrypoints   : Écoutent le trafic entrant (ports, ...)
- Routeurs      : Analysent les demandes (hôte, chemin, en-têtes, SSL, ...) Prise en charge des certificats et reverse proxy
- Services      : Transmettre la demande à vos services (équilibrage de charge, ...) comme le service Plex.
- Providers     : Les découvrent les services qui vivent de votre infrastructure (ip, santé, ...) comme Docker.
````


#### Schéma ####
````
Entrypoint > Routeur > Service
                     > Dashboard
                     
````

### Ecoute de port ####
````
https://doc.traefik.io/traefik/routing/entrypoints/
Les EntryPoints sont les points d'entrée du réseau dans Traefik.
Ils définissent le port qui recevra les paquets et s'il faut écouter TCP ou UDP.
````

### Routeur ###
````
https://doc.traefik.io/traefik/routing/routers/
Un routeur est chargé de connecter les demandes entrantes aux services qui peuvent les traiter. 
Dans le processus, les routeurs peuvent utiliser des morceaux de middleware pour mettre à jour la demande, ou agir avant de transmettre la demande au service.
````
### Services ###
````
https://doc.traefik.io/traefik/routing/services/
Les Services sont responsables de la configuration de la manière d'atteindre les services réels qui traiteront éventuellement les demandes entrantes.
````
