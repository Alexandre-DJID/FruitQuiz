# Projet Flutter – Mini Jeu

## Membres du groupe
- DJIDONOU Edgard
- AVA Chancelle
- KIKI Hermione

## Thème choisi
**Fruits** 🍎🍊🍋🍇🍓

## Description du jeu
Le joueur doit identifier et cliquer sur le bon fruit parmi 9 cases affichées à l'écran.
Chaque partie, un fruit cible est affiché en haut de l'écran et le joueur dispose de 3 secondes
pour le retrouver dans la grille. Une bonne réponse rapporte +5 points, une mauvaise coûte -2 points.
La grille se renouvelle automatiquement toutes les 3 secondes.

## Modifications réalisées
- Remplacement des cases colorées par des emojis de fruits (🍎 🍊 🍋 🍇 🍓 🍍 🥭 🍑 🫐)
- Ajout d'un fruit cible affiché clairement au joueur avant chaque round
- Ajout d'un timer visuel (compte à rebours de 3 secondes) qui change de couleur
- Amélioration de l'interface de la page d'accueil avec des tuiles colorées et des icônes
- Amélioration du formulaire de contact avec des icônes, des hints et un message de confirmation (SnackBar)
- Amélioration de la page À propos avec une bannière et des cartes d'information
- Application d'un thème visuel cohérent (couleurs vertes et orangées) sur toute l'application

## Difficultés rencontrées
- Gestion du Timer : le `timerCompte` provoquait un `LateInitializationError` au lancement du jeu
- Utilisation de caractères accentués dans les noms de variables Dart (interdit par le langage)
- Compréhension de la différence entre `StatelessWidget` et `StatefulWidget` pour la page de jeu
- Mise en page responsive avec `Expanded`, `Column` et `Row` imbriqués

## Solutions ou apprentissages
- Remplacement de `late Timer` par `Timer?` (nullable) et utilisation de l'opérateur `?.` pour les appels sécurisés
- Suppression des accents dans tous les noms de variables et méthodes (`fruitsAffiches`, `_demarrerCompte`)
- Apprentissage de `initState()` et `dispose()` pour gérer le cycle de vie des Timers
- Utilisation de `BoxDecoration` avec `borderRadius` et `boxShadow` pour améliorer l'UI
- Utilisation de `ScaffoldMessenger.of(context).showSnackBar()` pour les retours utilisateur

## Améliorations possibles
- Ajouter des niveaux de difficulté (réduire le temps à 2s ou 1s)
- Ajouter des sons lors des bonnes et mauvaises réponses
- Afficher un écran de fin de jeu avec le score final
- Sauvegarder le meilleur score avec `shared_preferences`
- Ajouter des animations sur les cartes lors du tap