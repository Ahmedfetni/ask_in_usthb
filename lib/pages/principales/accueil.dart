import '../widgets/inputs/ajouter_une_question.dart';
import '../widgets/list_des_cartes_questions.dart';
import '../secondaires/navigation.dart';
import 'package:flutter/material.dart';
import '../secondaires/rechercher_par_tag.dart';

// ignore: camel_case_types
class PageAccueil extends StatelessWidget {
  PageAccueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Page D'Accueil",
          style: TextStyle(color: Colors.white),
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
            child: Container(
              margin: const EdgeInsets.only(right: 12, bottom: 12),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      scrollable: true,
                      content: AjouterUneQuestion(),
                    ),
                    barrierDismissible: true,
                  );
                },
                elevation: 5,
                child: const Icon(
                  Icons.question_mark_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
