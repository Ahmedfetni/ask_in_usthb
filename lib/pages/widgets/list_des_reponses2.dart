import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'list_des_cartes_questions.dart';
import 'cartes/carte_reponse2.dart';
import '../../models/reponse_degre1.dart';
import '../../models/reponse_degre2.dart';

class ListDesReponse2 extends StatelessWidget {
  ReponseDegre1 reponse1;
  final k1 = UniqueKey();
  final k2 = UniqueKey();
  final k3 = UniqueKey();
  final k4 = UniqueKey();
  ListDesReponse2({Key? key, required this.reponse1}) : super(key: key);
  //une fonction pour recuperer les reponses
  Future<QuerySnapshot> getReponses2(
      String idReponse, String idQuestion) async {
    final collection = FirebaseFirestore.instance
        .collection("Questions")
        .doc(idQuestion)
        .collection("reponses")
        .doc(idReponse)
        .collection("reponseDegre2");
    return await collection.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getReponses2(reponse1.id, reponse1.idQuestion),
      builder: (context, snapshot) {
        List<ReponseDegre2> li = [];
        if (snapshot.hasError) {
          return SliverList(
              key: k1,
              delegate: SliverChildListDelegate([
                const Center(
                    child: Text("Something went wrong",
                        style: TextStyle(color: Colors.red, fontSize: 24)))
              ]));
        }
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          for (var element in snapshot.data!.docs) {
            li.add(ReponseDegre2.reponse2FromSnapShot(element));
          }
          if (li.isNotEmpty) {
            return SliverList(
                key: k2,
                delegate: SliverChildBuilderDelegate(
                  childCount: li.length,
                  (context, index) => CarteReponse2(reponse: li[index]),
                ));
          } else {
            return SliverList(key: k3, delegate: SliverChildListDelegate([]));
          }
        }
        return SliverList(
            key: k4,
            delegate: SliverChildListDelegate([
              const Center(
                child: CircularProgressIndicator(),
              )
            ]));
      },
    );
  }
}
