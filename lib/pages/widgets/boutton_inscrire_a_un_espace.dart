import 'package:ask_in_usthb/models/espace.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/utilisateur.dart';
import '../../services/service_base_de_donnees.dart';

class BouttonInscrireAUnEspace extends StatefulWidget {
  Espace espace;

  BouttonInscrireAUnEspace({Key? key, required this.espace}) : super(key: key);

  @override
  State<BouttonInscrireAUnEspace> createState() =>
      _BouttonInscrireAUnEspaceState();
}

class _BouttonInscrireAUnEspaceState extends State<BouttonInscrireAUnEspace> {
  //get info d'utilisateur
  bool utilisateurInscrit = false;
  Future<DocumentSnapshot> getUtilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final utilisateurConnecter = context.watch<User?>();
    if (utilisateurConnecter != null) {
      return FutureBuilder<DocumentSnapshot>(
          future: getUtilisateur(utilisateurConnecter.uid),
          builder: ((context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.exists) {
                Utilisateur utilisateur =
                    Utilisateur.utilisateurFromSnapShot(snapshot.data);
                debugPrint(
                    "les espace de l'utilisateur ${utilisateur.espaces.toString()}");
                // ignore: iterable_contains_unrelated_type
                if (utilisateur.espaces.contains(widget.espace.getNom) ||
                    utilisateurInscrit) {
                  debugPrint("we made it ");
                  return TextButton.icon(
                      onPressed: () async {
                        //TODO disaboonee
                        await ServiceBaseDeDonnes(uid: utilisateurConnecter.uid)
                            .supprimerEspace(widget.espace.getNom);
                      },
                      icon: const Icon(
                        Icons.done_rounded,
                        color: Colors.green,
                      ),
                      label: const Text(""));
                }

                return TextButton.icon(
                  onPressed: () async {
                    setState(() {
                      utilisateurInscrit = true;
                    });
                    await ServiceBaseDeDonnes(uid: utilisateurConnecter.uid)
                        .ajouterEspace(widget.espace.getNom);
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                  ),
                  label: const Text(''),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }));
    } else {
      return Container();
    }
  }
}
