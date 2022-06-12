import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'service_base_de_donnees.dart';

class ServiceAuthentification {
  late final FirebaseAuth _firebaseAuth;
  ServiceAuthentification() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> connexion(
      {required String email, required String motDePasse}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: motDePasse);

      return "Connexion avec succesé";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Utilisateur n'est existe pas";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe icorrect";
      }
      return e.message!;
    }
  }

  /* La fonction pour s'inscrire et cree un utilisateur */
  Future inscrire(
      {required String email,
      required String motDePasse,
      required String nomUtilisateur,
      required String niveau,
      required String dateDeNaissance}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: motDePasse);
      User? user = result.user;
      if (user != null) {
        await ServiceBaseDeDonnes(uid: user.uid)
            .mettreAjourInfo(nomUtilisateur, niveau, dateDeNaissance);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('le mot de passe est ters faible ');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('cette email existe deja');
      }
      debugPrint(e.message);
    }
  }

  Future<void> deconnexion() async {
    _firebaseAuth.signOut();
  }
}
