import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/banner_ad_stateful.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';
import 'package:nombres_apprendre_exercices/types/bouton_elevated.dart';
import 'package:nombres_apprendre_exercices/types/container_titre.dart';
import 'package:nombres_apprendre_exercices/types/nombres.dart';

import '../data/map_nombres.dart';
import '../data/variables.dart';
import '../types/my_expansion_tile.dart';
import '../types/radio_bouton.dart';
import '../types/text_form_field_only_numbers.dart';

class Chaine extends StatefulWidget {
  const Chaine({super.key});

  @override
  State<StatefulWidget> createState() => _ChaineState();
}

class _ChaineState extends State<Chaine> {
  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2601867806541576/1534330795'
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

  Nombre _nombreGenere = Nombre(Random().nextInt(99).toDouble());
  double min = nombreMin;
  double max = 99;
  String _nomNombre = "";
  String _toShowMauvaiseReponse = "";
  FocusNode focus = FocusNode();

  final TextEditingController _controllerReponse = TextEditingController();
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Gestion des radiobuttons pour la réforme
  void _reformeClicked(bool? value) => setState(() {
        reforme = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
        _nombreGenere =
            Nombre(_nombreGenere.value); // pour mettre à jour le nom
        _nomNombre = _nombreGenere.nom!;
      });

  // Gestion des radiobuttons pour le standard
  void _standardClicked(int? value) => setState(() {
        standardSelectionne = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
        _nombreGenere =
            Nombre(_nombreGenere.value); // pour mettre à jour le nom
        _nomNombre = _nombreGenere.nom!;
      });

  // Regénérer un nombre
  void _regenererNombre() {
    if (_formKey.currentState!.validate()) {
      if (double.parse(_controllerMin.text) >=
          double.parse(_controllerMax.text)) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Erreur"),
                  content: textMinSupAMax,
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, stringCompris),
                        child: const Text(stringCompris))
                  ],
                ));
      } else {
        setState(() {
          min = double.parse(_controllerMin.text);
          max = double.parse(_controllerMax.text);
          _nombreGenere = Nombre(
              ((Random().nextDouble() * (max - min)) + min).floorToDouble());
          _controllerReponse.text = "";
          _nomNombre = "";
          _toShowMauvaiseReponse = "";
          focus.requestFocus();
        });
      }
    }
  }

  // Gestion du bouton de validation
  void _validerClicked() {
    if (_formKey.currentState!.validate()) {
      // Ajoute 1 au nombre de recherches
      nombreDeNombresEntres++;

      // Montre une pub toutes les 5 recherches
      if (nombreDeNombresEntres % 8 == 0) {
        _interstitialAd!.show();
        loadAd();
      }

      /*
       * Certains claviers ajoutent des espaces à la fin des mots lors de
       * l'utilisation du correcteur automatique.
       * La méthode "trim" permet d'éviter que cette fonctionnalité ne crée
       * de problèmes
       */

      if (_nombreGenere.nom == _controllerReponse.text.toLowerCase().trim()) {
        setState(() {
          _toShowMauvaiseReponse = "";
          _regenererNombre();
        });
      } else {
        setState(() {
          _toShowMauvaiseReponse = "Mauvaise réponse";
          focus.requestFocus();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: paddingMarginGeneral,
              child: ContainerTitre(
                  title: stringRechercher,
                  childWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Nombre écrit en très gros
                      RichText(
                          text: TextSpan(
                              text: Nombre.montreAvecEspace(
                                  Nombre.removeDecimalZero(
                                      _nombreGenere.value)),
                              style: chaineTextStyleNombreGras)),
                      Padding(
                        padding: paddingMarginGeneral,
                        child: TextFormField(
                          controller: _controllerReponse,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00049f), width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00049f), width: 1.0)),
                              labelText: chaineLabelTextField,
                              labelStyle: textStyleNormal),
                          onFieldSubmitted: (value) {
                            _validerClicked();
                          },
                          focusNode: focus,
                        ),
                      ),
                      Text(
                        _toShowMauvaiseReponse,
                        style: chaineTextStyleMauvaiseReponse,
                      ),
                      Padding(
                          padding: paddingMarginGeneral,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: paddingEntreBoutons,
                                  child: BoutonElevated(chaineNomBoutonValider,
                                      () => _validerClicked())),
                              Padding(
                                  padding: paddingEntreBoutons,
                                  child: BoutonElevated(
                                      chaineNomBoutonChangerNombre,
                                      _regenererNombre))
                            ],
                          ))
                    ],
                  )),
            ),

            // Deuxième bloc
            Padding(
              padding: paddingMarginGeneral,
              child: ContainerTitre(
                  title: chaineLabelTextField,
                  childWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: paddingEntreLignes,
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    style: textStyleGras,
                                    text: stringNombreEnChiffres),
                                TextSpan(
                                    style: textStyleNormal,
                                    text: Nombre.montreAvecEspace(
                                        Nombre.removeDecimalZero(
                                            _nombreGenere.value)))
                              ]))),
                          Padding(
                              padding: paddingEntreLignes,
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    style: textStyleGras,
                                    text: stringNombreEnLettres),
                                TextSpan(
                                    style: textStyleNormal, text: _nomNombre)
                              ]))),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: paddingMarginGeneral,
                          child: BoutonElevated(
                              chaineNomBoutonAfficherReponse,
                              () => setState(() {
                                    _nomNombre = _nombreGenere.nom!;
                                  })),
                        ),
                      )
                    ],
                  )),
            ),

            BannerAdStateful(),

            // Troisième bloc
            Padding(
              padding: paddingMarginGeneral,
              child: ContainerTitre(
                title: stringParametresGeneraux,
                childWidget: Column(
                  children: [
                    // Minimum
                    Padding(
                      padding: paddingMarginGeneral,
                      child: TextFormFieldOnlyNumbers(
                          _controllerMin, stringNombreMin, min, (value) {
                        if (value == null || value.isEmpty) {
                          return messageEntrerUneValeur;
                        } else if (int.parse(value) < 0) {
                          return messageValeurMinZero;
                        }
                        return null;
                      }, onFieldSubmitted: (value) => _regenererNombre()),
                    ),

                    // Maximum
                    Padding(
                        padding: paddingMarginGeneral,
                        child: TextFormFieldOnlyNumbers(
                            _controllerMax, stringNombreMax, max, (value) {
                          if (value == null || value.isEmpty) {
                            return messageEntrerUneValeur;
                          } else if (int.parse(value) > nombreMax) {
                            return messageNombreMax;
                          }
                          return null;
                        }, onFieldSubmitted: (value) => _regenererNombre())),
                    BoutonElevated(
                        chaineNomBoutonRegenerer, () => _regenererNombre())
                  ],
                ),
              ),
            ),

            MyExpansionTile(
              const Text(
                "Paramètres supplémentaires",
                style: textStyleGras,
              ),
              [
                Padding(
                    padding: paddingMarginGeneral,
                    child: ContainerTitre(
                        title: titleReforme,
                        childWidget: Align(
                          alignment: Alignment.topLeft,
                          child: RadioGroup<bool?>(groupValue: reforme,
                      onChanged: (value) => _reformeClicked(value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyRadio<bool?>(titre: textSelonReforme, valeur: constanteReforme),
                          MyRadio<bool?>(titre: textSelonTradition, valeur: constanteTradition)
                        ],
                      ))
                        ))),
                Padding(
                  padding: paddingMarginGeneral,
                  child: ContainerTitre(
                      title: titleStandard,
                      childWidget: Align(
                        alignment: Alignment.topLeft,
                        child: RadioGroup<int?>(groupValue: standardSelectionne, onChanged: (value) => _standardClicked(value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyRadio<int?>(titre: textFrance, valeur: constanteFrance,),
                              MyRadio<int?>(titre: textBelgique, valeur: constanteBelgique,),
                              MyRadio<int?>(titre: textSuisse, valeur: constanteSuisse,)
                              ]
                          ))
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
