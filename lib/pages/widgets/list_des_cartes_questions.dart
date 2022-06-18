import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../widgets/cartes/carte_questions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ListDesCartesQuestions extends StatelessWidget {
  ListDesCartesQuestions({Key? key}) : super(key: key);

  Future<QuerySnapshot> getQuestions() async {
    var collectionQuestion = FirebaseFirestore.instance.collection("Questions");
    return await collectionQuestion.get();
  }

  List<Question> li =
      <Question>[]; 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
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
          for (var element in snapshot.data!.docs) {
            li.add(Question.questionFromSnapshot(element));
          }
          if (li.isNotEmpty) {
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                scrollDirection: Axis.vertical,
                itemCount: li.length,
                itemBuilder: (BuildContext context, int index) {
                  return CarteQuestion(
                    question: li[index],
                  );
                });
          } else {
            return const Center(
              child: Text("Accune question pour le momment"),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
