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
  //Ajouter un utilisateur
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

  //pour recevoire le nom de l'utilisateur
  Future<String> getNomUtilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get()
        .then((value) {
      return value.data()!['nomUtilisateur'];
    });
  }

  Future mettreAjourVote(String idQuestion, int vote) async {
    //TODO add a test so the user can not vote twice on the same question like a +2 or something
    try {
      await collectionQuestion
          .doc(idQuestion)
          .update({"vote": vote}).then((value) {
        return value;
      });
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': ${e.message}");
    }
  }

  //Ajouter une question au favories
  Future ajouterUneQuestionAuFavories(String idQuestion) async {
    await collectionUtilisateur.doc(uid).update({
      //TODO Ajouter une question au favories
    }).then((value) {
      return value;
    });
  }

  //pour ajouter une reponse
  Future ajouterUneRponse1(
    String idQuestion,
    String text,
  ) async {
    final collectionDesRponse1 =
        collectionQuestion.doc(idQuestion).collection("reponses");
    try {
      String nomUtilisateur = await getNomUtilisateur(uid!);
      await collectionDesRponse1.add({
        'uid': uid,
        'nomutilisateur': nomUtilisateur,
        'text': text,
        'vote': 0,
        'date': FieldValue.serverTimestamp(),
      }).then((value) {
        return value;
      });
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      debugPrint("Failed with error '${e.code}': ${e.message}");
    }
  }

  // TITLE pour ajouter une sauvgrader une question
  Future sauvgarderQuestion(
      String? titre, String? corp, List<String> tags, String espace) async {
    try {
      String nomutilisateur = await getNomUtilisateur(uid!);
      await collectionQuestion.add({
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
