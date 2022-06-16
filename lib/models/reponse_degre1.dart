import 'reponse_degre2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReponseDegre1 {
  String nomUtilisateur, id, idQuestion;
  String text;
  int vote;
  String date;
  List<ReponseDegre2> reponses;

  ReponseDegre1(
      {required this.id,
      required this.idQuestion,
      required this.nomUtilisateur,
      required this.text,
      this.vote = 0,
      required this.date,
      this.reponses = const []});

  static ReponseDegre1 reponseFromSnapshot(DocumentSnapshot snapshot) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String id = snapshot.id;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var listDesReponse = <ReponseDegre2>[];
    if (data.containsKey("reponses")) {
      //TODO some traitment
    }
    return ReponseDegre1(
      id: id,
      nomUtilisateur: data.containsKey("nomutilisateur")
          ? data["nomutilisateur"]
          : "default",
      text: data.containsKey("text") ? data["text"] : "vide",
      date: data.containsKey("date") && data["date"] != null
          ? dateFormat.format(DateTime.parse(data['date'].toDate().toString()))
          : "auccune date",
      vote: data.containsKey("vote") ? data["vote"] : 0,
      idQuestion: data.containsKey("idQuestion") ? data['idQuestion'] : "",
    );
  }

  String get getText => text;
  String get getNomUtilisateur => nomUtilisateur;
  int get getVote => vote;
  String get getDate => date;
  List<ReponseDegre2> get getReponses => reponses;

  void ajouterUneReponse(ReponseDegre2 reponse) {
    reponses.add(reponse);
  }

  void supprimerUneReponse(ReponseDegre2 reponse) {
    reponses.remove(reponse);
  }

  void plusVote() {
    vote++;
  }

  void moinsVote() {
    vote--;
  }
}
