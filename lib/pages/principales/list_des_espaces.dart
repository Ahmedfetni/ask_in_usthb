import 'package:ask_in_usthb/models/question.dart';

import '../widgets/connecter_ou_inscrire.dart';
import '../../models/espace.dart';
import 'package:provider/provider.dart';
import '../widgets/cartes/carte_espace_constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListDesEspaces extends StatefulWidget {
  ListDesEspaces({Key? key}) : super(key: key);

  @override
  State<ListDesEspaces> createState() => _ListDesEspacesState();
}

class _ListDesEspacesState extends State<ListDesEspaces> {
  Future<QuerySnapshot> getEspaces() async {
    var collectionQuestion = FirebaseFirestore.instance.collection("Questions");
    return await collectionQuestion.get();
  }

  List<Espace> creeLesEspace(QuerySnapshot snapshot) {
    List<Question> listDesQuestion = [];
    for (var element in snapshot.docs) {
      listDesQuestion.add(Question.questionFromSnapshot(element));
    }
    List<Espace> li = [
      Espace(nom: "Faculte de mathématiques"),
      Espace(nom: "Faculte des Science biologiques"),
      Espace(nom: "Faculte de génie mécanique et génie des procedes"),
      Espace(nom: "Faculte des sciences de la terre et de geographie"),
      Espace(nom: "Faculte de physique"),
      Espace(nom: "Faculte de chemie"),
      Espace(nom: "Faculte d'informatique"),
      Espace(nom: "Faculte de génie electrique"),
      Espace(nom: "Faculte de génie civil"),
      Espace(nom: "sansEspace"),
    ];
    for (Question qst in listDesQuestion) {
      switch (qst.espace) {
        case "Faculte de mathématiques":
          li[0].ajouterUneQuestion(qst);
          break;
        case "Faculte des Science biologiques":
          li[1].ajouterUneQuestion(qst);
          break;
        case "Faculte de génie mécanique et génie des procedes":
          li[2].ajouterUneQuestion(qst);
          break;
        case "Faculte des sciences de la terre et de geographie":
          li[3].ajouterUneQuestion(qst);
          break;
        case "Faculte de physique":
          li[4].ajouterUneQuestion(qst);
          break;
        case "Faculte de chemie":
          li[5].ajouterUneQuestion(qst);
          break;
        case "Faculte d'informatique":
          li[6].ajouterUneQuestion(qst);
          break;
        case "Faculte de génie electrique":
          li[7].ajouterUneQuestion(qst);
          break;
        case "Faculte de génie civil":
          li[8].ajouterUneQuestion(qst);
          break;

        default:
          li[9].ajouterUneQuestion(qst);
      }
    }
    return li;
  }

  @override
  Widget build(BuildContext context) {
    //final elements = const [];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 47, 143, 157),
        centerTitle: true,
        title: const Text(
          "Espaces",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: getEspaces(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<Espace> li = creeLesEspace(snapshot.data!);
            return ListView(
              children: [
                CarteEspaceConstant(
                  espace: li[0],
                  image: "images/calculating.png",
                ),
                CarteEspaceConstant(
                  espace: li[1],
                  image: "images/dna.png",
                ),
                CarteEspaceConstant(
                  espace: li[2],
                  image: "images/engine.png",
                ),
                CarteEspaceConstant(
                  espace: li[3],
                  image: "images/geology.png",
                ),
                CarteEspaceConstant(
                  espace: li[4],
                  image: "images/physics.png",
                ),
                CarteEspaceConstant(
                  espace: li[5],
                  image: "images/chemistry.png",
                ),
                CarteEspaceConstant(
                  espace: li[6],
                  image: "images/programmer.png",
                ),
                CarteEspaceConstant(
                  espace: li[7],
                  image: "images/robotic-arm.png",
                ),
                CarteEspaceConstant(
                  espace: li[8],
                  image: "images/worker.png",
                ),
                CarteEspaceConstant(
                  espace: li[9],
                  image: "images/infinite.png",
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
