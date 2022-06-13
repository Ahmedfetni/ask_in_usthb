import 'package:flutter/material.dart';
import '../../../models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/question.dart';
import '../../../models/tag.dart';
import '../../../models/reponse_degre1.dart';
import '../../widgets/cartes/carte_reponse2.dart';
import '../../widgets/cartes/carte_reponse1.dart';
import '../../widgets/cartes/puce_tag.dart';
import '../../widgets/inputs/repondre_a_reponse.dart';
import 'package:flutter/material.dart';
import '../../../services/service_base_de_donnees.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GrandeCarteQuestion extends StatefulWidget {
  Question question;
  GrandeCarteQuestion({Key? key, required this.question}) : super(key: key);

  @override
  State<GrandeCarteQuestion> createState() => _GrandeCarteQuestionState();
}

class _GrandeCarteQuestionState extends State<GrandeCarteQuestion> {
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

  /* *************** Pour cree les puces *************** */
  List<Widget> _listDesPuce(List<Tag>? tags) {
    if (tags != null && tags.isNotEmpty) {
      List<PuceTag> puces = [];
      for (var i = 0; i < tags.length; i++) {
        puces.add(PuceTag(tag: tags[i]));
      }
      return puces;
    }
    return <Widget>[
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const Text("Pas de tag"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.blue, width: 4),
              ),
              margin: const EdgeInsets.only(bottom: 10, top: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.yellowAccent,
                foregroundColor: Colors.blue,
                child: Text(
                  widget.question.getNomUtilisateur
                      .substring(0, 2)
                      .toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          /* ******************** Titre du question ******************** */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    widget.question.getTitre,
                  ),
                ),
              ],
            ),
          ),
          /* ******************** Corp du question ******************** */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    style: const TextStyle(fontSize: 18),
                    widget.question.getCorp,
                  ),
                ),
              ],
            ),
          ),
          /* ******************** Les Tags ******************** */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: _listDesPuce(widget.question.getTags),
            ),
          ),
          /* ******************** Les Buttons ******************** */
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  "$vote",
                ),
                //vote +
                TextButton.icon(
                    onPressed: () async {
                      setState(() {
                        if (!plusCliquer) {
                          vote++;
                          iconVotePlus = const Icon(
                            Icons.thumb_up_alt_rounded,
                            color: Colors.green,
                          );
                        } else {
                          vote--;
                          iconVotePlus = const Icon(
                            Icons.thumb_up_off_alt,
                            color: Colors.green,
                          );
                        }
                        if (moinsCliquer) {
                          vote++;
                          moinsCliquer = !moinsCliquer;
                          iconVoteMoins = const Icon(
                            Icons.thumb_down_off_alt,
                            color: Colors.redAccent,
                          );
                        }
                        plusCliquer = !plusCliquer;
                      });
                      final uid =
                          Provider.of<User?>(context, listen: false)?.uid;
                      await ServiceBaseDeDonnes(uid: uid)
                          .mettreAjourVote(widget.question.getId, vote);
                    },
                    icon: iconVotePlus,
                    label: const Text("")),
                //vote -
                TextButton.icon(
                    onPressed: () async {
                      setState(() {
                        if (!moinsCliquer) {
                          vote--;
                          iconVoteMoins = const Icon(
                            Icons.thumb_down_alt_rounded,
                            color: Colors.redAccent,
                          );
                        } else {
                          vote++;
                          iconVoteMoins = const Icon(
                            Icons.thumb_down_off_alt,
                            color: Colors.redAccent,
                          );
                        }
                        if (plusCliquer) {
                          vote--;
                          iconVotePlus = const Icon(
                            Icons.thumb_up_off_alt,
                            color: Colors.green,
                          );
                          plusCliquer = !plusCliquer;
                        }
                        moinsCliquer = !moinsCliquer;
                      });
                      final uid =
                          Provider.of<User?>(context, listen: false)?.uid;
                      await ServiceBaseDeDonnes(uid: uid)
                          .mettreAjourVote(widget.question.getId, vote);
                    },
                    icon: iconVoteMoins,
                    label: const Text("")),
                // Pour rependre
                TextButton(
                  onPressed: () {
                    setState(() {
                      ajouterUneReponseDegre1 = !ajouterUneReponseDegre1;
                    });
                  },
                  child: const Icon(Icons.reply_rounded),
                ),
                //Pour sauvgarder une question
                TextButton(
                  onPressed: () async {
                    //TODO Bookmark a question
                    //TODO set state icon
                    setState(() {
                      iconFavorie = Icons.bookmark_added_rounded;
                    });
                    final uid = Provider.of<User?>(context, listen: false)?.uid;
                    await ServiceBaseDeDonnes(uid: uid)
                        .ajouterUneQuestionAuFavories(widget.question.getId);
                  },
                  child: Icon(
                    iconFavorie,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 1,
            color: Colors.lightBlue,
          ),
          /* ************************* Ajouter une reponse  degre 01 **************************/
          Visibility(
            visible: ajouterUneReponseDegre1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextField(
                onSubmitted: (value) async {
                  final uid = Provider.of<User?>(context, listen: false)?.uid;
                  if (uid == null) {
                    debugPrint("the uid of the user is null ");
                  } else {
                    debugPrint("the user is not null");

                    /*sleep(const Duration(milliseconds: 100));*/

                    await ServiceBaseDeDonnes(uid: uid)
                        .ajouterUneRponse1(widget.question.getId, value);
                    setState(() {
                      ajouterUneReponseDegre1 = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 2, color: Colors.lightBlue.shade100)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(width: 1, color: Colors.lightBlue[600]!),
                    ),
                    hintText: "Ajouter votre reponse ",
                    suffixIcon: TextButton.icon(
                        onPressed: () {
                          //TODO passe le on submitted fonctionalte du boutton
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.lightBlue,
                        ),
                        label: const Text(""))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
