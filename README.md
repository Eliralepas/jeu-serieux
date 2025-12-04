# Archi Pole Nord ![Statut](https://img.shields.io/badge/Statut-En%20cours-yellow)

Pour notre projet T3 (2e année de BUT Informatique), nous avons développé un **jeu sérieux** intitulé **Archi North Pole**. <br>
Un **jeu sérieux en 2D** où le joueur incarne un architecte chargé de rénover la **station polaire Concordia**. Il doit concevoir des espaces adaptés à un **environnement extrême, confiné et multinational** (français et italien). <br> <br>

<p align="center"> <img src="archipolenord.png"  alt="Aperçu du jeu Archi Pole Nord"/> </p>

## Technologies utilisées
- **Godot Engine 4.3**
- **GDScript**
- **PixelArt** pour les sprites et interfaces
- **GitHub/GitLab** pour la gestion de tâches et du développement collaboratif (projet en mirroir)

## Installation et exécution
1. **Cloner le dépôt**
  ```bash
  git clone https://github.com/mon-utilisateur/polar-station.git
  cd polar-station
  ```
2. **Installer Godot**
Télécharge la version stable de **Godot 4.3 ou supérieure** : <br>
Télécharger **Godot Engine**

4. **Lancer le projet**
- Ouvre le dossier archi-pole-nord/ dans Godot
- Clique sur "Play Scene" (touche F5) pour exécuter le jeu

## Fonctionnalités principales
- Cycle jour/nuit et système météorologique dynamique
- Gestion des ressources (stocks, commandes de fournitures)
- Mini-jeux de maintenance (réparation de générateur, recalibrage d’antennes, etc.)
- Prise de décision morale et stratégique influençant le scénario


### Differentes salles:
- Cuisine: une salle de repas
- Dortoir: salle de repos
- Salle: salle de detente 
- Salle de bain: salle d'hygienne
- Haule:salle permetant l'access a toutes les salles

### Magasin:
Le magasin est une "salle" accessible par toutes les autres salle a partir d'un bouton sur le menu. Le magasin propose donc d'acheter differents articles (maximum 4), afin d'ameliorer l'ambience de chaque salle en plaisant au maximum de résidents.
Il prendra en compte un budget donner au debut de la partie et qui diminue a chaque achat. 
Un vendeur est present, il posséde des dialogues qui expliquent la limite d'objets, ainsi que l'impossibilité d'acheter si jamais le budget est trop bas ou que l'objet est deja possédé. Le magasin a:
  - Une garnde zone où s'afficheront les objets achetables (des checkbox).
  - Une zone de texte pour afficher les dialogues du vendeur.
  - Un bouton "acheter" pour finaliser l'achat et retourner à la salle.
  - Un bouton "sortir" pour retourner à la salle sans faire d'achat.

### Menu contextuelle:
Ce menu est sur la droite de l'ecran, il s'affiche quand le joueur est a l'interrieur d'une piece, ce menu presentera:
  - Le montant du budget restant.
  - Une option pour changer la couleur du mur.
  - Un bouton pour acceder au magasin.
  - Un bouton pour sortir de la salle.
  - Une zone libre ou s'afficheront des checkbox des objets achetés pour décider de les poser ou non.

### Réparation: 
Dans chaque salle il y a des objets deja presents, des objets par defauts. Parmis eux certain sint deja dans le menu contextuelle, et le joueur peut decider de les "retirer" de la salle.
Aussi, Certain de ces objets sont cassés, les réparer a un cout, si le joueur ne souhaite pas les réparer ou n'a pas l'argent il peut alors les retirer depuis le menu. 

