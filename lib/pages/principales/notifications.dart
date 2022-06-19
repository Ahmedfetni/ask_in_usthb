import 'package:ask_in_usthb/models/utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/cartes/carte_notification.dart';
import '../../models/une_notification.dart';
import '../widgets/connecter_ou_inscrire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageNotification extends StatelessWidget {
  const PageNotification({
    Key? key,
  }) : super(key: key);

  //Recuperere les notifcation
  Future<QuerySnapshot> getNotifications() async {
    //TODO recuperer tous les notifications
    final collectionNotifciation =
        FirebaseFirestore.instance.collection("notifcation");
    return collectionNotifciation.get();
  }

  @override
  Widget build(BuildContext context) {
    final utilisateurConnecter = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 47, 143, 157),
          title: const Text("Notfications",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
      body: utilisateurConnecter != null
          ? FutureBuilder<QuerySnapshot>(
              future: getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<UneNotification> li = [];

                  for (var element in snapshot.data!.docs) {
                    UneNotification notif =
                        UneNotification.questionFromSnapshot(element);
                    if (notif.uidQst == utilisateurConnecter.uid &&
                        notif.uidRep == utilisateurConnecter.uid) {
                      li.add(notif);
                    }
                  }
                  if (li.isNotEmpty) {
                    return ListView.separated(
                        itemBuilder: (context, index) =>
                            CarteNotification(notif: li[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: li.length);
                  } else {
                    return const Center(
                      child: Text('Auccune notification pour le momments'),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
                //todo cree les cartes des notifications
              },
            )
          : const Center(
              child: ConnecterOuInscrire(),
            ),
    );
  }
}
