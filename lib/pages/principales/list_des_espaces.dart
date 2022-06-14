import '../widgets/connecter_ou_inscrire.dart';
import '../../models/espace.dart';
import 'package:provider/provider.dart';
import '../widgets/cartes/carte_espace_constant.dart';
import 'package:flutter/material.dart';

class ListDesEspaces extends StatelessWidget {
  bool utilisateurConnecter;
  ListDesEspaces({Key? key, required this.utilisateurConnecter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = const [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 143, 157),
        centerTitle: true,
        title: const Text(
          "Espaces",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: elements.isNotEmpty
            ? ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ..._listDesEspaceConstant(elements),
                ],
              )
            : const Center(
                child: Text("Auccun espace pour le moments"),
              ),
      ),
    );
  }

  _listDesEspaceConstant(element) => [
        CarteEspaceConstant(espace: element[0], image: "math.jpg"),
        CarteEspaceConstant(espace: element[1], image: "bio.jpg"),
        CarteEspaceConstant(espace: element[1], image: "mec.jpg"),
      ];
}
