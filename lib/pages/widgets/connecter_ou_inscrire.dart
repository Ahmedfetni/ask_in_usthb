import 'package:flutter/material.dart';
import '../auth/cree_compte.dart';
import '../auth/connexion.dart';

class ConnecterOuInscrire extends StatelessWidget {
  const ConnecterOuInscrire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Connexion())));
              },
              style: TextButton.styleFrom(
                elevation: 4,
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Connexion",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CrierCompte())));
              },
              style: TextButton.styleFrom(
                elevation: 4,
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Inscrire",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
    );
  }
}
