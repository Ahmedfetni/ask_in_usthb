//import 'package:email_validator/email_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:ask_in_usthb/models/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO ajouter vote pour reponse et reponse a une reponse
//TODO les espace
//TODO recherche
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
      "favories": [],
      "questions": [],
      "reponse": [],
      "qVotePlus": [],
      "qVoteMoins": [],
      "rVotePlus": [],
      "rVoteMoins": [],
      "espaces": []
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

  Future<bool> mettreAjourVote(String idQuestion, int vote, bool plus) async {
    try {
      String typeVote = plus ? "qVotePlus" : "qVoteMoins";
      String otherType = !plus ? "qVotePlus" : "qVoteMoins";
      DocumentSnapshot utilisateur = await collectionUtilisateur.doc(uid).get();
      if (utilisateur.exists) {
        Map<String, dynamic> data = utilisateur.data() as Map<String, dynamic>;
        for (String el in data.keys) {
          debugPrint(el);
        }
        if (data.containsKey(otherType)) {
          List<dynamic> liIdOther = data[otherType] as List<dynamic>;
          if (liIdOther.contains(idQuestion)) {
            //Traitement ou cas ou l'utilisateur a deja ajouter un vote et il veut inverser ce vote
            //liIdOther.remove(idQuestion); //Supprimer l'ID de la question
            await collectionUtilisateur.doc(uid).update({
              otherType: FieldValue.arrayRemove([idQuestion])
            });
          }
        }
        if (data.containsKey(type)) {
          List<dynamic> liId = data[typeVote] as List<dynamic>;
          if (!(liId.contains(idQuestion))) {
            await collectionUtilisateur.doc(uid).update({
              typeVote: FieldValue.arrayUnion([idQuestion]),
            });
            await collectionQuestion
                .doc(idQuestion)
                .update({"vote": vote}).then((value) {
              return true;
            });
          }
        } else {
          await collectionUtilisateur.doc(uid).update({
            typeVote: FieldValue.arrayUnion([idQuestion]),
          });
          await collectionQuestion
              .doc(idQuestion)
              .update({"vote": vote}).then((value) {
            return true;
          });
        }
      }
      return false;
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': ${e.message}");
      return false;
    }
  }

  //Ajouter une question au favories
  Future ajouterUneQuestionAuFavories(String idQuestion) async {
    try {
      await collectionUtilisateur.doc(uid).update({
        //TODO Ajouter une question au favories
        'favories': FieldValue.arrayUnion([idQuestion]),
      }).then((value) {
        return value;
      });
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': ${e.message}");
    }
  }

  //pour ajouter une reponse
  Future ajouterUneRponse1(
    String idQuestion,
    String text,
  ) async {
    final collectionDesRponse1 =
        collectionQuestion.doc(idQuestion).collection("reponses");
    if (uid != null) {
      try {
        String nomUtilisateur = await getNomUtilisateur(uid!);
        await collectionDesRponse1.add({
          'idQuestion': idQuestion,
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
  }

  //Ajouter une reponse a une reponse
  Future ajouterUneReponse2(
      String idQuestion, String idReponse, String text) async {
    final collection = collectionQuestion
        .doc(idQuestion)
        .collection("reponses")
        .doc(idReponse)
        .collection("reponseDegre2");
    try {
      String nomUtilisateur = await getNomUtilisateur(uid!);
      await collection.add({
        'idQuestion': idQuestion,
        "idReponse1": idReponse,
        'uid': uid,
        'nomutilisateur': nomUtilisateur,
        'text': text,
        'vote': 0,
        'date': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
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
