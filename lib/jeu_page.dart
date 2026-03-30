import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class JeuPage extends StatefulWidget {
  const JeuPage({super.key});

  @override
  State<JeuPage> createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage> {
  int positionBonFruit = 0;
  int score = 0;
  int tempsRestant = 3;
  Timer? timerJeu;
  Timer? timerCompte;

  // Liste de fruits : le fruit cible et les leurres
  final List<String> fruits = ['🍎', '🍊', '🍋', '🍇', '🍓', '🍍', '🥭', '🍑', '🫐'];
  String fruitCible = '🍎';
  List<String> fruitsAffiches = [];

  @override
  void initState() {
    super.initState();
    nouveauJeu();
    timerJeu = Timer.periodic(const Duration(seconds: 3), (timer) {
      nouveauJeu();
    });
    _demarrerCompte();
  }

  void _demarrerCompte() {
    timerCompte?.cancel();
    tempsRestant = 3;
    timerCompte = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        tempsRestant--;
        if (tempsRestant <= 0) {
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timerJeu?.cancel();
    timerCompte?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎮 Trouve le fruit !')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Score + timer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Score
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '$score pts',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Timer
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: tempsRestant <= 1
                          ? Colors.red.shade600
                          : Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '$tempsRestant s',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Consigne : trouver le fruit cible
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFC107), width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Trouve : ', style: TextStyle(fontSize: 18)),
                  Text(
                    fruitCible,
                    style: const TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Grille 3x3
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Expanded(child: Row(children: [carte(1), carte(2), carte(3)])),
                      Expanded(child: Row(children: [carte(4), carte(5), carte(6)])),
                      Expanded(child: Row(children: [carte(7), carte(8), carte(9)])),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Règles
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '✅ Bonne réponse : +5 pts   ❌ Mauvaise : -2 pts',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carte(int position) {
    final String fruitDeLaCarte = fruitsAffiches[position - 1];
    final bool estLaBonne = position == positionBonFruit;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (estLaBonne) {
              score += 5;
            } else {
              score -= 2;
              if (score < 0) score = 0;
            }
          });
          nouveauJeu();
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF81C784),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              fruitDeLaCarte,
              style: const TextStyle(fontSize: 34),
            ),
          ),
        ),
      ),
    );
  }

  void nouveauJeu() {
    final random = Random();

    // Choisir un fruit cible aléatoire
    fruitCible = fruits[random.nextInt(fruits.length)];

    // Construire la grille de 9 cases : 1 bonne + 8 leurres
    positionBonFruit = random.nextInt(9) + 1;

    // Leurres = tous les autres fruits sauf le fruit cible
    final List<String> leurres = fruits.where((f) => f != fruitCible).toList();
    leurres.shuffle();

    fruitsAffiches = List.generate(9, (index) {
      if (index == positionBonFruit - 1) return fruitCible;
      return leurres[index % leurres.length];
    });

    // Redémarrer le compte à rebours
    timerCompte?.cancel();
    _demarrerCompte();

    setState(() {});
  }
}