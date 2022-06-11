import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/principales/accueil.dart';
import 'pages/principales/favories.dart';
import 'pages/principales/notifications.dart';
import 'pages/principales/list_des_espaces.dart';
import 'package:provider/provider.dart';
import 'services/service_authentification.dart';

/* 
  ); */
void main() async {
  // attendre l'intialisation
  WidgetsFlutterBinding.ensureInitialized();
  //intialisation de la base de donnnees de l'application
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); //lancer l'application
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool utilisateurConnecter = true;
  int indexDesEcrant = 0;
  bool ajouterTagEstAutoFocus = false;
  @override
  Widget build(BuildContext context) {
    final listDesEcrant = [
      PageAccueil(),
      ListDesEspaces(utilisateurConnecter: utilisateurConnecter),
      PageDesFavories(utilisateurConnecter: utilisateurConnecter),
      PageNotification(utilisateurConnecter: utilisateurConnecter),
    ];
    return MultiProvider(
      /* Des informations partager par toute l'application  */
      providers: [
        Provider<ServiceAuthentification>(
            //Pour cree un compte ou bien pour connecter
            create: ((context) => ServiceAuthentification())),
        StreamProvider(
          //pour voir l'etat de la connexion
          create: (context) =>
              context.read<ServiceAuthentification>().authStateChanges,
          initialData: null,
        )
      ],
      //L'application
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ask In USTHB',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          home: Scaffold(
            body: listDesEcrant[
                indexDesEcrant], //Center(child: CarteEspaceGenieMec()),
            bottomNavigationBar: CurvedNavigationBar(
              onTap: ((index) => setState(() {
                    indexDesEcrant = index;
                  })),
              animationDuration: const Duration(milliseconds: 100),
              buttonBackgroundColor: Colors.lightBlue,
              backgroundColor: Colors.white,
              color: Colors.lightBlue,
              items: const [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.group_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.bookmark_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.notifications_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
          )
          // Connexion(), //pageAccueil(), //const MyHomePage(title: 'Page d\'acceuil'),
          ),
    );
  }
}
