------------------------------------------------------------------------------------------------------------------------------------------------------------------------

![alttext](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png?v=4&s=4000)

# <p align=center> **.:| [Image Docker provenant de DockerLinux] |:.** </center>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 1. **Sécurisation du serveur:**
```` 
https://github.com/dexter74/Linux/blob/main/Securisation/Debian_10.MD
````
### 2. **Liens Utiles pour LinuxServer**
[Fleet](https://fleet.linuxserver.io/) (Liste des images)

[Mode](https://mods.linuxserver.io/)

[Volumes 3.0](https://github.com/dexter74/Docker/blob/main/Volumes/Stack)

[GUI_APPZ](https://hub.docker.com/r/lsiobase/gui) 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 3. **Developpement**
````yaml
#################
version: '2.1'  #
services:       #
#################
##########################################################################################################################
  XXXXX:
    image: 'linuxserver/'
    container_name: 'CN_'
    network_mode: 'bridge'
    restart: 'no'
    hostname: ''
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '10XX:80'
    volumes:
      - 'XXXXX:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


### 4. **Image de la Base de donnée MariaDB**
````yaml
#################
version: '2.1'  #
services:       #
#################
##########################################################################################################################
  MariaDB:
    image: 'linuxserver/mariadb'
    container_name: 'CN_MariaDB'
    network_mode: 'bridge'
    restart: 'unless-stopped'
    hostname: 'MariaDB'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      MYSQL_ROOT_PASSWORD: 'root'
      MYSQL_DATABASE: 'database'
      MYSQL_USER: 'admin'
      MYSQL_PASSWORD: 'admin'
    volumes:
      - 'MariaDB:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 6. **Docker-compose : Divers**
````yaml
##########################################################################################################################
# Multimedia - Streamer Musique
  AirSonic:
    container_name: 'CN_AirSonic'
    image: 'linuxserver/airsonic'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'AirSonic'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1000:4040'
    volumes:
      - 'AirSonic:/config'
      - 'AirSonic:/media'
      - 'AirSonic:/playlists'
      - 'AirSonic:/podcasts'
      - 'Musique:/music'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - Telecharger les sous-titres
  Bazarr:
    container_name: 'CN_Bazarr'
    image: 'linuxserver/bazarr'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Bazarr'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1001:6767'
    volumes:
      - 'Bazarr:/config'
      - 'Bazarr:/movies'
      - 'Bazarr:/tv'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Hebergement - Image (Requis : MariaDB)
  Chevereto:
    container_name: 'CN_Chevereto'
    image: 'linuxserver/chevereto'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Chevreto'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1002:80'
    volumes:
      - 'Chevereto:/config'
      - 'Chevereto:/data'
    external_links:
      - 'CN_MariaDB:mysql'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Editeur - Interface de Développement WebUi
  Cloud9:
    container_name: 'CN_Cloud9'
    image: 'linuxserver/cloud9'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Cloud9'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      USERNAME: 'admin'
      PASSWORD: 'admin'
    ports:
      - '1003:8000'
    volumes:
      - 'Cloud9:/code'
    labels:
       cacher: 'non'

# Préférences > Code Editor
# > Cocher "Wrap Selection with bracket, Quotes.
# > Décocher Show Print Margin
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - Media Downloader (Sonarr, Radarr)
  CouchPotato:
    container_name: 'CN_CouchPotato'
    image: 'linuxserver/couchpotato'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'CouchPotato'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1004:5050'
    volumes:
      - 'CouchPotato:/config'
      - 'CouchPotato:/downloads'
      - 'CouchPotato:/movies'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Multimedia - Streamer Musique (Mac, Unix, Windows)
  Daapd:
    container_name: 'CN_Daapd'
    image: 'linuxserver/daapd'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Daapd'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    volumes:
      - 'Daapd:/config'
      - 'Daapd:/Podcasts'
      - 'Daapd:/Audiobooks'
      - 'Daapd:/Compilations'
      - 'Musique:/music'
    ports:
      - '1005:3689/tcp'
#      - '3689:3688'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Automatisation Téléchargement
# Protocole: SFTP, FTP, FTPS
  Davos:
    container_name: 'CN_Davos'
    image: 'linuxserver/davos'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Davos'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1006:8080/tcp'
    volumes:
      - 'Davos:/config'
      - 'Davos:/download'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Torrent - Client Torrent (Info, Warning, Error)
  Deluge:
    container_name: 'CN_Deluge'
    image: 'linuxserver/deluge'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Deluge'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      DELUGE_LOGLEVEL: 'warning'
    ports:
      - '1007:8112'
    volumes:
      - 'Deluge:/config'
      - 'Deluge:/downloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# DNS - Doc: http://climato.free.fr/upload/ddclient.pdf
  DDClient:
    image: 'linuxserver/ddclient'
    container_name: 'CN_DDClient'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DDClient'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    volumes:
      - 'DDClient:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Editeur - Retouche Photo
  DigiKam:
    image: 'linuxserver/digikam'
    container_name: 'CN_DigiKam'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DigiKam'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1008:3000'
    volumes:
      - 'DigiKam:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Editeur - Markdown
  DillinGer:
    image: 'linuxserver/dillinger'
    container_name: 'CN_DillinGer'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DillinGer'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1009:8080'
    volumes:
      - 'DillinGer:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Wikipedia
  DokuWiki:
    image: 'linuxserver/dokuwiki'
    container_name: 'CN_DokuWiki'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DokuWiki'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1010:80'
    volumes:
      - 'DokuWiki:/config'
    labels:
       cacher: 'non'
# http://IP:PORT/install.php
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Explorateur - Gestionnaire de Fichier TOP
  DoubleCommander:
    image: 'linuxserver/doublecommander'
    container_name: 'CN_DoubleCommander'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DoubleCommander'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1011:3000'
    volumes:
      - 'DoubleCommander:/config'
      - 'DoubleCommander:/data'
      - 'Video:/mnt/Video:ro'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# DNS
  DuckDNS:
    image: 'linuxserver/duckdns'
    container_name: 'CN_DuckDNS'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'DuckDNS'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      SUBDOMAINS: 'domain1.com,domain2.fr'
      TOKEN: 'XXXXXX'
      LOG_FILE: 'true'
    ports:
      - '1012:80'
    volumes:
      - 'DuckDNS:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Sauvegarde - Duplicati
  Duplicati:
    image: 'linuxserver/duplicati'
    container_name: 'CN_Duplicati'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Duplicati'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1013:8200'
    volumes:
      - 'Duplicati:/config'
      - 'Duplicati:/backups'
      - 'Duplicati:/source'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Multimedia - Lecteur Multimédia
  Emby:
    image: 'linuxserver/emby'
    container_name: 'CN_Emby'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Emby'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1014:8096'
    volumes:
      - 'Emby:/config'
      - 'Emby:/data/tvshows'
      - 'DL:/data/DL:ro'
      - 'Musique:/data/music:ro'
      - 'Video:/data/movies:ro'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# https://hub.docker.com/r/linuxserver/htpcmanager | https://github.com/HTPC-Manager/HTPC-Manager
# ?????
  HTPC-Manager:
    image: 'linuxserver/htpcmanager'
    container_name: 'CN_HTPC-Manager'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'HTPC-Manager'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1015:8085'
    volumes:
      - 'HTPCManager:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - Télécharger de la Musique
  HeadPhones:
    image: 'linuxserver/headphones'
    container_name: 'CN_HeadPhones'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'HeadPhones'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1016:8181'
    volumes:
      - 'HeadPhones:/config'
      - 'HeadPhones:/downloads'
      - 'HeadPhones:/music'
      - 'DL:/mnt/DL:ro'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Editeur - 
  HedgeDoc:
    image: 'linuxserver/hedgedoc'
    container_name: 'CN_HedgeDoc'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'HedgeDoc'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      DB_HOST: 'mysql'
      DB_USER: 'admin'
      DB_PASS: 'admin'
      DB_NAME: 'database'
      DB_PORT: '3306'
    ports:
      - '1017:3000'
    volumes:
      - 'HedgeDoc:/config'
    external_links:
      - 'CN_MariaDB:mysql'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Supervision - Espace de Bureau
  HeimDall:
    image: 'linuxserver/heimdall'
    container_name: 'CN_HeimDall'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'HeimDall'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1018:80'
    volumes:
      - 'HeimDall:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Domotique - Gestion d'appareil
  HomeAssistant:
    image: 'linuxserver/homeassistant'
    container_name: 'CN_HomeAssistant'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'HomeAssistant'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1019:8123'
    volumes:
      - 'HomeAssistant:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# ??????
  IPFS:
    image: 'linuxserver/ipfs'
    container_name: 'CN_IPFS'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'IPFS'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1020:80'
#      - '4001:4001'
#      - '5001:5001'
#      - '8080:8080'
    volumes:
      - 'IPFS:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# https://hub.docker.com/r/linuxserver/jellyfin | Nvidia : https://github.com/NVIDIA/nvidia-docker
# Multimedia - Lecteur Video
  JellyFin:
    image: 'linuxserver/jellyfin'
    container_name: 'CN_JellyFin'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'JellyFin'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1021:8096'
    volumes:
      - 'JellyFin:/config'
      - 'DL:/mnt/DL:ro'
      - 'Musique:/mnt/Musique:ro'
      - 'Video:/mnt/Video:ro'
    devices:
      - '/dev/dri:/dev/dri'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# https://docplayer.fr/113904123-Controler-kodi-a-la-voix-installation-de-la-skill-kanzi-pour-alexa.html
# Vocal - Contrôler appareil avec la voix
  Kanzi:
    image: 'linuxserver/kanzi'
    container_name: 'CN_Kanzi'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Kanzi'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      INVOCATION_NAME: 'kanzi'
      URL_ENDPOINT: 'http://192.168.10.5:1022'
    ports:
      - '1022:8000'
    volumes:
      - 'Kanzi:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Username / Password : kodi
# Multimedia - Requiert des pré-requis
  Kodi-HeadLess:
    image: 'linuxserver/kodi-headless'
    container_name: 'CN_Kodi-HeadLess'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Kodi-HeadLess'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1023:8080'
 #     - '9090:9090'
 #     - '9001:9000'

    volumes:
      - 'Kodi-HeadLess:/config/.kodi'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# ??????
  LDAP-Auth:
    image: 'linuxserver/ldap-auth'
    container_name: 'CN_LDAP-Auth'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'LDAP-Auth'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1024:8888'
 #     - '9002:9000'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# https://github.com/linuxserver/docker-letsencrypt/blob/master/README.md
# DNS -
  LetsEncrypt:
    image: 'linuxserver/letsencrypt'
    container_name: 'CN_LetsEncrypt'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'LetsEncrypt'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      URL: 'teste74.ddns.net'
      SUBDOMAINS: 'www,ftp,cloud'
      VALIDATION: 'http'
      EMAIL: 'teste74@hotmail.fr'
    ports:
      - '1025:80'
#      - '443:443'
    volumes:
      - 'LetsEncrypt:/config'
    labels:
       cacher: 'non'

##########################################################################################################################
````

````yaml
##########################################################################################################################
# Speedtest : http://192.168.10.5:1026/results/stats.php
# ADSLTEST
  LibreSpeed:
    image: 'linuxserver/librespeed'
    container_name: 'CN_LibreSpeed'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'LibreSpeed'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      CUSTOM_RESULTS: 'true'
      DB_TYPE: 'mysql'
      DB_HOSTNAME: 'mysql'
      DB_NAME: 'database'
      DB_USERNAME: 'admin'
      DB_PASSWORD: 'admin'
    ports:
      - '1026:80'
    volumes:
      - 'LibreSpeed:/config'
    external_links:
      - 'CN_MariaDB:mysql'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - Télécharger de la Musique (https://hub.docker.com/r/linuxserver/lidarr)
  Lidarr:
    image: 'linuxserver/lidarr'
    container_name: 'CN_Lidarr'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Lidarr'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1027:8686'
    volumes:
      - 'Lidarr:/config'
      - 'Musique:/Music'
      - 'DL:/downloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - Torrent, Newsgroups
  Medusa:
    image: 'linuxserver/medusa'
    container_name: 'CN_Medusa'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Medusa'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1028:8081'
    volumes:
      - 'Medusa:/config'
      - 'Medusa:/downloads'
      - 'Medusa:/tv'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Doc: https://wiki.minetest.net/Command_line
# Gaming - Serveur de jeu Minitest
  MiniTest:
    image: 'linuxserver/minetest'
    container_name: 'CN_MiniTest'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Minitest'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
#      CLI_ARGS: '--gameid minetest'
    ports:
      - '1029:30000/udp'
    volumes:
      - 'MiniTest:/config'
      - 'MiniTest:/config/.minetest'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Mods : KO (Port: 1030)
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Multimedia - Lecteur de Musique, Vidéos
  Mstream:
    image: 'linuxserver/mstream'
    container_name: 'CN_Mstream'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Mstream'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      USER: 'admin'
      PASSWORD: 'admin'
      USE_JSON: 'true'
    ports:
      - '1031:3000'
    volumes:
      - 'Mstream:/config'
      - 'Mstream:/music'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# ???? - A tester
  MusicBrainz:
    image: 'linuxserver/musicbrainz'
    container_name: 'CN_MusicBrainz'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'MusciBrainz'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      BRAINZCODE: ''
      WEBADDRESS: '192.168.10.5'
    ports:
      - '1032:5000'
    volumes:
      - 'MusicBrainz:/config'
      - 'MusicBrainz:/data'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Supervision -
  MuxiMux:
    image: 'linuxserver/muximux'
    container_name: 'CN_MuxiMux'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'MuxiMux'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1033:80'
    volumes:
      - 'MuxiMux:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Supervision - MYSQL
  MYSQL-WorkBench:
    image: 'linuxserver/mysql-workbench'
    container_name: 'CN_Mysql-WorkBench'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'MYSQL-WorkBench'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1034:3000'
    volumes:
      - 'MYSQL-WorkBench:/config'
    external_links:
      - 'CN_MariaDB:mysql'
    cap_add:
      - 'IPC_LOCK'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# docker run --rm --entrypoint /genesis.sh linuxserver/nano > /root/nano_key
# Cryptomonnaie - Core
  Nano:
    image: 'linuxserver/nano'
    container_name: 'CN_Nano'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Nano'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      CLI_OPTIONS: '--config node.enable_voting: true'
      PEER_HOST: '127.0.0.1'
    ports:
      - '1035:3000'
    volumes:
      - 'Nano:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Cryptomonnaie - Porte-feuille
  Nano-Wallet:
    image: 'linuxserver/nano-wallet'
    container_name: 'CN_Nano-Wallet'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Nano-Wallet'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1036:80'
    volumes:
      - 'nano-wallet:/config'
    links:
      - 'Nano'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# PXE - Serveur PXE
  NetBootXYZ:
    image: 'linuxserver/netbootxyz'
    container_name: 'CN_NetBootXYZ'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'NetBootXYZ'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
#      PORT_RANGE: '30000:30010'
    ports:
      - '1037:3000'
#      - '69:69'
#      - '80:80'
#      - '30000:30010'
    volumes:
      - 'NetBootXYZ:/config'
      - 'NetBootXYZ:/assets'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# https://fleet.linuxserver.io/ | https://mods.linuxserver.io/
# ?????
  NetBox:
    image: 'linuxserver/netbox'
    container_name: 'CN_NetBox'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'NetBox'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      SUPERUSER_EMAIL: 'teste74@hotmail.fr'
      SUPERUSER_PASSWORD: 'biohazard74'
      BASE_PATH: 'none'
      DB_HOST: 'mysql'
      DB_PORT: '3306'
      DB_NAME: 'database'
      DB_USER: 'admin'
      DB_PASSWORD: 'admin'
      REDIS_HOST: 'NetBox'
      REDIS_PORT: '6379'
      REDIS_PASSWORD: 'admin'
      VERSION: 'v2.2.1'
    external_links:
      - 'CN_MariaDB:mysql'
    ports:
      - '1038:8000'
#      - '1002:6379'
    volumes:
      - 'NetBox:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# CLOUD - Stockage de fichier en ligne
  NextCloud:
    image: 'linuxserver/nextcloud'
    container_name: 'CN_NextCloud'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'NextCloud'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1039:443'
    volumes:
      - 'NextCloud:/config'
      - 'NextCloud:/data'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Web - Serveur Web
  Nginx:
    image: 'linuxserver/nginx'
    container_name: 'CN_Nginx'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Nginx'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1040:80'
 #     - '443:443'
    volumes:
      - 'Nginx:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - 
  NZBGet:
    image: 'linuxserver/nzbget'
    container_name: 'CN_Nzbget'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'NZBGet'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1041:6789'
    volumes:
      - 'NZBGet:/config'
      - 'NZBGet:/dowloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Warez - 
  NZBHydra2:
    image: 'linuxserver/nzbhydra2'
    container_name: 'CN_Nzbhydra2'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'NBZHydra2'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1042:5076'
    volumes:
      - 'NZBHydra2:/config'
      - 'NZBHydra2:/downloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Requete - Fichier Warez 
  Ombi:
    image: 'linuxserver/ombi'
    container_name: 'CN_Ombi'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Ombi'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      BASE_URL: '/ombi'
    ports:
      - '1043:3579'
    volumes:
      - 'Ombi:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Alpine Distribution
# docker run --rm -it --entrypoint /keygen.sh linuxserver/openssh-server
# SSH - Serveur SSH 
  openssh-server:
    image: 'linuxserver/openssh-server'
    container_name: 'CN_OpenSSH-Server'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'OpenSSH'
    domainname: 'labs'
    dns: 
      - '8.8.8.8'
      - '192.168.1.1'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      PUBLIC_KEY: 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAs+2hvOiFJvMh7Tdmle+bAYLwEyErLFYE74ljUny/2D2zl6XTZmBw7JEdD3H9mXqeJTk/BGEa2Sn4G0OkwrYH6xnXlwsLRB1Wosa2Q2vX1vG1MxU6e/t7ngsQ74wHGj6Nq5hNZP7EfTfTA6Jo26k9BU5+qj1C4Oq9uvurZuwVl9MYVX59CQb5jKIqgB/obllICqNaGk+msxDSEKh2gFzcEHLa0Kf8R6t+z1m79M+X5I0SLosQluc4edfj77Y3OqPNBooDt5i3MqAJWvzagGStQN2RSs3LUPaMSMleew2qKZEHRzl9u75MaAtKIpH7qe4xHPprDXAF1bKIa2PTNRv9HQ== teste74@hotmail.fr'
#      PUBLIC_KEY_FILE: '/path/to/pubkeys'
#      PUBLIC_KEY_DIR: ''
#      USER_PASSWORD_FILE: '/..../'
      USER_NAME: 'drthrax74'
      USER_PASSWORD: 'admin'
      PASSWORD_ACCESS: 'true'
      SUDO_ACCESS: 'true'
    ports:
      - '1044:2222'
    volumes:
      - 'CN_OpenSSH-Server:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# VPN - Serveur VPN
  OpenVPN-AS:
    image: 'linuxserver/openvpn-as'
    container_name: 'OpenVPN'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'OpenVPN-AS'
    domainname: 'labs'
    cap_add:
      - 'NET_ADMIN'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      INTERFACE: 'ens18'
    ports:
      - '1045:943'       # GUI
 #     - '9443:9443'      # TCP port
 #     - '1194:1194/udp'  # UDP port
    volumes:
      - 'OpenVPN-AS:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Supervision - 
  Organizr:
    image: 'linuxserver/organizr'
    container_name: 'CN_Organizr'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Organizr'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1046:80'
    volumes:
      - 'Organizr:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
  Oscam:
    image: 'linuxserver/oscam'
    container_name: 'CN_Oscam'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Oscam'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1047:8888'
    volumes:
      - 'Oscam:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Hébergement - Papermerge - Hébergement de fichier
  PaperMerge:
    image: 'linuxserver/papermerge'
    container_name: 'CN_PaperMerge'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Papermerge'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      REDIS_URL: 'Papermerge.labs:6379'
    ports:
      - '1048:8000'
    volumes:
      - 'PaperMerge:/config'
      - 'PaperMerge:/data'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Hebergement - Photoshow est un logiciel de galerie à son plus facile.
  PhotoShow:
    image: 'linuxserver/photoshow'
    container_name: 'CN_PhotoShow'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'PhotoShow'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1049:80'
    volumes:
      - 'PhotoShow:/config'
      - 'PhotoShow:/Pictures:ro'
      - 'PhotoShow:/Thumbs'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Hébergement - Photo
  PiwiGO:
    image: 'linuxserver/piwigo'
    container_name: 'CN_PiwiGO'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'PiwiGO'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1050:80'
    volumes:
      - 'PiwiGO:/config'
    labels:
       cacher: 'non'
########################################################################################################################## 
````



````yaml
##########################################################################################################################
# Hébergement - Pixapop: Affiher les photos sur une seule page (Basique)
  PixaPOP:
    image: 'linuxserver/pixapop'
    container_name: 'CN_PixaPOP'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'PixaPOP'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      APP_USERNAME: 'admin'
      APP_PASSWORD: 'admin'
    ports:
      - '1051:80'
    volumes:
      - 'PixaPOP:/config'
      - 'PixaPOP:/photos'
    labels:
       cacher: 'non'
##########################################################################################################################
````


````yaml
##########################################################################################################################
# Plex Claim       : https://www.plex.tv/claim/
# Docker Version   : docker, latest, public, 
# Docker-Hub Plex  : https://hub.docker.com/r/linuxserver/plex
# Docker Nvidia    : https://github.com/NVIDIA/nvidia-docker
# Multimedia - Lecteur Multimédia
  Plex:
    image: 'linuxserver/plex'
    container_name: 'CN_Plex'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Plex'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      PLEX_CLAIM: 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
      VERSION: 'docker'
    ports:
      # WebUI
      - '1052:32400'
      # DLNA
#      - '1900:1900/udp'
#      - '32469:32469'
      # for controlling Plex Home Theater via Plex Companion
#      - '3005:3005'
      # for older Bonjour/Avahi network discovery
#      - '5353:5353/udp'
      # for controlling Plex for Roku via Plex Companion
#      - '8324:8324'
      # for current GDM network discovery
#      - '32410:32410/udp'
#      - '32412:32412/udp'
#      - '32413:32413/udp'
#      - '32414:32414/udp'
    volumes:
      - 'Plex:/config'
      - 'Plex:/tv'
      - 'Video:/movies'
      - 'Music:/Music'
    devices:
      - "/dev/dri:/dev/dri" # Materiels
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
# Hebergement - Projectsend est une application pour l'hébergement de fichier (Download, Upload, Share Link)
  ProjectSend:
    image: 'linuxserver/projectsend'
    container_name: 'CN_ProjectSend'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'ProjectSend'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      MAX_UPLOAD: '50' # 50 MO
    ports:
      - '1053:80'
    volumes:
      - 'ProjectSend:/config'
      - 'ProjectSend:/data'
    external_links:
      - 'CN_MariaDB:mysql'
    labels:
       cacher: 'non'
########################################################################################################################## 
````

````yaml
##########################################################################################################################
# Audit: http://192.168.10.5:1054/Hack ( https://raw.githubusercontent.com/kgretzky/pwndrop/master/media/demo1.gif)
  PwnDrop:
    image: 'linuxserver/pwndrop'
    container_name: 'CN_PwnDrop'
    network_mode: 'bridge'
    restart: 'no'
    hostname: ''
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      SECRET_PATH: '/Hack' # http://XXX.XXX.XXX.XXX:1054/Hack
    ports:
      - '1054:8080'
    volumes:
      - 'PwnDrop:/config'
    labels:
       cacher: 'non'
##########################################################################################################################
````````

````yaml
##########################################################################################################################
# Hebergement - Pydio: Plateforme  pour le partage de fichiers et la synchronisation
  Pydio:
    image: 'linuxserver/pydio'
    container_name: 'CN_Pydio'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Pydio'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1055:443' # HTTPS
    volumes:
      - 'Pydio:/config'
    external_links:
      - 'CN_MariaDB:mysql'
    labels:
       cacher: 'non'
##########################################################################################################################
````````

````yaml
##########################################################################################################################
# Warez - Pyload est un gestionnaire de téléchargement DDL (admin:password)
  Pyload:
    image: 'linuxserver/pyload'
    container_name: 'CN_Pyload'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Pyload'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1056:8000' # HTTP
#      - '7227:7227'
    volumes:
      - 'Pyload:/config'
      - 'Pyload:/downloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````````

````yaml
##########################################################################################################################
# Editeur - Variante de Cloud9 (Meilleur que Cloud9)
  Pylon:
    image: 'linuxserver/pylon'
    container_name: 'CN_Pylon'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'Pylon'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      GITURL: 'https://github.com/linuxserver/docker-pylon.git'
      PYUSER: 'admin'
      PYPASS: 'admin'
    ports:
      - '1057:3131'
    volumes:
      - 'Pylon:/code'
    labels:
       cacher: 'non'
##########################################################################################################################
````````

````yaml
##########################################################################################################################
# Torrent - Client torrent
  QBitTorrent:
    image: 'linuxserver/qbittorrent'
    container_name: 'CN_QBitTorrent'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'QBitTorrent'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1058:8080'
      - '6881:6881'
    volumes:
      - 'QBitTorrent:/config'
      - 'QBitTorrent:/downloads'
    labels:
       cacher: 'non'
#       
# docker stop CN_QBitTorrent;
# echo "WebUI\HostHeaderValidation=false" >> /home/docker/volumes/QBitTorrent/_data/qBittorrent/qBittorrent.conf ;
# echo "General\Locale=fr_FR" >> /home/docker/volumes/QBitTorrent/_data/qBittorrent/qBittorrent.conf ;
# echo "Downloads\SavePath=/mnt/DL/Qbitorrent" >> /home/docker/volumes/QBitTorrent/_data/qBittorrent/qBittorrent.conf ;
# docker start CN_QBitTorrent ;
##########################################################################################################################
````````


````yaml
##########################################################################################################################
# Conteneur non fonctionnel en état (Requiert SQLite Ou PostgreSQL)
  Quassel-Core:
    image: 'linuxserver/quassel-core'
    container_name: 'CN_Quassel-Core'
    network_mode: 'bridge'
    restart: 'no'
    hostname: ''
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      RUN_OPTS: '--config-from-environment'
      DB_BACKEND: 'SQLite'             # SQLite Ou PostgreSQL
      DB_PGSQL_HOSTNAME: 'mysql'       # Hôte PostgreSQL
      DB_PGSQL_PORT: '3306'            # PostgreSQL Port
      DB_PGSQL_USERNAME: 'admin'       # Utilisateur de PostgreSQL
      DB_PGSQL_PASSWORD: 'admin'       # Mot de passe PostgreSQL
      AUTH_AUTHENTICATOR: 'Database'   # Database Ou LDAP
    external_links:
      - 'CN_MariaDB:mysql'
    ports:
      - '1059:4242'
      - '113:10113'
    volumes:
      - 'Quassel-Core:/config'
    labels:
       cacher: 'non'
##########################################################################################################################

##########################################################################################################################
# http://192.168.10.5:1059/quassel/
  quassel-web:
    image: 'linuxserver/quassel-web'
    container_name: 'CN_quassel-web'
    network_mode: 'bridge'
    restart: 'no'
    hostname: 'quassel-web'
    domainname: 'labs'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      QUASSEL_CORE: '192.168.10.5'
      QUASSEL_PORT: '1059'
      URL_BASE: '/quassel'
    ports:
      - '1060:64080'
    volumes:
      - 'quassel-web:/config'
    links:
      - Quassel-Core
    labels:
       cacher: 'non'
##########################################################################################################################
````````


````yaml

````


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
````yaml
##########################################################################################################################
  RuTorrent:
    container_name: 'CN_Rutorrent'
    image: 'linuxserver/rutorrent'
    network_mode: 'bridge'
    restart: 'no'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
    ports:
      - '1090:80'
    volumes:
      - 'RuTorrent:/config'
      - 'RuTorrent:/downloads'
    labels:
       cacher: 'non'
##########################################################################################################################
````

````yaml
##########################################################################################################################
  Transmission:
    container_name: 'CN_Transmission'
    image: 'linuxserver/transmission'
    network_mode: 'bridge'
    restart: 'no'
    environment:
      PUID: '1001'
      PGID: '74240'
      TZ: 'Europe/Paris'
      USER: 'admin'
      PASS: 'admin'
    ports:
      - '1091:9091'
    volumes:
      - 'Transmission:/config'
      - 'Transmission:/watch'
      - 'DL:/downloads'
      - 'Musique:/mnt/Musique'
      - 'Video:/mnt/Video'
    labels:
       cacher: 'non'
##########################################################################################################################
````
