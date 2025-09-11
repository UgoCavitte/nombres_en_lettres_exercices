import 'package:nombres_apprendre_exercices/data/constantes.dart';

Map<int, String> mapNombres = {
  0: "zéro",
  1: "un",
  2: "deux",
  3: "trois",
  4: "quatre",
  5: "cinq",
  6: "six",
  7: "sept",
  8: "huit",
  9: "neuf",
  10: "dix",
  11: "onze",
  12: "douze",
  13: "treize",
  14: "quatorze",
  15: "quinze",
  16: "seize",
  17: "dix-sept",
  18: "dix-huit",
  19: "dix-neuf",
  20: "vingt",
  21: "vingt-et-un",
  30: "trente",
  31: "trente-et-un",
  40: "quarante",
  41: "quarante-et-un",
  50: "cinquante",
  51: "cinquante-et-un",
  60: "soixante",
  61: "soixante-et-un",
  70: "soixante-dix",
  71: "soixante-et-onze",
  80: "quatre-vingts",
  81: "quatre-vingt-un",
  90: "quatre-vingt-dix",
  91: "quatre-vingt-onze",
  100: "cent"
};

class ChangementMap {
  static void changementMap(bool? changement, int? standard) {
    if (changement == true) {
      if (standard == constanteFrance) {
        mapNombres[21] = "vingt-et-un";
        mapNombres[31] = "trente-et-un";
        mapNombres[41] = "quarante-et-un";
        mapNombres[51] = "cinquante-et-un";
        mapNombres[61] = "soixante-et-un";
        mapNombres[70] = "soixante-dix";
        mapNombres[71] = "soixante-et-onze";
        mapNombres[80] = "quatre-vingts";
        mapNombres[81] = "quatre-vingt-un";
        mapNombres[91] = "quatre-vingt-onze";
      } else if (standard == constanteBelgique) {
        mapNombres[21] = "vingt-et-un";
        mapNombres[31] = "trente-et-un";
        mapNombres[41] = "quarante-et-un";
        mapNombres[51] = "cinquante-et-un";
        mapNombres[61] = "soixante-et-un";
        mapNombres[70] = "septante";
        mapNombres[71] = "septante-et-un";
        mapNombres[80] = "quatre-vingts";
        mapNombres[81] = "quatre-vingt-un";
        mapNombres[90] = "nonante";
        mapNombres[91] = "nonante-et-un";
      } else {
        mapNombres[21] = "vingt-et-un";
        mapNombres[31] = "trente-et-un";
        mapNombres[41] = "quarante-et-un";
        mapNombres[51] = "cinquante-et-un";
        mapNombres[61] = "soixante-et-un";
        mapNombres[70] = "septante";
        mapNombres[71] = "septante-et-un";
        mapNombres[80] = "huitante";
        mapNombres[81] = "huitante-et-un";
        mapNombres[90] = "nonante";
        mapNombres[91] = "nonante-et-un";
      }
    } else {
      if (standard == constanteFrance) {
        mapNombres[21] = "vingt et un";
        mapNombres[31] = "trente et un";
        mapNombres[41] = "quarante et un";
        mapNombres[51] = "cinquante et un";
        mapNombres[61] = "soixante et un";
        mapNombres[70] = "soixante-dix";
        mapNombres[71] = "soixante et onze";
        mapNombres[80] = "quatre-vingts";
        mapNombres[81] = "quatre-vingt-un";
        mapNombres[91] = "quatre-vingt-onze";
      } else if (standard == constanteBelgique) {
        mapNombres[21] = "vingt et un";
        mapNombres[31] = "trente et un";
        mapNombres[41] = "quarante et un";
        mapNombres[51] = "cinquante et un";
        mapNombres[61] = "soixante et un";
        mapNombres[70] = "septante";
        mapNombres[71] = "septante et un";
        mapNombres[80] = "quatre-vingts";
        mapNombres[81] = "quatre-vingt-un";
        mapNombres[90] = "nonante";
        mapNombres[91] = "nonante et un";
      } else {
        mapNombres[21] = "vingt et un";
        mapNombres[31] = "trente et un";
        mapNombres[41] = "quarante et un";
        mapNombres[51] = "cinquante et un";
        mapNombres[61] = "soixante et un";
        mapNombres[70] = "septante";
        mapNombres[71] = "septante et un";
        mapNombres[80] = "huitante";
        mapNombres[81] = "huitante et un";
        mapNombres[90] = "nonante";
        mapNombres[91] = "nonante et un";
      }
    }
  }
}
