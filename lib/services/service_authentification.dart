import 'package:firebase_auth/firebase_auth.dart';

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
      return "Connexion";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> inscrire(
      {required String email, required String motDePasse}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: motDePasse);
      return "compte créé avec succes";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'le mot de passe est ters faible ';
      } else if (e.code == 'email-already-in-use') {
        return 'cette email existe deja';
      }
      return e.message!;
    }
  }

  Future<void> deconnexion() async {
    _firebaseAuth.signOut();
  }
}
