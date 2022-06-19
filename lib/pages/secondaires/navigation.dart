import 'package:ask_in_usthb/services/service_authentification.dart';
import '../widgets/connecter_ou_inscrire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'page_profil.dart';
import '../../models/utilisateur.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    Key? key,
  }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  //recuperer l'utilisateur
  Future<DocumentSnapshot> getUtilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    //final utilisateurConnecter = Provider.of<User>(context, listen: false).
    final utilisateurConnecter = context.watch<User?>();
    return Drawer(
        elevation: 8,
        backgroundColor: const Color.fromARGB(255, 222, 233, 232),
        //Color.fromARGB(255, 190, 236,
        //235), // Color.fromARGB(255, 130, 219, 216), //Color.fromARGB(255, 179, 232, 229),
        child: utilisateurConnecter == null
            ? const Center(child: ConnecterOuInscrire())
            : FutureBuilder<DocumentSnapshot>(
                future: getUtilisateur(utilisateurConnecter.uid),
                builder: ((context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.exists) {
                      Utilisateur utilisateur =
                          Utilisateur.utilisateurFromSnapShot(snapshot.data);
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Material(
                          color: const Color.fromARGB(255, 222, 233, 232),
                          //Color.fromARGB(255, 190, 236,235), //Color.fromARGB(255, 130, 219,216), //const Color.fromARGB(255, 179, 232, 229),
                          child: ListView(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 222, 233,
                                      232), //Color.fromARGB(255, 190, 236, 235),
                                ), //Color.fromARGB(255, 179, 232, 229)),
                                margin:
                                    const EdgeInsets.only(right: 100, top: 20),
                                height: MediaQuery.of(context).size.width / 4,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Hero(
                                    tag: "avatar",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 27, 36, 48)),
                                            shape: BoxShape.circle),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profil(
                                                          utilisateur:
                                                              utilisateur,
                                                        )));
                                          },
                                          child: CircleAvatar(
                                            foregroundColor: Colors.white,
                                            minRadius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255,
                                                    48,
                                                    170,
                                                    221), //Colors.yellowAccent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                utilisateur.nomUtilisateur,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 3,
                                color: const Color.fromARGB(255, 67, 145, 155),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.4),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.info_rounded,
                                  color: Color.fromARGB(255, 67, 145, 155),
                                ),
                                title: const Text(
                                  "À Props",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 67, 145, 155),
                                      fontSize: 20),
                                ),
                                onTap: () {
                                  showAboutDialog(context: context, children: [
                                    Wrap(
                                      children: const [
                                        Text(
                                            "Cette application a ete cree avec le but de rendre la communication entre les etudiants plus facile et independate des reseau sociaux c'est notre pfe pour l'annee 2021/2022"),
                                      ],
                                    )
                                  ]);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.logout_rounded,
                                  color: Color.fromARGB(255, 67, 145, 155),
                                ),
                                title: const Text(
                                  "Deconnexion",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 67, 145, 155),
                                      fontSize: 20),
                                ),
                                onTap: () {
                                  context
                                      .read<ServiceAuthentification>()
                                      .deconnexion();
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}
