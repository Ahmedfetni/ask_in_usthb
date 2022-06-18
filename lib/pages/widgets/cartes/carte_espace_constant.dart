// ignore_for_file: must_be_immutable

import 'package:ask_in_usthb/pages/principales/list_des_espaces.dart';
import 'package:ask_in_usthb/pages/secondaires/un_espace.dart';
import 'package:ask_in_usthb/pages/widgets/boutton_inscrire_a_un_espace.dart';

import '../../../models/espace.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarteEspaceConstant extends StatefulWidget {
  Espace espace;
  String image;
  CarteEspaceConstant({Key? key, required this.espace, required this.image})
      : super(key: key);

  @override
  State<CarteEspaceConstant> createState() => _CarteEspaceConstantState();
}

class _CarteEspaceConstantState extends State<CarteEspaceConstant> {
//get spaces data and questions
  Future<QuerySnapshot> getEspaces() async {
    var collectionQuestion = FirebaseFirestore.instance.collection("Questions");
    return await collectionQuestion.get();
  }
  /*ListDesEspaces*/

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnEspace(espace: widget.espace),
            ));
      },
      child: Card(
        elevation: 8,
        color: const Color.fromARGB(255, 222, 233, 232),
        shadowColor: Colors.grey.shade700,
        //color: Colors.grey.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 120,
                  width: 120,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(widget.image),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        widget.espace.getNom,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: BouttonInscrireAUnEspace(
                    espace: widget.espace,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      "Nombre des question ${widget.espace.getQuestions.length}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
  /*
  
    ListTile(
        dense: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage("assets/images/${widget.image}"),
          ),
        ),
        title: Text(
          widget.espace.getNom,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
        ),
        trailing: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.lightBlue,
            ),
            label: const Text("")),
      ), 
   */


