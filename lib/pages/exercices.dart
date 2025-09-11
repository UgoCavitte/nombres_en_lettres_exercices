import 'package:flutter/material.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';
import 'package:nombres_apprendre_exercices/pages/exercice_lance.dart';
import 'package:nombres_apprendre_exercices/types/container_titre.dart';

import '../data/map_nombres.dart';
import '../data/variables.dart';
import '../types/bouton_elevated.dart';
import '../types/my_expansion_tile.dart';
import '../types/radio_bouton.dart';
import '../types/text_form_field_only_numbers.dart';

class Exercices extends StatefulWidget {
  const Exercices({super.key});

  @override
  State<StatefulWidget> createState() => _ExercicesState();
}

class _ExercicesState extends State<Exercices> {
  final TextEditingController _controllerMin = TextEditingController();
  final TextEditingController _controllerMax = TextEditingController();
  final TextEditingController _controllerReps = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Gestion des radiobuttons pour la réforme
  void _reformeClicked(bool? value) => setState(() {
        reforme = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
      });

  // Gestion des radiobuttons pour le standard
  void _standardClicked(int? value) => setState(() {
        standardSelectionne = value;
        ChangementMap.changementMap(reforme, standardSelectionne);
      });

  // Lancer l'exo ou pas
  void _lancerClicked() {
    if (_formKey.currentState!.validate()) {
      if (int.parse(_controllerMin.text) >= int.parse(_controllerMax.text)) {
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExerciceLance(
                    double.parse(_controllerMin.text),
                    double.parse(_controllerMax.text),
                    int.parse(_controllerReps.text))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
          padding: paddingMarginGeneral,
          child: ContainerTitre(
            stringParametresGeneraux,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: paddingMarginGeneral,
                    child: TextFormFieldOnlyNumbers(
                        _controllerMin, stringNombreMin, nombreMin, (value) {
                      if (value == null || value.isEmpty) {
                        return messageEntrerUneValeur;
                      } else if (int.parse(value) < nombreMin) {
                        return messageValeurMinZero;
                      }
                      return null;
                    }),
                  ),
                  Padding(
                      padding: paddingMarginGeneral,
                      child: TextFormFieldOnlyNumbers(
                          _controllerMax, stringNombreMax, 99, (value) {
                        if (value == null || value.isEmpty) {
                          return messageEntrerUneValeur;
                        } else if (int.parse(value) > nombreMax) {
                          return messageNombreMax;
                        }
                        return null;
                      })),
                  Padding(
                      padding: paddingMarginGeneral,
                      child: TextFormFieldOnlyNumbers(
                          _controllerReps, stringReps, 10, (value) {
                        if (value == null || value.isEmpty) {
                          return messageEntrerUneValeur;
                        } else if (int.parse(value) <= 0) {
                          return messageEntrerUneValeurSup;
                        } else if (int.parse(value) > repMax) {
                          return messageRepMaxDepasse;
                        }
                        return null;
                      })),
                ],
              ),
            ),
          )),
      MyExpansionTile(
        const Text(
          "Paramètres supplémentaires",
          style: textStyleGras,
        ),
        [
          Padding(
              padding: paddingMarginGeneral,
              child: ContainerTitre(
                  titleReforme,
                  Align(
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
                titleStandard,
                Align(
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
      ),
      Padding(
          padding: paddingMarginGeneral,
          child: BoutonElevated(textLancerExo, () => _lancerClicked()))
    ]);
  }
}

/*
 * Nombre minimum
 * Nombre maximum
 * Nombre de nombres
 * Réforme
 * Standard
 * Valider
 */
