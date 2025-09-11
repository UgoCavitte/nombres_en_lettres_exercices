import 'package:nombres_apprendre_exercices/data/constantes.dart';

import '../data/map_nombres.dart';
import '../data/variables.dart';

class Nombre {
  final double _value;
  String? _nom = "default";

  Nombre(this._value) {
    _nom = _genererNom(value);
  }

  double get value => _value;

  String? get nom => _nom;

  // Enlève le .0 affiché pour les double
  static String removeDecimalZero(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String montreAvecEspace(String nombre) {
    return nombre.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
  }

  static String? _genererNom(double value) {
    String toReturn;

    if (mapNombres[value] != null) {
      toReturn = mapNombres[value]!;
    } else {
      switch (value) {
        case <= 69:
          toReturn =
              "${mapNombres[((value / 10).truncate() * 10)]}-${mapNombres[value - ((value / 10).truncate() * 10)]}";

        // De 72 à 79
        case <= 79:
          if (standardSelectionne == constanteFrance) {
            toReturn = "${mapNombres[60]}-${mapNombres[value - 60]}";
          } else {
            toReturn =
                "${mapNombres[((value / 10).truncate() * 10)]}-${mapNombres[value - ((value / 10).truncate() * 10)]}";
          }
        // De 82 à 89
        // Pas possible de regrouper 80 et 90 à cause des autres standards
        case <= 89:
          if (standardSelectionne == constanteSuisse) {
            toReturn = "huitante-${mapNombres[value - 80]}";
          } else {
            toReturn = "quatre-vingt-${mapNombres[value - 80]}";
          }

        // De 92 à 99
        case <= 99:
          if (standardSelectionne == constanteFrance) {
            toReturn = "quatre-vingt-${mapNombres[value - 80]}";
          } else {
            toReturn = "nonante-${mapNombres[value - 90]}";
          }

        // De 101 à 199
        case <= 199:
          if (reforme == true) {
            toReturn = "cent-${_genererNom(value - 100)}";
          } else {
            toReturn = "cent ${_genererNom(value - 100)}";
          }

        // S'il faut mettre un S à la fin de "cent"
        case == 200 ||
              == 300 ||
              == 400 ||
              == 500 ||
              == 600 ||
              == 700 ||
              == 800 ||
              == 900:
          if (reforme == true) {
            toReturn = "${mapNombres[value / 100]}-cents";
          } else {
            toReturn = "${mapNombres[value / 100]} cents";
          }

        // De 201 à 999 en excluant les centaines rondes
        case <= 999:
          if (reforme == true) {
            toReturn =
                "${mapNombres[(value / 100).truncate()]}-cent-${_genererNom(value - ((value / 100).truncate() * 100))}";
          } else {
            toReturn =
                "${mapNombres[(value / 100).truncate()]} cent ${_genererNom(value - ((value / 100).truncate() * 100))}";
          }

        // de 1000 à 1999
        case <= 1999:
          if (reforme == true) {
            toReturn =
                "mille-${_genererNom(value - ((value / 1000).truncate() * 1000))}";
          } else {
            toReturn =
                "mille ${_genererNom(value - ((value / 1000).truncate() * 1000))}";
          }

        // 2000 ou plus
        case <= 999999:

          /*
           * Il faut faire attention à enlever le S à 80 pour les nombres
           * compris entre 80 000 et 80 999.
           * Le système de base mettrait un S à la fin de 80 pour ces
           * nombres-là.
           * La solution la plus simple, à mon avis, était de traiter ces
           * nombres à part.
           * Il faut également exclure la variante suisse qui n'a pas ce
           * problème grâce au mot "huitante".
           */
          if (value >= 80000 &&
              value <= 80999 &&
              standardSelectionne != constanteSuisse) {
            if (reforme == true) {
              toReturn = "quatre-vingt-mille-${_genererNom(value - 80000)}";
            } else {
              toReturn = "quatre-vingt mille ${_genererNom(value - 80000)}";
            }
          } else {
            if (reforme == true) {
              toReturn =
                  "${_genererNom((value / 1000).floorToDouble())}-mille-${_genererNom(value - ((value / 1000).truncate() * 1000))}";
            } else {
              toReturn =
                  "${_genererNom((value / 1000).floorToDouble())} mille ${_genererNom(value - ((value / 1000).truncate() * 1000))}";
            }
          }

        // 1 million à 2
        case <= 1999999:
          if (reforme == true) {
            toReturn = "un-million-${_genererNom(value - 1000000)}";
          } else {
            toReturn = "un million ${_genererNom(value - 1000000)}";
          }

        // 2 à 999 millions
        case <= 999999999:
          if (reforme == true) {
            toReturn =
                "${_genererNom((value / 1000000).floorToDouble())}-millions-${_genererNom(value - ((value / 1000000).truncate() * 1000000))}";
          } else {
            toReturn =
                "${_genererNom((value / 1000000).floorToDouble())} millions ${_genererNom(value - ((value / 1000000).truncate() * 1000000))}";
          }

        // 1 milliard à 2
        case <= 1999999999:
          if (reforme == true) {
            toReturn = "un-milliard-${_genererNom(value - 1000000000)}";
          } else {
            toReturn = "un milliard ${_genererNom(value - 1000000000)}";
          }

        // 2 à 999 milliards
        case <= 999999999999:
          if (reforme == true) {
            toReturn =
                "${_genererNom((value / 1000000000).floorToDouble())}-milliards-${_genererNom(value - ((value / 1000000000).truncate() * 1000000000))}";
          } else {
            toReturn =
                "${_genererNom((value / 1000000000).floorToDouble())} milliards ${_genererNom(value - ((value / 1000000000).truncate() * 1000000000))}";
          }

        default:
          return "oups";
      }
    }

    /*
     * Permet de :
     * 1. Faire en sorte qu'il n'ajoute pas "zéro" quand le nombre est rond
     * 2. Les problèmes de S à la fin de cent pour les grands nombres
     * 3. Mais n'enlève pas le S si le mot "cents" précède "millions"
     */

    // Enlève les "zéro" qui n'ont pas à être là
    if (toReturn.contains("zéro") && toReturn.length > 5) {
      if (reforme!) {
        toReturn = toReturn.replaceAll("-zéro", "");
      } else {
        toReturn = toReturn.replaceAll(" zéro", "");
      }
    }

    if (toReturn.contains("cents")) {
      String debut = "";
      String fin = "";

      // Enlève le "cents" à la fin du nombre, puisqu'il peut prendre un S
      if (toReturn.endsWith("cents")) {
        toReturn = toReturn.substring(0, toReturn.length - 5);
        fin = "cents";
      }

      // Enlève le début s'il contient "millions", "milliards"
      if (toReturn.contains("millions")) {
        int indexDebut = toReturn.indexOf("millions") + 8;
        debut = toReturn.substring(0, indexDebut);
        toReturn = toReturn.substring(indexDebut, toReturn.length);
      } else if (toReturn.contains("milliards")) {
        int indexDebut = toReturn.indexOf("milliards") + 9;
        debut = toReturn.substring(0, indexDebut);
        toReturn = toReturn.substring(indexDebut, toReturn.length);
      }

      // Enlève tous les S des "cents" restants
      toReturn = toReturn.replaceAll("cents", "cent");

      // Remet ce qui a été supprimé au début et à la fin du nombre
      toReturn = "$debut$toReturn$fin";
    }

    return toReturn;
  }
}
