//import 'dart:io';

import 'package:ask_in_usthb/pages/widgets/cartes/grandeCarteQuestion.dart';
import 'package:ask_in_usthb/pages/widgets/list_des_reponses2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/question.dart';
import '../../models/tag.dart';
import '../../models/reponse_degre1.dart';
import '../widgets/cartes/carte_reponse2.dart';
import '../widgets/cartes/carte_reponse1.dart';
import '../widgets/cartes/puce_tag.dart';
//import '../widgets/inputs/repondre_a_reponse.dart';
import 'package:flutter/material.dart';
import '../../services/service_base_de_donnees.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionDetail extends StatefulWidget {
  final Question question;

  const QuestionDetail({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

//TOOD  affichier les reponses a une reponse
class _QuestionDetailState extends State<QuestionDetail> {
  final sliverListCasErreur = UniqueKey();
  final sliverListCasLoading = UniqueKey();
  final sliverListCasResultat = UniqueKey();

  List<bool> rependreVisible = [];
  late bool plusCliquer;
  late bool moinsCliquer;
  late Icon iconVoteMoins;
  late Icon iconVotePlus;
  late int vote;
  late bool visible;
  var iconFavorie = Icons.bookmark_add_rounded;

  var ajouterUneReponseDegre1 = false;
  @override
  void initState() {
    for (ReponseDegre1 reponse in widget.question.getReponses) {
      rependreVisible.add(false);
    }
    visible = true;
    iconVotePlus = const Icon(
      Icons.thumb_up_off_alt,
      color: Colors.green,
    );
    iconVoteMoins = const Icon(
      Icons.thumb_down_off_alt,
      color: Colors.redAccent,
    );

    plusCliquer = false;
    moinsCliquer = false;
    vote = widget.question.vote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: getReponse(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomScrollView(
              key: sliverListCasErreur,
              slivers: [
                GrandeCarteQuestion(question: widget.question),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(
                        child: Text(
                          "Une erreur verfier votre connexion internet ${snapshot.error}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            List<ReponseDegre1> li = [];
            for (var element in snapshot.data!.docs) {
              li.add(ReponseDegre1.reponseFromSnapshot(element));
            }
            List<Widget> listDesSlivers = [];
            listDesSlivers.add(GrandeCarteQuestion(question: widget.question));
            for (var element in li) {
              listDesSlivers.add(SliverList(
                  delegate: SliverChildListDelegate([
                CarteReponse(reponse: element, uidQst: widget.question.uid)
              ])));
              listDesSlivers.add(ListDesReponse2(reponse1: element));
            }
            return
                //NestedScrollView(headerSliverBuilder: headerSliverBuilder, body: body)
                CustomScrollView(
              key: sliverListCasResultat,
              slivers: listDesSlivers,
            );
          }
          return CustomScrollView(
            key: sliverListCasLoading,
            slivers: [
              GrandeCarteQuestion(question: widget.question),
              SliverList(
                delegate: SliverChildListDelegate([
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 47, 143, 157),
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),

      /*CustomScrollView(
        slivers: [
          GrandeCarteQuestion(question: widget.question),
          creeLesListDesReponse(
              context), //TODO requperer les reponses a partitre de la base de donnees
        ],
      ),*/
    );
  }

  /* *************** Pour cree les puces *************** */

/* ******** ******** */

  /*********************************** recuperer les questions  ********************************/
  Future<QuerySnapshot> getReponse() async {
    var collection = FirebaseFirestore.instance
        .collection("Questions")
        .doc(widget.question.getId)
        .collection("reponses");
    return await collection.get();
  }

  /* *************** Pour une list des reponses *************** */
  //TODO changer  tous cas a un furure builder
  //creeLesListDesReponse(context) =>

  /*liSliver.add(SliverList(
          delegate: SliverChildListDelegate([
        RepondreAUneReponse(
          visible: rependreVisible[i],
          reponse1: reponse,
          index: i,
        )
      ])));*/
  //List de reponses a une reponse degre 2
  //TODO Verfier si les reponse existe a une reponse

}
