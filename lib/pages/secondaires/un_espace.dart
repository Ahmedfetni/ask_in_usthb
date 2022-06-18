import 'package:flutter/material.dart';
import '../../models/espace.dart';
//import '../../models/question.dart';
import '../widgets/cartes/carte_questions.dart';

// ignore: must_be_immutable
class UnEspace extends StatelessWidget {
  Espace espace;
  UnEspace({Key? key, required this.espace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(espace.getNom),
        centerTitle: true,
      ),
      body: espace.getQuestions.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: espace.getQuestions.length,
              itemBuilder: (context, index) {
                return CarteQuestion(question: espace.getQuestions[index]);
              },
            )
          : const Center(
              child: Text("Auccune question dans l'espace"),
            ),
    );
  }
}
