import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:flutter/material.dart';
import 'package:nombres_apprendre_exercices/data/variables.dart';
import 'package:nombres_apprendre_exercices/initialize_screen.dart';
import 'package:nombres_apprendre_exercices/pages/chaine.dart';
import 'package:nombres_apprendre_exercices/pages/consulter.dart';
import 'package:nombres_apprendre_exercices/pages/exercices.dart';
import 'package:nombres_apprendre_exercices/pages/explications.dart';
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
    // Vérifier si l'utilisateur a internet

    try {
      InternetAddress.lookup("example.com").then((v) {
        if (!(v.isNotEmpty && v[0].rawAddress.isNotEmpty)) {
          // En l'absence de connexion, on place l'utilisateur en AFS
          isCountryLoaded = true;
          countryData.country_code = "ZA";
        }
      });
    } on SocketException catch (_) {
      //
    }

    // Localiser l'utilisateur
    if (!isCountryLoaded) {
      IpCountryLookup().getIpLocationData().then((country) {
        setState(() {
          countryData = country;
          isCountryLoaded = true;
        });
      });
      return const Scaffold(
          backgroundColor: couleurFondGeneral,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: paddingMarginGeneral,
                child: Text(
                  "Vérification du pays...",
                  style: textStyleNormal,
                ),
              ),
              Padding(
                padding: paddingMarginGeneral,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            ],
          )));
    }

    // Si le code du pays a déjà été chargé
    else {
      // L'utilisateur n'a pas encore consenti ?

      if (!dejaCharge &&
          countriesRequiringGDPR.contains(countryData.country_code)) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: InitializeScreen(targetWidget: MyApp()),
        );
      } else {
        WidgetsFlutterBinding.ensureInitialized();
        MobileAds.instance.initialize();
      }

      return DefaultTabController(
        length: 4,
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
              Tab(icon: tabsIconExercices, text: tabsNomExercices),
              Tab(
                icon: tabsIconExplications,
                text: tabsNomExplications,
              )
            ],
          ),

          // Contenu des onglets
          body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [Consulter(), Chaine(), Exercices(), Explications()]),
        ),
      );
    }
  }
}
