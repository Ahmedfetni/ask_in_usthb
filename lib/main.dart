import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'pages/principales/accueil.dart';
import 'pages/principales/favories.dart';
import 'pages/principales/notifications.dart';
import 'pages/principales/list_des_espaces.dart';
import 'package:provider/provider.dart';
import 'services/service_authentification.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  @override
  Widget build(BuildContext context) {
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
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(248, 21, 103, 116),
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: Color.fromARGB(255, 47, 143, 157),
            )),
        home: PageIntial(),
        // Connexion(), //pageAccueil(), //const MyHomePage(title: 'Page d\'acceuil'),
      ),
    );
  }
}

//Page pour verfiier la connection internet
class PageIntial extends StatefulWidget {
  PageIntial({Key? key}) : super(key: key);

  @override
  State<PageIntial> createState() => _PageIntialState();
}

class _PageIntialState extends State<PageIntial> {
  late StreamSubscription sub;
  bool connecter = false;
  @override
  void initState() {
    sub = InternetConnectionChecker().onStatusChange.listen((event) {
      setState(() {
        connecter = (event == InternetConnectionStatus.connected);
      });
      if (connecter) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => PagePrincipale())));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 170, 221),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
              vertical: MediaQuery.of(context).size.height * 0.2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceAround,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "vérifier le wifi ou les données mobiles",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 65, 74),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Icon(
                        Icons.wifi_rounded,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const CircularProgressIndicator(
                    strokeWidth: 8,
                    color: Color.fromARGB(255, 0, 255, 198),
                    backgroundColor: Color.fromARGB(255, 193, 236, 226)),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "en attendant d'établir la connexion Internet ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 133, 242, 217),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PagePrincipale())));
                  },
                  label: Wrap(children: const [
                    Text(
                      "Passer au mode hors ligne",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 10, 65, 74)),
                    )
                  ]),
                  icon: const Icon((Icons.navigate_next_rounded),
                      size: 16, color: Color.fromARGB(255, 10, 65, 74)),
                ),
              ],
            ),
          ),
        ));
  }
}

class PagePrincipale extends StatefulWidget {
  PagePrincipale({Key? key}) : super(key: key);

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  bool utilisateurConnecter = true;
  int indexDesEcrant = 0;
  bool ajouterTagEstAutoFocus = false;
  final listDesEcrant = [
    const PageAccueil(),
    ListDesEspaces(),
    PageDesFavories(),
    const PageNotification(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          listDesEcrant[indexDesEcrant], //Center(child: CarteEspaceGenieMec()),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: ((index) => setState(() {
              indexDesEcrant = index;
            })),
        animationDuration: const Duration(milliseconds: 80),
        buttonBackgroundColor: const Color.fromARGB(255, 51, 212, 177),
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 47, 143, 157),
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors
                .white, //Color.fromARGB(255, 22, 152, 207), // Colors.white,
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
    );
  }
}
