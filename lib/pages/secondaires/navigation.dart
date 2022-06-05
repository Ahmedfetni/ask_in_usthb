import 'package:ask_in_usthb/services/service_authentification.dart';

import '../widgets/connecter_ou_inscrire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  Navigation({
    Key? key,
  }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    //final utilisateurConnecter = Provider.of<User>(context, listen: false).
    final utilisateurConnecter = context.watch<User?>();
    return Drawer(
      elevation: 8,
      backgroundColor: Colors.white,
      child: utilisateurConnecter == null
          ? const Center(child: ConnecterOuInscrire())
          : Container(
              padding: const EdgeInsets.all(16),
              child: Material(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 100, top: 20),
                      height: MediaQuery.of(context).size.width / 4,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Colors.blueAccent),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            minRadius: MediaQuery.of(context).size.width * 0.1,
                            backgroundColor: Colors.yellowAccent,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Mohammed",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 3,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings_rounded,
                        color: Colors.black,
                      ),
                      title: Text("Parametres"),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_rounded,
                        color: Colors.black,
                      ),
                      title: Text("Deconnexion"),
                      onTap: () {
                        context.read<ServiceAuthentification>().deconnexion();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
