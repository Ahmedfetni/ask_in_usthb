import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UneNotification {
  bool reponse;
  String uidQst;
  String idQst;
  String uidRep;
  List<String> corp;
  bool vuParPoserQst;
  bool vuParPoseurReponse;
  UneNotification(
      {required this.corp,
      required this.vuParPoserQst,
      required this.vuParPoseurReponse,
      required this.idQst,
      required this.uidQst,
      required this.uidRep,
      required this.reponse});

  static UneNotification questionFromSnapshot(DocumentSnapshot snapshot) {
    //DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    //String id = snapshot.id;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    //Cree la list des tag
    List<dynamic> li =
        data.containsKey('corp') && data['corp'] != null ? data['corp'] : [];
    List<String> corp = [];
    for (var element in li) {
      corp.add(element);
    }
    if (data.containsKey('reponse') &&
        data['reponse'] != null &&
        data['reponse'] == false) {
      return UneNotification(
          vuParPoserQst:
              data.containsKey('vuParPoserQst') && data['vuParPoserQst'] != null
                  ? data['vuParPoserQst']
                  : '',
          vuParPoseurReponse: false,
          idQst: data.containsKey('idQst') && data['idQst'] != null
              ? data['idQst']
              : '',
          uidQst: data.containsKey('uidQst') && data['uidQst'] != null
              ? data['uidQst']
              : '',
          uidRep: '',
          reponse: false,
          corp: corp);
    }
    return UneNotification(
      vuParPoserQst:
          data.containsKey('vuParPoserQst') && data['vuParPoserQst'] != null
              ? data['vuParPoserQst']
              : '',
      vuParPoseurReponse: data.containsKey('vuParPoseurReponse') &&
              data['vuParPoseurReponse'] != null
          ? data['vuParPoseurReponse']
          : '',
      idQst: data.containsKey('idQst') && data['idQst'] != null
          ? data['idQst']
          : '',
      uidQst: data.containsKey('uidQst') && data['uidQst'] != null
          ? data['uidQst']
          : '',
      uidRep: data.containsKey('uidRep') && data['uidRep'] != null
          ? data['uidRep']
          : '',
      reponse: true,
      corp: corp,
    );
  }
}
