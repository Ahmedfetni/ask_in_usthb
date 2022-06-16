import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReponseDegre2 {
  String id;
  String text;
  int vote;
  String date;
  String nomUtilisateur;
  String idReponse1;
  String idQuesion;

  ReponseDegre2({
    required this.id,
    required this.idReponse1,
    required this.idQuesion,
    required this.nomUtilisateur,
    required this.text,
    this.vote = 0,
    required this.date,
  });

  static ReponseDegre2 reponse2FromSnapShot(DocumentSnapshot snapshot) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String id = snapshot.id;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ReponseDegre2(
        id: id,
        idReponse1: data['idReponse1'],
        idQuesion: data['idQuestion'] != null ? data['idQuestion'] : "",
        nomUtilisateur:
            data['nomtilisateur'] != null ? data["nomutilisateur"] : "",
        text: data['text'],
        date:
            dateFormat.format(DateTime.parse(data['date'].toDate().toString())),
        vote: data['vote']);
  }

  String get getText => text;
  String get getNomUtilisateur => nomUtilisateur;
  int get getVote => vote;
  String get getDate => date;

  void plusVote() {
    vote++;
  }

  void moinsVote() {
    vote--;
  }
}
