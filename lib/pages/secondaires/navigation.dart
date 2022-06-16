import 'package:ask_in_usthb/services/service_authentification.dart';

import '../widgets/connecter_ou_inscrire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'page_profil.dart';

class Navigation extends StatefulWidget {
  const Navigation({
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
      backgroundColor: const Color.fromARGB(255, 222, 233, 232),
      //Color.fromARGB(255, 190, 236,
      //235), // Color.fromARGB(255, 130, 219, 216), //Color.fromARGB(255, 179, 232, 229),
      child: utilisateurConnecter == null
          ? const Center(child: ConnecterOuInscrire())
          : Container(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: const Color.fromARGB(255, 222, 233, 232),
                //Color.fromARGB(255, 190, 236,235), //Color.fromARGB(255, 130, 219,216), //const Color.fromARGB(255, 179, 232, 229),
                child: ListView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 222, 233,
                            232), //Color.fromARGB(255, 190, 236, 235),
                      ), //Color.fromARGB(255, 179, 232, 229)),
                      margin: const EdgeInsets.only(right: 100, top: 20),
                      height: MediaQuery.of(context).size.width / 4,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Hero(
                          tag: "avatar",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          255, 27, 36, 48)),
                                  shape: BoxShape.circle),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profil()));
                                },
                                child: CircleAvatar(
                                  foregroundColor: Colors.white,
                                  minRadius:
                                      MediaQuery.of(context).size.width * 0.1,
                                  backgroundColor: const Color.fromARGB(
                                      255, 48, 170, 221), //Colors.yellowAccent,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Mohammed",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 3,
                      color: const Color.fromARGB(255, 67, 145, 155),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.4),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info_rounded,
                        color: Color.fromARGB(255, 67, 145, 155),
                      ),
                      title: const Text(
                        "À Props",
                        style: TextStyle(
                            color: Color.fromARGB(255, 67, 145, 155),
                            fontSize: 20),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_rounded,
                        color: Color.fromARGB(255, 67, 145, 155),
                      ),
                      title: const Text(
                        "Deconnexion",
                        style: TextStyle(
                            color: Color.fromARGB(255, 67, 145, 155),
                            fontSize: 20),
                      ),
                      onTap: () {
                        context.read<ServiceAuthentification>().deconnexion();
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.copyright_rounded,
                          color: Color.fromARGB(255, 67, 145, 155),
                        ),
                        title: const Text(
                          "copyright",
                          style: TextStyle(
                            color: Color.fromARGB(255, 67, 145, 155),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
