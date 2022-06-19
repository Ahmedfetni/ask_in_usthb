import 'package:flutter/material.dart';
import '../../models/question.dart';
import '../widgets/cartes/carte_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/utilisateur.dart';

class ListDesfavories extends StatelessWidget {
  String uid;
  ListDesfavories({Key? key, required this.uid}) : super(key: key);

  //recupreer les donnees de l'utilisateur
  Future<DocumentSnapshot> getUtilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get();
  }

  //Recuperer les question
  Future<QuerySnapshot> listDesFavories(String uid) async {
    //List<Question> li = [];
    //DocumentSnapshot doc = await getUtilisateur(uid);
    //Utilisateur utilisateur = Utilisateur.utilisateurFromSnapShot(doc);
    return await FirebaseFirestore.instance.collection("Questions").get();
  }

  @override
  Widget build(BuildContext context) {
    //User? user = context.watch<User?>();

    return FutureBuilder<DocumentSnapshot>(
      future: getUtilisateur(uid),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.exists) {
            Utilisateur utilisateur =
                Utilisateur.utilisateurFromSnapShot(snapshot.data);
            return FutureBuilder<QuerySnapshot>(
              future: listDesFavories(uid),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<Question> li = [];
                  for (var element in snapshot.data!.docs) {
                    Question qst = Question.questionFromSnapshot(element);
                    if (utilisateur.favories.contains(qst.getId)) {
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
                          return CarteQuestion(
                            question: li[index],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("Accune question est dans les favories"),
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

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
