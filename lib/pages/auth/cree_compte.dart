import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../../services/service_authentification.dart';

class CrierCompte extends StatefulWidget {
  const CrierCompte({Key? key}) : super(key: key);

  @override
  State<CrierCompte> createState() => _CrierCompteState();
}

class _CrierCompteState extends State<CrierCompte> {
  final controleurMotDepasse = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? niveau;
  late String nomUtilisateur, matricule, email, motDePasse, dateDeNaissance;
  bool textInvisible = true;

  @override
  void initState() {
    dateDeNaissance = "";
    niveau = 'L1';
    super.initState();
  }

  @override
  void dispose() {
    controleurMotDepasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motDePasseDecoration = InputDecoration(
      /* L'icon pour controller la visibilite du mot de passe  */
      suffixIcon: TextButton.icon(
        onPressed: () {
          setState(() {
            textInvisible = !textInvisible;
          });
        },
        icon: (textInvisible
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility)),
        label: const Text(""),
      ),

      fillColor: Colors.lightBlue[10], //couleur du font
      filled: true,

      label: const Text(
        "Mot de passe",
        style: TextStyle(color: Colors.lightBlue),
      ),
      alignLabelWithHint: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue.shade100)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: Colors.lightBlue[600]!),
      ),
      /* **************************** */
      hintText: "votre mot de passe",
      hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.lightBlue[200],
      ),
    );

    final nomDeUtilisateurDecoration = InputDecoration(
      /* L'icon pour controller la visibilite du mot de passe  */
      suffixIcon: const Icon(
        Icons.person,
        color: Colors.lightBlue,
      ),

      fillColor: Colors.lightBlue[10], //couleur du font
      filled: true,

      label: const Text(
        "Nom d'utilisateur",
        style: TextStyle(color: Colors.lightBlue),
      ),
      alignLabelWithHint: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue.shade100)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: Colors.lightBlue[600]!),
      ),
      /* **************************** */
      hintText: "votre nom de l'utilisateur",
      hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.lightBlue[200],
      ),
    );

    final emailDecoration = InputDecoration(
      /* L'icon pour controller la visibilite du mot de passe  */
      suffixIcon: const Icon(
        Icons.email,
        color: Colors.lightBlue,
      ),

      fillColor: Colors.lightBlue[10], //couleur du font
      filled: true,

      label: const Text(
        "Email",
        style: TextStyle(color: Colors.lightBlue),
      ),
      alignLabelWithHint: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue.shade100)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: Colors.lightBlue[600]!),
      ),
      /* **************************** */
      hintText: "Introduire votre adresse email",
      hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.lightBlue[200],
      ),
    );

    final matriculeDecoration = InputDecoration(
      /* L'icon pour controller la visibilite du mot de passe  */
      suffixIcon: const Icon(
        Icons.notes_outlined,
        color: Colors.lightBlue,
      ),

      fillColor: Colors.lightBlue[10], //couleur du font
      filled: true,

      label: const Text(
        "Matricule",
        style: TextStyle(color: Colors.lightBlue),
      ),
      alignLabelWithHint: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.lightBlue.shade100)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: Colors.lightBlue[600]!),
      ),
      /* **************************** */
      hintText: "votre matricule",
      hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.lightBlue[200],
      ),
    );

    final niveaux = ['L1', 'L2', 'L3', 'M1', 'M2', 'Doctora'];

    final formatDeLaDate = DateFormat("dd-MM-yyyy");
    bool loading = false;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Inscrire",
            style: TextStyle(color: Colors.white),
          ),
          leading: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              label: const Text(""))),
      body: loading
          ? const CircularProgressIndicator()
          : Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      /* ******************************** Choisir le nom de l'utilisateur ******************************** */
                      _espaceVide(),
                      TextFormField(
                        decoration: nomDeUtilisateurDecoration,
                        onChanged: (val) => {
                          setState(
                            () {
                              nomUtilisateur = val;
                            },
                          )
                        },
                        validator: (val) {
                          if (val!.length > 6 && val.isNotEmpty) {
                            return null;
                          } else if (val.length < 6 && val.isNotEmpty) {
                            return "Votre nom d'utlilisateur est trop petit";
                          } else {
                            return "vous devez introduire un nom d'utilisateur";
                          }
                        },
                      ),
                      /* *************** Espace vide ***************** */
                      _espaceVide(),

                      /* ******************************** choisir matricule *********************************/
                      TextFormField(
                        decoration: matriculeDecoration,
                        onChanged: (val) => {
                          setState(
                            () {
                              matricule = val;
                            },
                          )
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "vous devez introduire votre matricule";
                          } else {
                            return null;
                          }
                        },
                      ),

                      /* *************** Espace vide ***************** */
                      _espaceVide(),

                      /* ********************************Choisir l'email******************************** */
                      TextFormField(
                        decoration: emailDecoration,
                        onChanged: (val) => {
                          setState(
                            () {
                              email = val;
                            },
                          )
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "vous dever introduire une adresse email";
                          } else if (!EmailValidator.validate(val)) {
                            return "Introduire une adresse email valid";
                          } else {
                            return null;
                          }
                        },
                      ),
                      /* *************** Espace vide ***************** */
                      _espaceVide(),

                      /* ********************************  choisir le mot de passe *********************************/
                      TextFormField(
                        controller: controleurMotDepasse,
                        decoration: motDePasseDecoration,
                        obscureText:
                            textInvisible, //pour rendre le mot de passe visible ou invisble
                        onChanged: (val) => {
                          setState(
                            () {
                              motDePasse = val;
                            },
                          ),
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Introduire un mot pour secutise votre compte";
                          } else if (val.length < 8) {
                            return "Votre mot de passe dois etre au moins 8 charachteres";
                          } else {
                            return null;
                          }
                        },
                      ),
                      _espaceVide(),
                      /* Un champ text pour confermer le  mot de passe */
                      TextFormField(
                        //La meme decoration du mot de passe mais avec des quelque petites changements
                        decoration: motDePasseDecoration.copyWith(
                          label: const Text(
                            "Confermer le mot de passe",
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                          hintText: "repeter le mot de passe",
                          hintStyle: const TextStyle(color: Colors.lightBlue),
                        ),
                        obscureText:
                            textInvisible, //pour rendre le mot de passe visible ou invisble
                        onChanged: (val) => {
                          setState(
                            () {
                              motDePasse = val;
                            },
                          ),
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "confermer votre mot de passe";
                          } else if (val != controleurMotDepasse.text) {
                            return "Mot de passe ne correspond pas ";
                          } else {
                            return null;
                          }
                        },
                      ),
                      /* *************** Espace vide ***************** */
                      _espaceVide(),

                      /* ******************************** Choisir la date de naissance ******************************** */
                      DateTimeField(
                        onSaved: (newValue) => {
                          setState(() {
                            dateDeNaissance = formatDeLaDate.format(newValue!);
                          }),
                        },
                        onChanged: (value) {
                          setState(() {
                            dateDeNaissance = formatDeLaDate.format(value!);
                          });
                        },
                        validator: (val) {
                          if (DateTime.now().difference(val!).inDays / 365 <
                              16) {
                            return "vous devez être plus que 16 ans ";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.lightBlue,
                          ),
                          //enabledBorder: InputBorder.none,
                          fillColor: Colors.lightBlue,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.lightBlue.shade100)),
                          label: const Text(
                            "Date de naissance",
                            style: TextStyle(
                              color: Colors.lightBlue,
                            ),
                          ),
                          alignLabelWithHint: false,
                          hintText: "choisir votre date de naissaince ",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlue[200],
                          ),
                        ),
                        format: formatDeLaDate,
                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                              context: context,
                              initialDate: currentValue ?? DateTime(2011),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2011));
                        },
                      ),

                      /* *************** Espace vide ***************** */
                      _espaceVide(),
                      /* ******************************** Sous Menu des niveaux ********************************  */
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: niveau,
                            items: niveaux
                                .map<DropdownMenuItem<String>>(
                                    (e) => _elementSousMenuDesNiveau(e))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                niveau = value;
                              });
                            },
                          ),
                        ),
                      ),
                      _espaceVide(),
                      /* ************************************ Bouton pour le submit ************************************ */
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.6),
                        padding: const EdgeInsets.all(8),
                        child: TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              debugPrint(
                                  " la date de naissance est  $dateDeNaissance");

                              return;
                            } else {
                              setState(() {
                                loading = true;
                              });
                              context
                                  .read<ServiceAuthentification>()
                                  .inscrire(
                                      email: email,
                                      motDePasse: motDePasse,
                                      nomUtilisateur: nomUtilisateur,
                                      niveau: niveau!,
                                      dateDeNaissance: dateDeNaissance)
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 2,
                            backgroundColor:
                                const Color.fromARGB(255, 0, 255, 198),
                          ),
                          child: const Text(
                            "Inscrire",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /* Pour cree les elements de sous menu */
  DropdownMenuItem<String> _elementSousMenuDesNiveau(String element) =>
      DropdownMenuItem(
          enabled: true,
          value: element,
          child: Text(
            element,
            style: const TextStyle(color: Colors.lightBlue),
          ));

  _espaceVide() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      );
}
