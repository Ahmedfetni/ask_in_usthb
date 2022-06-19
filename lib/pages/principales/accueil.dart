import '../widgets/inputs/ajouter_une_question.dart';
import '../widgets/list_des_cartes_questions.dart';
import '../secondaires/navigation.dart';
import 'package:flutter/material.dart';
import '../secondaires/rechercher_par_tag.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class PageAccueil extends StatelessWidget {
  const PageAccueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();
    return Scaffold(
      drawer: const Navigation(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 143, 157),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Toutes les questions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        /* Le boutton de recherche  */
        actions: [
          TextButton.icon(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RecherchParTag(),
                );
              },
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              label: const Text("")),
        ],
      ),
      body: Stack(
        children: [
          ListDesCartesQuestions(),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: user != null,
              child: Container(
                margin: const EdgeInsets.only(right: 12, bottom: 12),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 0, 255, 198),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor:
                            const Color.fromARGB(255, 85, 178, 190),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        scrollable: true,
                        content: AjouterUneQuestion(context: context),
                      ),
                      barrierDismissible: true,
                    );
                  },
                  elevation: 10,
                  child: const Icon(
                    Icons.question_mark_rounded,
                    size: 30,
                    color: Colors.white, // Color.fromARGB(255, 48, 170, 221),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
