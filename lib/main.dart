import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/data/variables.dart';
import 'package:nombres_apprendre_exercices/initialize_screen.dart';
import 'package:nombres_apprendre_exercices/pages/chaine.dart';
import 'package:nombres_apprendre_exercices/pages/consulter.dart';
import 'package:nombres_apprendre_exercices/pages/devine_audio.dart';
import 'package:nombres_apprendre_exercices/pages/exercices.dart';
import 'package:nombres_apprendre_exercices/pages/explications.dart';
import 'package:provider/provider.dart';
import 'data/constantes.dart';
import 'pages/parametres.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    title: "Les nombres : apprendre et s'exercer",
    theme: ThemeData(scaffoldBackgroundColor: couleurFondGeneral),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    // L'utilisateur n'a pas encore consenti ?
    if (!dejaCharge) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InitializeScreen(targetWidget: MyApp()),
      );
    } else {
      WidgetsFlutterBinding.ensureInitialized();
      MobileAds.instance.initialize();
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: couleurFondGeneral,
        appBar: AppBar(
          title: appBarTitre,
          backgroundColor: appBarCouleurFond,
          foregroundColor: appBarCouleurText,
          centerTitle: true,
          actions: [
            IconButton(
              icon: iconeParametres,
              tooltip: "Paramètres",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Parametres()));
              },
            )
          ],
        ),

        // Tous les trucs qui sont en bas
        bottomNavigationBar: const TabBar(
          labelColor: Color(0xff00049f),
          indicatorColor: Color(0xffef3131),
          tabs: [
            Tab(icon: tabsIconConsulter, text: tabsNomConsulter),
            Tab(icon: tabsIconChaine, text: tabsNomChaine),
            Tab(icon: Icon(Icons.play_arrow), text: tabsNomAudio),
            Tab(icon: tabsIconExercices, text: tabsNomExercices),
            Tab(
              icon: tabsIconExplications,
              text: tabsNomExplications,
            )
          ],
        ),

        // Contenu des onglets
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Consulter(),
              Chaine(),
              ChangeNotifierProvider(
                create: (context) => ProviderDevineAudio(),
                child: DevineAudio(),
              ),
              Exercices(),
              Explications()]),
      ),
    );
    
  }
}
