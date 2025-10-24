import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/types/bouton_elevated.dart';

import '../data/constantes.dart';
import '../types/container_titre.dart';
import '../types/nombres.dart';

/*
 * 1. Faire en sorte que ça ne soit pas une colonne de champs, mais des pages qui
 * défilent
 * 2. Ne pas afficher la variante correcte pour les bonnes réponses
 */

class ExerciceLance extends StatefulWidget {
  final double _min;
  final double _max;
  final int _reps;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ExerciceLance(this._min, this._max, this._reps, {super.key});

  @override
  State<StatefulWidget> createState() => _ExerciceLanceState();
}

class _ExerciceLanceState extends State<ExerciceLance> {
  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2601867806541576/6234023519'
      : 'ca-app-pub-3940256099942544/4411468910';

  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          debugPrint("$ad loaded.");
          _interstitialAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          debugPrint("InterstitialAd failed to load: $error");
        }));
  }

  bool fini = false;
  final List<double> _listNombres = <double>[];

  final List<TextEditingController> _listControllers =
      <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    if (!fini) {
      for (int i = 0; i < widget._reps; i++) {
        _listNombres.add(
            ((Random().nextDouble() * (widget._max - widget._min)) +
                    widget._min)
                .floorToDouble());
      }
      return Scaffold(
          appBar: AppBar(
            title: textAppBarTitreExercice,
            backgroundColor: appBarCouleurFond,
            foregroundColor: appBarCouleurText,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Form(
              key: widget._formKey,
              child: ListView(
                children: [
                  createListeChamps(),
                  Padding(
                      padding: paddingMarginGeneral,
                      child: BoutonElevated(textTerminerExo, () {
                        if (widget._formKey.currentState!.validate()) {
                          _interstitialAd?.show();
                          setState(() {
                            fini = true;
                          });
                        }
                      }))
                ],
              )));
    } else {
      List<bool> listBonPasBon = <bool>[];
      int nombreBonnesReponses = 0;
      List<Nombre> listCorrigee = <Nombre>[];
      List<Padding> listReponses = <Padding>[];

      for (int i = 0; i < widget._reps; i++) {
        listCorrigee.add(Nombre(_listNombres[i].toDouble()));
        Color couleurEnCours;

        /*
         * Certains claviers ajoutent des espaces à la fin des mots lors de
         * l'utilisation du correcteur automatique.
         * La méthode "trim" permet d'éviter que cette fonctionnalité ne crée
         * de problèmes
         */

        if (listCorrigee[i].nom!.toLowerCase() ==
            _listControllers[i].text.toLowerCase().trim()) {
          listBonPasBon.add(true);
          nombreBonnesReponses++;
          couleurEnCours = couleurBordureBonneReponse;
        } else {
          listBonPasBon.add(false);
          couleurEnCours = couleurBordureMauvaiseReponse;
        }

        listReponses.add(Padding(
          padding: paddingMarginGeneral,
          child: ContainerTitre.avecBordure(
              Nombre.montreAvecEspace(
                  Nombre.removeDecimalZero(_listNombres[i])),
              couleurEnCours,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ligne 1

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                          alignment: Alignment.topRight,
                          child: Text("Vous aviez mis : ")),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(_listControllers[i].text)))
                    ],
                  ),

                  // ligne 2
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const Align(
                        alignment: Alignment.topRight,
                        child: Text("Il fallait mettre : ")),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(Nombre(_listNombres[i]).nom!)))
                  ]),
                ],
              )),
        ));
      }

      return Scaffold(
        appBar: AppBar(
          title: textAppBarTitreExercice,
          backgroundColor: appBarCouleurFond,
          foregroundColor: appBarCouleurText,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              Padding(
                padding: paddingMarginGeneral,
                child: ContainerTitre(
                    title: "Résultat",
                    childWidget: Padding(
                        padding: paddingMarginGeneral,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Note : $nombreBonnesReponses / ${widget._reps}")))),
              ),
              ...listReponses,
              BoutonElevated(
                  textTerminerLireReponses, () => Navigator.pop(context))
            ],
          )
        ]),
      );
    }
  }

  // Créer la liste des champs à remplir
  Column createListeChamps() {
    List<Padding> list = <Padding>[];

    for (int i = 0; i < widget._reps; i++) {
      TextEditingController controllerEnCours = TextEditingController();
      _listControllers.add(controllerEnCours);

      list.add(Padding(
          padding: paddingMarginGeneral,
          child: ContainerTitre(
              title: (i + 1).toString(),
              childWidget: Column(
                children: [
                  Padding(
                    padding: paddingMarginGeneral,
                    child: Text(Nombre.montreAvecEspace(
                        Nombre.removeDecimalZero(_listNombres[i]))),
                  ),
                  Padding(
                      padding: paddingMarginGeneral,
                      child: TextFormField(
                          controller: controllerEnCours,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return stringLeChampEstVide;
                            }
                            return null;
                          }))
                ],
              ))));
    }

    return Column(
      children: [...list],
    );
  }
}
