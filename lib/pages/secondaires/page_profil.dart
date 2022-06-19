import 'package:ask_in_usthb/pages/secondaires/mes_questions.dart';
import 'package:flutter/material.dart';
import '../widgets/inputs/changer_mot_de_passe.dart';
import '../../models/utilisateur.dart';

class Profil extends StatelessWidget {
  Utilisateur utilisateur;
  Profil({Key? key, required this.utilisateur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Mon profil",
            style: TextStyle(color: Colors.white),
          ),
          leading: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              label: const Text(""))),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Hero(
              tag: "avatar",
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: const Color.fromARGB(255, 27, 36, 48)),
                      shape: BoxShape.circle),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    minRadius: MediaQuery.of(context).size.width * 0.2,
                    backgroundColor: const Color.fromARGB(255, 59, 172, 182),
                    // ignore: prefer_const_constructors
                    child: Text(
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      utilisateur.nomUtilisateur.substring(0, 2).toUpperCase(),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                // ignore: prefer_const_constructors
                child: Text(
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  utilisateur.nomUtilisateur,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("+13"),
                      Text("votes"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("7"),
                      Text("Reponses"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("2"),
                      Text("Questions"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          scrollable: true,
                          content: ChangerMotPasse()),
                      barrierDismissible: true,
                    );
                  },
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    color: Colors.lightBlue,
                  ),
                  label: const Text("Changer le mot de passe ")),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MesQuestions(utilisateur: utilisateur),
                        ));
                  },
                  icon: const Icon(
                    Icons.question_answer_rounded,
                    color: Colors.lightBlue,
                  ),
                  label: const Text("Mes Questions")),
            ),
          ],
        ),
      ),
    );
  }
}
