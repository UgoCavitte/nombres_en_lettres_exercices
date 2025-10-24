import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';
import 'package:nombres_apprendre_exercices/data/map_nombres.dart';
import 'package:nombres_apprendre_exercices/types/bouton_elevated.dart';
import 'package:nombres_apprendre_exercices/types/container_titre.dart';

import '../data/variables.dart';
import '../types/my_expansion_tile.dart';
import '../types/nombres.dart';
import '../types/radio_bouton.dart';
import '../types/text_form_field_only_numbers.dart';

class Consulter extends StatefulWidget {
  const Consulter({super.key});

  @override
  State<StatefulWidget> createState() => _ConsulterState();
}

class _ConsulterState extends State<Consulter> {
  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2601867806541576/8215289215'
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

  // Gestion du textfield
  Nombre nombre = Nombre(0);
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focus = FocusNode();

  void _rechercheClicked(double value) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        nombre = Nombre(value);
        focus.requestFocus();
      });
    }
  }

  // Gestion des radiobuttons pour la réforme
  void _reformeClicked(bool? value) => setState(() {
        reforme = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
        _rechercheClicked(nombre.value);
      });

  // Gestion des radiobuttons pour le standard
  void _standardClicked(int? value) => setState(() {
        standardSelectionne = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
        _rechercheClicked(nombre.value);
      });

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: paddingMarginGeneral,
                  child: TextFormFieldOnlyNumbers(
                    controller,
                    stringNombre,
                    null,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return messageEntrerUneValeur;
                      } else if (int.parse(value) > nombreMax) {
                        return messageNombreMax;
                      } else if (int.parse(value) < 0) {
                        return messageValeurMinZero;
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      _rechercheClicked(double.parse(value));
                    },
                    focusNode: focus,
                  )),

              // Les deux boutons "Générer" et "Aléatoire"
              Padding(
                  padding: paddingMarginGeneral,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: paddingEntreBoutons,
                          child: BoutonElevated(textRechercher, () {
                            // Ajoute 1 au nombre de recherches
                            nombreDeRecherches++;

                            // Montre une pub toutes les 5 recherches
                            if (nombreDeRecherches % 5 == 0) {
                              _interstitialAd!.show();
                              loadAd();
                            }
                            _rechercheClicked(double.parse(
                                controller.text.toString().trim()));
                          })),
                      Padding(
                        padding: paddingEntreBoutons,
                        child: BoutonElevated(textGenererRandom, () {
                          // Ajoute 1 au nombre de recherches
                          nombreDeRecherches++;

                          // Montre une pub toutes les 5 recherches
                          if (nombreDeRecherches % 5 == 0) {
                            _interstitialAd!.show();
                            loadAd();
                          }

                          double rand = ((Random().nextDouble() *
                                      (nombreMax + nombreMin)) -
                                  nombreMin)
                              .floorToDouble();
                          controller.text = Nombre.removeDecimalZero(rand);
                          _rechercheClicked(rand);
                        }),
                      )
                    ],
                  )),
              Padding(
                  padding: paddingMarginGeneral,
                  child: Container(
                      decoration: decorationAutourParametreChercher,
                      padding: paddingMarginGeneral,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
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
                                              nombre.value)))
                                ]))),
                            Padding(
                                padding: paddingEntreLignes,
                                child: RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                      style: textStyleGras,
                                      text: stringNombreEnLettres),
                                  TextSpan(
                                      style: textStyleNormal, text: nombre.nom)
                                ])))
                          ],
                        ),
                      ))),

              MyExpansionTile(
                const Text(
                  "Paramètres supplémentaires",
                  style: textStyleGras,
                ),
                [
                  // Paramètre réforme
                  Padding(
                      padding: paddingMarginGeneral,
                      child: ContainerTitre(
                          title: titleReforme,
                          childWidget: Align(
                            alignment: Alignment.topLeft,
                            child:
                            RadioGroup<bool?>(groupValue: reforme,
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
                          child:

                          RadioGroup<int?>(groupValue: standardSelectionne, onChanged: (value) => _standardClicked(value),
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
          ))
    ]);
  }
}
