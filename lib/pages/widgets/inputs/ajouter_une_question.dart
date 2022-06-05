import '../../../models/tag.dart';
import '../cartes/puce_tag.dart';
import 'package:flutter/material.dart';

class AjouterUneQuestion extends StatefulWidget {
  const AjouterUneQuestion({Key? key}) : super(key: key);

  @override
  State<AjouterUneQuestion> createState() => _AjouterUneQuestionState();
}

class _AjouterUneQuestionState extends State<AjouterUneQuestion> {
  List<PuceTag> pucesAjoutees = [];
  var ajouterUnTagControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    ajouterUnTagControler = TextEditingController(text: '');
  }

  @override
  void dispose() {
    ajouterUnTagControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titre, corp;
    List<Tag> tags;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              /* Titre de la question  */
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Titre de question",
                ),
                autofocus: true,
                onChanged: (valeur) {
                  setState(() {
                    titre = valeur;
                  });
                },
              ),
              /* Corp de la question */
              TextFormField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
                decoration: const InputDecoration(
                  hintText: "Corp de question",
                ),
                onChanged: (valeur) {
                  setState(() {
                    corp = valeur;
                  });
                },
              ),

              /* Ajouter un tag */
              TextField(
                controller: ajouterUnTagControler,
                onSubmitted: (value) {
                  setState(() {
                    pucesAjoutees.add(PuceTag(tag: Tag(nom: value)));
                    ajouterUnTagControler.clear();
                  });
                },
              ),
              _lesPucesTagAjouters(pucesAjoutees),
            ],
          ),
        ),
      ),
    );
  }

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
