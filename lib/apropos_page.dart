import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AproposPage extends StatelessWidget {
  const AproposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📖 À propos')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bannière fruits en haut (remplace l'image absente)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Column(
                children: [
                  const Text('🍎 🍊 🍋 🍇 🍓', style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 12),
                  const Text(
                    'FruitQuiz',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Section description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carte : description
                  _CarteInfo(
                    emoji: '🎯',
                    titre: 'Le concept',
                    contenu:
                        'FruitQuiz est un jeu de réflexes développé dans le cadre d\'un cours d\'initiation à Flutter. '
                        'Le joueur doit identifier le bon fruit parmi 9 cases en un minimum de temps.',
                  ),

                  const SizedBox(height: 16),

                  // Carte : technologie
                  _CarteInfo(
                    emoji: '🛠️',
                    titre: 'Technologie',
                    contenu:
                        'Cette application est développée avec Flutter & Dart. '
                        'Elle utilise les widgets StatelessWidget, StatefulWidget, Timer, Navigator et bien d\'autres.',
                  ),

                  const SizedBox(height: 16),

                  // Carte : auteur
                  _CarteInfo(
                    emoji: '👨‍💻',
                    titre: 'Réalisé par',
                    contenu:
                        'Des étudiants passionnés de développement mobile.\n'
                        'Projet scolaire — Cours d\'initiation Flutter.',
                  ),

                  const SizedBox(height: 28),

                  // Bouton site web
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final Uri url = Uri.parse('https://flutter.dev');
                        launchUrl(url);
                      },
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text('Voir notre site web'),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget carte d'info réutilisable
class _CarteInfo extends StatelessWidget {
  final String emoji;
  final String titre;
  final String contenu;

  const _CarteInfo({
    required this.emoji,
    required this.titre,
    required this.contenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  contenu,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}