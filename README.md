# Archi Pole Nord ![Statut](https://img.shields.io/badge/Statut-En%20cours-yellow)

Pour notre projet T3 (2e année de BUT Informatique), nous avons développé un **jeu sérieux** intitulé **Archi North Pole**.  
Un **jeu sérieux en 2D** où le joueur incarne un architecte chargé de rénover la **station polaire Concordia**. Il doit concevoir des espaces adaptés à un **environnement extrême, confiné et multinational** (français et italien).

<p align="center"> 
  <img src="archipolenord.png" alt="Aperçu du jeu Archi Pole Nord"/> 
</p>

---

## Technologies utilisées
- **Godot Engine 4.3**
- **GDScript**
- **Pixel Art** pour les sprites et interfaces
- **GitHub/GitLab** pour la gestion de tâches et le développement collaboratif (projet en miroir)

---

## Installation et exécution
1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/mon-utilisateur/polar-station.git
   cd polar-station
   
2. **Installer Godot**  
   Téléchargez la version stable de **Godot 4.3 ou supérieure** depuis le site officiel : [Godot Engine](https://godotengine.org)

3. **Lancer le projet**  
   - Ouvrez le dossier `archi-pole-nord/` dans Godot  
   - Cliquez sur **Play Scene** (ou appuyez sur **F5**) pour exécuter le jeu

---

## Fonctionnalités principales
- Cycle jour/nuit et système météorologique dynamique  
- Gestion des ressources (stock, budget)  
- Maintenance (réparation d'objets cassés)  
- Prises de décision morales et stratégiques influençant le scénario  

---
## Le jeu
Voici les elements qu'on retrouve dans le gameplay:

### Différentes salles
- **Cuisine** : salle de repas  
- **Dortoir** : salle de repos  
- **Salle de détente**  
- **Salle de bain** : salle d’hygiène  
- **Hall** : permet l’accès à toutes les salles  

---

### Magasin
Accessible depuis toutes les salles via un bouton du menu.  
Il permet d’acheter jusqu’à **4 articles** pour améliorer l’ambiance et satisfaire les résidents.  

- Budget initial défini au début de la partie, diminuant à chaque achat  
- Vendeur avec dialogues expliquant les règles (limite d’objets, budget insuffisant, objet déjà possédé)  
- Interface :
  - Zone d’affichage des objets achetables (checkbox)  
  - Zone de texte pour les dialogues du vendeur  
  - Bouton **Acheter** pour finaliser l’achat  
  - Bouton **Sortir** pour quitter sans achat  

---

### Menu contextuel
Affiché à droite de l’écran lorsque le joueur est dans une pièce :  
- Montant du budget restant  
- Option pour changer la couleur des murs  
- Bouton pour accéder au magasin  
- Bouton pour sortir de la salle  
- Zone libre affichant les objets achetés (checkbox pour les placer ou non)  

---

### Réparation
Chaque salle contient des objets par défaut, certains cassés ou réparables :  

- Objets cassés reconnaissables par :
  - Fumée qui s’en dégage  
  - Apparence défectueuse  
  - Curseur changeant au survol  
- Interaction :
  - Clic sur l’objet → bouton **Réparer (prix)** apparaît  
  - Si réparé : le budget diminue, l’objet retrouve une apparence normale et n’est plus cliquable  

---

### Personnages
Chaque pièce contient trois personnages aux goûts variables selon la partie.  

- Interaction : clic sur un personnage → bulle affichant une icône d’objet avec un cœur (aime) ou une croix (n’aime pas)  
- Émotions :
  - Joie si l’objet aimé est présent  
  - Colère si un objet non apprécié est imposé  


---
## Images du jeu 

Bientot disponibles

---

## Auteurs
Projet réalisé dans le cadre du BUT Informatique (2e année, T3).  

- **Bennounas Fella** – Développement, Graphismes  
- **Meral Elif 2** – Développement, Graphismes   
- **Boudra Diya 3** – Développement
- **Fenard Aymeric 4** – Développement


---

## Licence
Ce projet est distribué sous licence **MIT**.  
Vous êtes libres de l’utiliser, le modifier et le redistribuer, à condition de conserver la mention des auteurs et de la licence.  

Pour plus de détails, consultez le fichier [LICENSE](LICENSE).

---

## Crédits
- **Sprites & Pixel Art** : réalisés par l’équipe  
- **Moteur de jeu** : [Godot Engine](https://godotengine.org)  
- **Inspiration** : station polaire Concordia T4 2025
- **Sujet** : Gossa Julien (professeur) 

