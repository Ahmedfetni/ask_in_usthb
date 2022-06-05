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
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

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
    return FutureBuilder(
      future: _initialize(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          //TODO traitement d'erreur
          return const Scaffold(
            body: Text(" Redemarer l'application "),
          );
        }
        /* Dans le cas ou l'intiialisation termine sans erreurs  */
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<ServiceAuthentification>(
                  create: ((context) => ServiceAuthentification())),
              StreamProvider(
                create: (context) =>
                    context.read<ServiceAuthentification>().authStateChanges,
                initialData: null,
              )
            ],
            child: MaterialApp(
                title: 'Flutter Demo',
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
                    animationDuration: const Duration(milliseconds: 300),
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
        return const CircularProgressIndicator();
      }),
    );

    /* */
  }
}
