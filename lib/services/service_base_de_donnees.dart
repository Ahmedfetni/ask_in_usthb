import 'package:flutter/material.dart';

import 'package:ask_in_usthb/models/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceBaseDeDonnes {
  final String? uid;
  ServiceBaseDeDonnes({required this.uid});
  final CollectionReference collectionUtilisateur =
      FirebaseFirestore.instance.collection("utilisateurs");
  final CollectionReference collectionQuestion =
      FirebaseFirestore.instance.collection("Questions");

  Future mettreAjourInfo(
    String nomUtilisateur,
    String niveau,
    String dateDeNaissance,
  ) async {
    return await collectionUtilisateur.doc(uid).set({
      "nomUtilisateur": nomUtilisateur,
      "niveau": niveau,
      "dateDeNaissance": dateDeNaissance,
    });
  }

  Future<String> getNomUtilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get()
        .then((value) {
      return value.data()!['nomUtilisateur'];
    });
  }

  Future sauvgarderQuestion(
      String? titre, String? corp, List<String> tags, String espace) async {
    try {
      String nomutilisateur = await getNomUtilisateur(uid!);
      final result = await collectionQuestion.add({
        "titre": titre,
        "corp": corp,
        "date": FieldValue.serverTimestamp(),
        "nomutilisateur": nomutilisateur,
        "uid": uid,
        "vote": 0,
        "tags": tags,
        "espace": espace,
      }).then((value) async {
        //TODO balek kchma nzido 3fsa
        return value;
      });
    } catch (e) {
      debugPrint(" un erreur ");
    }
  }
}
