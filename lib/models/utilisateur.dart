import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  String uid;
  String nomUtilisateur;
  String niveau;
  String dateNaissance;
  List<String> favories;
  List<String> espaces;

  //String sexe;

  Utilisateur(
      {required this.nomUtilisateur,
      required this.dateNaissance,
      required this.espaces,
      required this.favories,
      required this.niveau,
      required this.uid});

  static Utilisateur utilisateurFromSnapShot(
      DocumentSnapshot<Object?>? snapshot) {
    // ignore: unused_local_variable
    String id = snapshot!.id;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    //Crier la list des favories
    List<String> listDesEspace = [];
    if (data.containsKey("espaces") && data['espaces'] != null) {
      List<dynamic> li = data['espaces'];
      for (String element in li) {
        listDesEspace.add(element);
      }
    }
    List<String> listDesFavories = [];
    if (data.containsKey("favories") && data["favories"] != null) {
      List<dynamic> li = data["favories"];
      for (String element in li) {
        listDesFavories.add(element);
      }
    }
    return Utilisateur(
      uid: snapshot.id,
      nomUtilisateur:
          data.containsKey("nomUtilisateur") && data["nomUtilisateur"] != null
              ? data["nomUtilisateur"]
              : "non reconue",
      dateNaissance:
          data.containsKey("dateDeNaissance") && data["dateDeNaissance"] != null
              ? data["dateDeNaissance"]
              : "non reconue",
      espaces: listDesEspace,
      favories: listDesFavories,
      niveau: data.containsKey("niveau") && data["niveau"] != null
          ? data["niveau"]
          : "non reconue",
    );
  }
}
