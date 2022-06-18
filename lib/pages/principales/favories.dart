import '../widgets/connecter_ou_inscrire.dart';
import '../widgets/list_des_cartes_questions.dart';
//import '../../models/question.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class PageDesFavories extends StatefulWidget {
  //bool utilisateurConnecter;
  PageDesFavories({
    Key? key,
  }) : super(key: key);

  @override
  State<PageDesFavories> createState() => _PageDesFavoriesState();
}

class _PageDesFavoriesState extends State<PageDesFavories> {
  @override
  Widget build(BuildContext context) {
    final utilisateurConnecter = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 47, 143, 157),
        centerTitle: true,
        title: const Text(
          "Favories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: utilisateurConnecter != null
          ? ListDesCartesQuestions()
          : const Center(
              child: ConnecterOuInscrire(),
            ),
    );
  }
}
