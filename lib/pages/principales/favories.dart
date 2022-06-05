import '../widgets/connecter_ou_inscrire.dart';
import '../widgets/list_des_cartes_questions.dart';
import '../../models/question.dart';
import 'package:flutter/material.dart';

class PageDesFavories extends StatefulWidget {
  bool utilisateurConnecter;
  PageDesFavories({Key? key, required this.utilisateurConnecter})
      : super(key: key);

  @override
  State<PageDesFavories> createState() => _PageDesFavoriesState();
}

class _PageDesFavoriesState extends State<PageDesFavories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.utilisateurConnecter
          ? ListDesCartesQuestions()
          : const Center(
              child: ConnecterOuInscrire(),
            ),
    );
  }
}
