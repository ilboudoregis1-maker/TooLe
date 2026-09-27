# TooLe — CNS.corp

Première version prototype Flutter de TooLe.

## Contenu
- Inscription / connexion de démonstration
- Navigation Chat / Group / Statut / Special / Paramètres
- Special : TooLe AI + Jeu
- Thèmes clair/sombre
- Couleurs d'accent
- Français / English / Mooré (base d'interface)
- Icônes Material high-tech, sans stickers

## Dans Termux

Prérequis : Flutter installé et accessible avec `flutter`.

```bash
unzip TooLe.zip
cd TooLe
flutter pub get
flutter analyze
flutter run
```

Cette version est un prototype UI. L'authentification, la messagerie serveur, les groupes, les statuts, TooLe AI et le jeu devront être connectés à leurs vrais services dans les prochaines versions.
