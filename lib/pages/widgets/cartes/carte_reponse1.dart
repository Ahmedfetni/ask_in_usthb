import '../../../services/service_base_de_donnees.dart';
import 'package:provider/provider.dart';
import '../../../models/reponse_degre1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../../services/service_base_de_donnees.dart';

class CarteReponse extends StatefulWidget {
  final ReponseDegre1 reponse;
  //final Function repondre;
  //final int index;
  CarteReponse({
    Key? key,
    required this.reponse,
    //required this.repondre,
  }) : super(key: key);

  @override
  State<CarteReponse> createState() => _CarteReponseState();
}

class _CarteReponseState extends State<CarteReponse> {
  bool repondrevisible = false;
  late Widget repondre;
  @override
  Widget build(BuildContext context) {
    late String utilisateur;
    late String text;
    late String date;
    final _controller = TextEditingController();
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      _controller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      //Initialisation des variable sa depends le type de reponse
      utilisateur = widget.reponse.getNomUtilisateur;
      text = widget.reponse.getText;
      date = widget.reponse.getDate;

      super.initState();
    }

    //Une fonction pour manipuler la visibilite du repondre

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                final uid = Provider.of<User?>(context, listen: false)!.uid;
                // ignore: unnecessary_null_comparison
                if (uid != null) {
                  ServiceBaseDeDonnes(uid: uid).mettreAjourVoteReponse(
                      widget.reponse.idQuestion, 1, widget.reponse.id, true);
                }
                //TODO une test pour eviter que l'utilisateur vote plus q'une fois
                setState(() {
                  widget.reponse.plusVote();
                });
              },
              onDoubleTap: () {
                final uid = Provider.of<User?>(context, listen: false)!.uid;
                //TODO une test pour que l'utilisateur ne vote pas plus qu'une fois
                // ignore: unnecessary_null_comparison
                if (uid != null) {
                  ServiceBaseDeDonnes(uid: uid).mettreAjourVoteReponse(
                      widget.reponse.idQuestion, -1, widget.reponse.id, false);
                }
                setState(() {
                  widget.reponse.moinsVote();
                });
              },
              child: ListTile(
                leading: Wrap(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                              style: TextStyle(
                                color: widget.reponse.getVote > 0
                                    ? Colors.greenAccent
                                    : (widget.reponse.getVote < 0
                                        ? Colors.redAccent
                                        : Colors.lightBlue),
                              ),
                              "${widget.reponse.getVote > 0 ? "+" : ""} ${widget.reponse.getVote}"),
                        ),
                        Icon(
                          Icons.thumbs_up_down,
                          color: widget.reponse.getVote > 0
                              ? Colors.greenAccent
                              : (widget.reponse.getVote < 0
                                  ? Colors.redAccent
                                  : Colors.lightBlue),
                        ),
                      ],
                    ),
                  ],
                ),
                title: Wrap(
                  children: [
                    Text(
                      widget.reponse.getText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: Text(
                    "${widget.reponse.getDate} par ${widget.reponse.getNomUtilisateur}",
                    style: const TextStyle(color: Colors.lightBlue)),
                trailing: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      repondrevisible = !repondrevisible;
                    });
                  },
                  icon: const Icon(
                    Icons.reply_rounded,
                    color: Colors.lightBlue,
                  ),
                  label: const Text(""),
                ),
              ),
            ),
            Visibility(
              visible: repondrevisible,
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 8),
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                          setState(() {
                            repondrevisible = !repondrevisible;
                          });
                          final uid =
                              Provider.of<User?>(context, listen: false)!.uid;
                          if (uid == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 171, 213, 228),
                                    content: Text(
                                      "Mauvaise connexion internet essayer plus tard",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    )));
                            return;
                          }

                          await ServiceBaseDeDonnes(uid: uid)
                              .ajouterUneReponse2(widget.reponse.idQuestion,
                                  widget.reponse.id, value);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
