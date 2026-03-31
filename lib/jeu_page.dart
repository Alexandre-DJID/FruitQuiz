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
  bool jeuEnCours = true;
  Timer? timerCompte;

  final List<String> fruits = ['🍎', '🍊', '🍋', '🍇', '🍓', '🍍', '🥭', '🍑', '🫐'];
  String fruitCible = '🍎';
  List<String> fruitsAffiches = [];
  int carteSelectionnee = -1;

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
      if (!mounted) return;
      setState(() {
        tempsRestant--;
      });
      if (tempsRestant <= 0) {
        t.cancel();
        timerJeu?.cancel();
        jeuEnCours = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _afficherGameOver();
        });
      }
    });
  }

  void _afficherGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Column(
            children: [
              Text('😢', style: TextStyle(fontSize: 52)),
              SizedBox(height: 8),
              Text(
                'Temps ecoulé !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tu n\'as pas trouvé le fruit à temps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      'Score final : $score pts',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  score = 0;
                  jeuEnCours = true;
                });
                timerJeu = Timer.periodic(const Duration(seconds: 3), (timer) {
                  nouveauJeu();
                });
                nouveauJeu();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Rejouer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home_rounded),
              label: const Text('Accueil'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2E7D32),
                side: const BorderSide(color: Color(0xFF2E7D32)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        );
      },
    );
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Text(fruitCible, style: const TextStyle(fontSize: 36)),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            carteSelectionnee = position;
            if (estLaBonne) {
              score += 5;
            } else {
              score -= 2;
              if (score < 0) score = 0;
            }
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            nouveauJeu();
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: carteSelectionnee == position
                ? (estLaBonne ? const Color(0xFF4CAF50) : const Color(0xFFE53935))
                : const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: carteSelectionnee == position
                  ? (estLaBonne ? const Color(0xFF2E7D32) : const Color(0xFFB71C1C))
                  : const Color(0xFF81C784),
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
    if (!jeuEnCours) return;
    final random = Random();
    fruitCible = fruits[random.nextInt(fruits.length)];
    positionBonFruit = random.nextInt(9) + 1;

    final List<String> leurres = fruits.where((f) => f != fruitCible).toList();
    leurres.shuffle();

    fruitsAffiches = List.generate(9, (index) {
      if (index == positionBonFruit - 1) return fruitCible;
      return leurres[index % leurres.length];
    });

    timerCompte?.cancel();
    _demarrerCompte();

    carteSelectionnee = -1;
    setState(() {});
  }
}