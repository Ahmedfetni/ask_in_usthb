import 'package:ask_in_usthb/services/service_base_de_donnees.dart';
import 'package:flutter/services.dart';

import '../../../models/tag.dart';
import '../cartes/puce_tag.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:provider/provider.dart';
import '../../../services/service_base_de_donnees.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AjouterUneQuestion extends StatefulWidget {
  BuildContext context;
  AjouterUneQuestion({Key? key, required this.context}) : super(key: key);

  @override
  State<AjouterUneQuestion> createState() => _AjouterUneQuestionState();
}

class _AjouterUneQuestionState extends State<AjouterUneQuestion> {
  List<PuceTag> pucesAjoutees = [];
  var ajouterUnTagControler = TextEditingController();
  List<String> listDesTags = [];
  /* La list des espace  */
  final listDesEspace = [
    "Faculté de génie civil",
    "Faculté des sciences de la terre, de la géographie et de l’aménagement du territoire",
    "Faculté d’électronique",
    "Faculté d’informatique",
    "Faculté de mathématiques",
    "Faculté de génie mécanique et des procédés",
    "Faculté de physique",
  ];
  List dropdownList = [
    {
      'label': "Génie civil",
      'value': "Faculte de génie civil",
    },
    {
      'label':
          "Sciences de la terre, de la géographie et de l’aménagement du territoire",
      'value': "Faculte des sciences de la terre et de geographie"
    },
    {
      'label': "Electronique",
      'value': "Faculte de génie electrique",
    },
    {
      'label': "Informatique",
      'value': "Faculte d'informatique",
    },
    {
      'label': "Mathématiques",
      'value': "Faculte de mathématiques",
    },
    {
      'label': "Faculte de chemie",
      'value': "Faculte de chemie",
    },
    {
      'label': "Génie mécanique et des procédés",
      'value': "Faculte de génie mécanique et génie des procedes",
    },
    {
      'label': "Physique",
      'value': "Faculte de physique",
    },
    //Faculte des Science biologiques
    {
      'label': "Biologie",
      'value': "Faculte des Science biologiques",
    },
    {
      'label': 'Sans Espace',
      'value': 'aucun',
    }
  ];
  final formKey = GlobalKey<FormState>();
  String espace = "Chimie";
  bool loading = false;
  late final TextEditingController corpC, titreC;
  String? titre, corp;
  @override
  void initState() {
    super.initState();
    titreC = TextEditingController(text: "");
    corpC = TextEditingController(text: "");
    ajouterUnTagControler = TextEditingController(text: '');
  }

  @override
  void dispose() {
    titreC.dispose();
    corpC.dispose();
    ajouterUnTagControler.dispose();
    super.dispose();
  }

  //TODO ajouter un validateur pour ne pas envoyer un question vide
  @override
  Widget build(BuildContext context) {
    //List<Tag> tags;
    return loading
        ? const Center(
            child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 47, 143, 157),
            ),
          ))
        : Center(
            child: Container(
              //color: Color.fromARGB(255, 59, 172, 182),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(8),
              child: Form(
                child: Column(
                  children: [
                    /* Titre de la question  */
                    TextFormField(
                      //controller: titreC,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 179, 232, 229),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 47, 143, 157),
                            )),
                        hintText: "Titre de question",
                      ),
                      autofocus: true,
                      onChanged: (valeur) {
                        setState(() {
                          titre = valeur;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /* Corp de la question */
                    TextFormField(
                      //controller: corpC,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 4,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 179, 232, 229),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 47, 143, 157),
                            )),
                        hintText: "Corp de question",
                      ),
                      onChanged: (valeur) {
                        setState(() {
                          corp = valeur;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /******************* Pour choisir l'espace  *******************/
                    CoolDropdown(
                      selectedItemBD: const BoxDecoration(
                        color: Color.fromARGB(255, 179, 232, 229),
                      ),
                      /*dropdownBD: const BoxDecoration(
                        color: Color.fromARGB(255, 179, 232, 229),
                      ),*/
                      dropdownList: dropdownList,
                      onChange: (item) {
                        setState(() {
                          espace = item['value'];
                        });
                      },
                      defaultValue: dropdownList[0],
                      // placeholder: 'insert...',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /* Ajouter un tag */
                    TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 179, 232, 229),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 47, 143, 157))),
                        hintText: "ajouter un tag",
                      ),
                      controller: ajouterUnTagControler,
                      onSubmitted: (value) {
                        setState(() {
                          listDesTags.add(value);
                          pucesAjoutees.add(PuceTag(tag: Tag(nom: value)));
                          ajouterUnTagControler.clear();
                        });
                      },
                    ),
                    _lesPucesTagAjouters(pucesAjoutees),
                    const SizedBox(
                      height: 10,
                    ),
                    /* Le boutton pour ajouter la question */
                    Align(
                      alignment: Alignment.bottomRight,
                      /*padding: const EdgeInsets.only(
                    left: 100, right: 10, top: 10, bottom: 10),*/
                      child: TextButton(
                        onPressed: () async {
                          //TODO ajouter une question
                          setState(() {
                            loading = true;
                          });
                          final uid =
                              Provider.of<User?>(context, listen: false)?.uid;
                          //final uid = context.watch<User>().uid;
                          ServiceBaseDeDonnes(uid: uid)
                              .sauvgarderQuestion(
                                  titre, corp, listDesTags, espace)
                              .then((value) {
                            //Navigator.pop(context);
                            setState(() {
                              loading = false;
                            });
                            //debugPrint(value.toString() + "la valeur");
                            Navigator.pop(widget.context);
                          });
                        },
                        style: TextButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Publiber",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 47, 143, 157),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  /* Pour cree les elements de sous menu */
  DropdownMenuItem<String> _elementSousMenuDesEspaces(String element) =>
      DropdownMenuItem(
        enabled: true,
        value: element,
        child: Text(
          element,
          style: const TextStyle(color: Colors.lightBlue),
          overflow: TextOverflow.ellipsis,
        ),
      );
  Container _lesPucesTagAjouters(List<PuceTag> puces) {
    return Container(
        key: UniqueKey(),
        child: Wrap(children: [
          Row(
              children: puces
                  .map(
                    (puce) => Stack(
                      key: UniqueKey(),
                      children: [
                        puce,
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                listDesTags.remove(puce.tag.getNom);
                                puces.remove(puce);
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList())
        ]));
  }
}
