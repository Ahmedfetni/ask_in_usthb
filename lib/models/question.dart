//import 'dart:js_util';

import 'reponse_degre1.dart';
import 'tag.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id, espace;
  String titre, corp, nomUtilisateur;
  String date;
  List<Tag> listDesTags;
  int vote;
  List<ReponseDegre1> reponses;

  Question({
    required this.id,
    //required this.userId,
    required this.titre,
    required this.corp,
    required this.nomUtilisateur,
    this.vote = 0,
    required this.date,
    required this.espace,
    this.listDesTags = const [],
    this.reponses = const [],
  });
  static Future<String> nomDutilisateur(String uid) async {
    return await FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(uid)
        .get()
        .then((value) {
      return value.data()!['nomUtilisateur'];
    });
  }

  //Si la question a des reponses
  static Future<bool> checkIfReponseExiste(String idQuestion) {
    return FirebaseFirestore.instance
        .collection('Question')
        .doc(idQuestion)
        .collection("reponses")
        .get()
        .then((value) {
      return value.docs.isNotEmpty;
    });
  }

  static Question questionFromSnapshot(DocumentSnapshot snapshot) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    //Cree la list des tag
    var listDesTag = <Tag>[];
    if (data.containsKey('tags')) {
      List<dynamic> li = data['tags'];
      for (String element in li) {
        listDesTag.add(Tag(nom: element));
      }
    }
    return Question(
      id: data.containsKey('id') ? data['id'] : '',
      titre: data.containsKey('titre') ? data['titre'] : 'titre par defaut',
      corp: data.containsKey('corp') ? data['corp'] : "",
      nomUtilisateur:
          data.containsKey('nomutilisateur') && data['nomutilisateur'] != null
              ? data['nomutilisateur']
              : "defaut",
      date: dateFormat.format(DateTime.parse(data['date'].toDate().toString())),
      espace: data.containsKey('espace') ? data['espace'] : "sans espace",
      listDesTags: listDesTag,
      vote: data['vote'],
      //reponses: data.containsKey('reponse')
    );
  }

  String get getTitre => titre;
  String get getCorp => corp;
  String get getNomUtilisateur => nomUtilisateur;
  int get getVote => vote;
  String get getDate => date;
  List<Tag> get getTags => listDesTags;
  List<ReponseDegre1> get getReponses => reponses;

  void addTag(String nomDuTag) {
    Tag tag = Tag(nom: nomDuTag);
    listDesTags.add(tag);
  }

  void supprimerTag(String nomDuTag) {
    listDesTags.retainWhere((element) => element.getNom == nomDuTag);
  }

  void ajouterUneReponse(ReponseDegre1 reponse) {
    reponses.add(reponse);
  }

  void supprimerUneReponse(ReponseDegre1 reponse) {
    reponses.remove(reponse);
  }
}
