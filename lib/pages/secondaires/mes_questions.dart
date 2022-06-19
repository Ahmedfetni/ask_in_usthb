import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/utilisateur.dart';
import '../widgets/cartes/carte_questions.dart';
import '../widgets/cartes/carte_ma_question.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class MesQuestions extends StatelessWidget {
  Utilisateur utilisateur;
  MesQuestions({Key? key, required this.utilisateur}) : super(key: key);

  Future<QuerySnapshot> getQuestions() async {
    var collectionQuestion = FirebaseFirestore.instance.collection("Questions");
    return await collectionQuestion.get();
  }

  List<Question> li = <Question>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mes Questions"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: getQuestions(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text("Something went wrong",
                    style: TextStyle(color: Colors.red, fontSize: 24)));
          }
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            li = [];
            debugPrint("le uid de l'utilisateur est ${utilisateur.uid}");
            for (var element in snapshot.data!.docs) {
              Question qst = Question.questionFromSnapshot(element);
              if (qst.uid == utilisateur.uid) {
                li.add(qst);
              }
            }
            if (li.isNotEmpty) {
              return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  scrollDirection: Axis.vertical,
                  itemCount: li.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CarteMaQuestion(
                      question: li[index],
                    );
                  });
            } else {
              return const Center(
                child: Text("Vous n'avez auccune question"),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
