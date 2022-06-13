import 'package:ask_in_usthb/pages/widgets/inputs/repondre_a_reponse.dart';

import '../../../models/reponse_degre1.dart';
import 'package:flutter/material.dart';

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

    @override
    void initState() {
      //Initialisation des variable sa depends le type de reponse
      utilisateur = widget.reponse.getNomUtilisateur;
      text = widget.reponse.getText;
      date = widget.reponse.getDate;

      super.initState();
    }

    return InkWell(
      onTap: () {
        debugPrint("une seul tap ");
        setState(() {
          widget.reponse.plusVote();
        });
      },
      onDoubleTap: () {
        debugPrint("Double tap");
        setState(() {
          widget.reponse.moinsVote();
        });
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: Column(
            children: [
              ListTile(
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
              Visibility(
                visible: repondrevisible,
                child: RepondreAUneReponse(
                  reponse1: widget.reponse,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
