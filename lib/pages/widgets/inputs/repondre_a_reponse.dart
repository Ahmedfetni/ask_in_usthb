import '../../../models/reponse_degre1.dart';
import '../../../models/reponse_degre2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepondreAUneReponse extends StatefulWidget {
  //bool visible;
  //int index;
  ReponseDegre1 reponse1;
  RepondreAUneReponse({
    Key? key,
    required this.reponse1,
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
            onSubmitted: (value) {
              setState(() {
                widget.reponse1.ajouterUneReponse(ReponseDegre2(
                  id: '',
                  nomUtilisateur: "ahmed",
                  date: dateFormat.format(DateTime.now()),
                  text: value,
                ));
              });
            },
          ),
        ),
      ),
    );
  }
}
