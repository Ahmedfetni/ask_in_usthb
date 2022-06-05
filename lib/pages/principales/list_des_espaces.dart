import '../widgets/connecter_ou_inscrire.dart';
import '../../models/espace.dart';
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
