import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';
import 'package:nombres_apprendre_exercices/main.dart';
import 'package:nombres_apprendre_exercices/types/bouton_elevated.dart';
import 'package:nombres_apprendre_exercices/types/container_titre.dart';

import '../data/variables.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<StatefulWidget> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {
    List<Widget> toShow = [
      Padding(
        padding: paddingMarginGeneral,
        child: ContainerTitre("Attention", textParametresEcrivezMoi),
      ),
      Padding(
        padding: paddingMarginGeneral,
        child: ContainerTitre("Me contacter", textParametresContacts),
      ),
      Padding(
        padding: paddingMarginGeneral,
        child: ContainerTitre(
            stringMenuPrincipalConstantes, textMenuPrincipalConstantes),
      )
    ];

    if (countriesRequiringGDPR.contains(countryData.country_code)) {
      toShow.add(Padding(
        padding: paddingEntreBoutons,
        child: BoutonElevated(
            const Text("Changer les règles de confidentialité"), () {
          dejaCharge = false;
          ConsentInformation.instance.reset();

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const MyApp()));
        }),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
        foregroundColor: appBarCouleurText,
        backgroundColor: appBarCouleurFond,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: couleurFondGeneral,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: toShow,
          ),
        ],
      ),
    );
  }
}
