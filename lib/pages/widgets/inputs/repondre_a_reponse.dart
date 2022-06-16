import 'package:ask_in_usthb/services/service_base_de_donnees.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../models/reponse_degre1.dart';
import '../../../models/reponse_degre2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepondreAUneReponse extends StatefulWidget {
  VoidCallback visibilite;
  //bool visible;
  //int index;
  ReponseDegre1 reponse1;
  RepondreAUneReponse({
    Key? key,
    required this.reponse1,
    required this.visibilite,
  }) : super(key: key);

  @override
  State<RepondreAUneReponse> createState() => _RepondreAUneReponseState();
}

class _RepondreAUneReponseState extends State<RepondreAUneReponse> {
  final _controller = TextEditingController();
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 8),
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.send,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.send_rounded),
              hintText: "Ecrire votre reponse",
            ),
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                final uid = Provider.of<User?>(context, listen: false)?.uid;

                await ServiceBaseDeDonnes(uid: uid).ajouterUneReponse2(
                    widget.reponse1.idQuestion, widget.reponse1.id, value);
                setState(() {
                  widget.visibilite();
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
