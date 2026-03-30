import 'package:flutter/material.dart';
import 'apropos_page.dart';
import 'contact_page.dart';
import 'jeu_page.dart';
import 'quitter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🍉 FruitQuiz')),
      body: Column(
        children: [
          // Header de bienvenue
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D32),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  '🍊 🍋 🍇 🍓 🍍',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bienvenue dans FruitQuiz !',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Testez vos réflexes avec les fruits',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Grille de navigation
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _TuileMenu(
                          emoji: '🎮',
                          label: 'Jouer',
                          couleur: const Color(0xFFE8F5E9),
                          couleurBord: const Color(0xFF4CAF50),
                          couleurTexte: const Color(0xFF1B5E20),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const JeuPage()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _TuileMenu(
                          emoji: '📖',
                          label: 'À propos',
                          couleur: const Color(0xFFFFFDE7),
                          couleurBord: const Color(0xFFFFC107),
                          couleurTexte: const Color(0xFFE65100),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AproposPage()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      children: [
                        _TuileMenu(
                          emoji: '✉️',
                          label: 'Contact',
                          couleur: const Color(0xFFE3F2FD),
                          couleurBord: const Color(0xFF42A5F5),
                          couleurTexte: const Color(0xFF0D47A1),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ContactPage()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _TuileMenu(
                          emoji: '🚪',
                          label: 'Quitter',
                          couleur: const Color(0xFFFFEBEE),
                          couleurBord: const Color(0xFFEF5350),
                          couleurTexte: const Color(0xFFB71C1C),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const QuitterPage()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Footer
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Cours d\'initiation Flutter',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget tuile réutilisable — même concept GestureDetector + Container
class _TuileMenu extends StatelessWidget {
  final String emoji;
  final String label;
  final Color couleur;
  final Color couleurBord;
  final Color couleurTexte;
  final VoidCallback onTap;

  const _TuileMenu({
    required this.emoji,
    required this.label,
    required this.couleur,
    required this.couleurBord,
    required this.couleurTexte,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: couleur,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: couleurBord, width: 2),
            boxShadow: [
              BoxShadow(
                color: couleurBord.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: couleurTexte,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}