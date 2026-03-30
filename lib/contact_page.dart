import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomController = TextEditingController();
    final TextEditingController prenomController = TextEditingController();
    final TextEditingController mailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('✉️ Contact')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bloc intro
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF81C784)),
                  ),
                  child: Row(
                    children: [
                      const Text('🍃', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Nous sommes disponibles pour toute question. Laissez-nous un message !',
                          style: TextStyle(fontSize: 14, color: Color(0xFF1B5E20)),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Champ Nom
                const Text(
                  'Nom',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: nomController,
                  decoration: const InputDecoration(
                    hintText: 'Votre nom',
                    prefixIcon: Icon(Icons.person_outline, color: Color(0xFF4CAF50)),
                  ),
                ),

                const SizedBox(height: 16),

                // Champ Prénom
                const Text(
                  'Prénom',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: prenomController,
                  decoration: const InputDecoration(
                    hintText: 'Votre prénom',
                    prefixIcon: Icon(Icons.badge_outlined, color: Color(0xFF4CAF50)),
                  ),
                ),

                const SizedBox(height: 16),

                // Champ Email
                const Text(
                  'E-mail',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'exemple@mail.com',
                    prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF4CAF50)),
                  ),
                ),

                const SizedBox(height: 16),

                // Champ Message
                const Text(
                  'Message',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Écrivez votre message ici...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Icon(Icons.message_outlined, color: Color(0xFF4CAF50)),
                    ),
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 28),

                // Bouton Envoyer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print(
                        "Formulaire\n\nNom : ${nomController.text}\nPrénom : ${prenomController.text}\nMail : ${mailController.text}\nMessage : ${messageController.text}\n",
                      );

                      // Snackbar de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Text('🍊 ', style: TextStyle(fontSize: 18)),
                              Text('Message envoyé avec succès !'),
                            ],
                          ),
                          backgroundColor: const Color(0xFF2E7D32),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Envoyer le message'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}