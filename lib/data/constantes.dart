import 'package:flutter/material.dart';

import '../types/nombres.dart';

// Couleurs de l'application
const Color couleurFondGeneral = Colors.white;

// Nombres
const double nombreMin = 0;
const double nombreMax = 999999999999; // 999 milliards
const int repMax = 50;
const EdgeInsetsDirectional paddingEntreLignes =
    EdgeInsetsDirectional.only(top: 15, bottom: 15);
const EdgeInsets paddingMarginGeneral = EdgeInsets.all(15);
const EdgeInsetsDirectional paddingEntreBoutons =
    EdgeInsetsDirectional.only(start: 15, end: 15);

// Texte string
const String stringCompris = "Compris";

const String stringParametresGeneraux = "Paramètres généraux";
const String stringNombre = "Nombre";
const String stringNombreMin = "Minimum";
const String stringNombreMax = "Maximum";
const String stringReps = "Nombre de nombres";
const String stringRechercher = "Générer";
const Text textRechercher = Text(stringRechercher);
const Text textGenererRandom = Text("Aléatoire");
const Text textLancerExo = Text("Lancer l'exercice");
const Text textMinSupAMax =
    Text("La valeur minimale doit être inférieure à la valeur maximale");

const Text textAppBarTitreExercice = Text("Exercice");
const Text textTerminerExo = Text("Terminer");
const String stringLeChampEstVide = "Le champ est vide";
const Text textTerminerLireReponses = Text("Quitter");

const String messageRepMaxDepasse =
    "Le nombre maximum de répétitions est de $repMax";
const String messageEntrerUneValeurSup =
    "Veuillez entrer une valeur supérieure";
const String messageEntrerUneValeur = "Veuillez entrer une valeur";
const String messageValeurMinZero = "La valeur minimale est de 0";
String messageNombreMax =
    "La valeur maximale est de ${Nombre.montreAvecEspace(Nombre.removeDecimalZero(nombreMax))}";

const String stringNombreEnChiffres = "Nombre en chiffres : ";
const String stringNombreEnLettres = "Nombre en lettres : ";

const String titleReforme = "Réforme de 1990";
const Text textSelonReforme =
    Text("Orthographe réformée", style: textStyleNormal);
const constanteReforme = true;
const Text textSelonTradition =
    Text("Orthographe traditionnelle", style: textStyleNormal);
const constanteTradition = false;

const String titleStandard = "Standard";
const Text textFrance = Text("France", style: textStyleNormal);
const constanteFrance = 0;
const Text textBelgique = Text("Belgique", style: textStyleNormal);
const constanteBelgique = 1;
const Text textSuisse = Text("Suisse", style: textStyleNormal);
const constanteSuisse = 2;

// Border
Decoration decorationAutourParametreChercher =
    BoxDecoration(border: Border.all(color: const Color(0xff00049f)));
Color couleurBordureBonneReponse = Colors.green;
Color couleurBordureMauvaiseReponse = Colors.red;

// Texte style
const Color couleurTexteGeneral = Color(0xff00049f);
const TextStyle textStyleGras = TextStyle(
    color: couleurTexteGeneral, fontWeight: FontWeight.bold, fontSize: 16);
const TextStyle textStyleNormal = TextStyle(
    color: couleurTexteGeneral, fontWeight: FontWeight.normal, fontSize: 16);
const TextStyle textStyleTitledContainer =
    TextStyle(color: couleurTexteGeneral, fontSize: 20);

// AppBar générale
const Text appBarTitre = Text("Les nombres français");
const Color appBarCouleurText = Colors.white;
const Color appBarCouleurFond = Color(0xff00049f);
const Icon iconeParametres = Icon(Icons.settings);

// Tabs et BottomNavigationBar
const String tabsNomConsulter = "Chercher";
const String tabsNomChaine = "Enchaîner";
const String tabsNomExercices = "Listes";
const String tabsNomExplications = "Règles";

const Icon tabsIconConsulter = Icon(Icons.search);
const Icon tabsIconChaine = Icon(Icons.replay);
const Icon tabsIconExercices = Icon(Icons.format_list_bulleted);
const Icon tabsIconExplications = Icon(Icons.format_align_left);

const Color tabsBarCouleurFond = Color(0xff00049f);
const Color tabsBarCouleurItemSelected = Colors.yellow;
const Color tabsBarCouleurItemNotSelected = Colors.white;

// Boutons
const Color boutonsCouleurBackground = Color(0xff00049f);
const Color boutonsCouleurText = Colors.white;

// Texte menu principal
RichText textMenuPrincipalChercher = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "Le menu \"$tabsNomConsulter\" vous permet d'obtenir l'orthographe d'un nombre en le renseignant.\n"),
  TextSpan(
      text:
          "\nAdmettons que vous vouliez vérifier comment s'écrit le nombre 3592. Vous sélectionnez l'onglet \"$tabsNomConsulter\", puis vous entrez le nombre 3592 dans le premier champ, et enfin vous cliquez sur le bouton \"$stringRechercher\".\n"),
  TextSpan(text: "\nVous pouvez également changer certains paramètres :\n"),
  TextSpan(
      text: "- l'application ou non de la réforme orthographique de 1990 ;\n"),
  TextSpan(text: "- le standard (France, Belgique ou Suisse).")
]));

RichText textMenuPrincipalChaine = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "Le menu \"$tabsNomChaine\" vous permet de générer une quantité indéfinie de nombres aléatoires, et de les nommer ou non à l'écrit.\n"),
  TextSpan(
      text:
          "\nVous avez également la possibilité de changer les paramètres de générations :\n"),
  TextSpan(text: "- votre fourchette (minimum et maximum) ;\n"),
  TextSpan(text: "- la nécessité d'entrer ou non l'orthographe du nombre ;\n"),
  TextSpan(text: "- les paramètres normatifs (réforme, standard).")
]));

RichText textMenuPrincipalListes = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "Le menu \"$tabsNomExercices\" vous permet de générer des listes de nombres à orthographier. L'application donne ensuite une note à vos réponses.\n"),
  TextSpan(
      text:
          "\nVous avez ici aussi la possibilité de changer certains paramètres :\n"),
  TextSpan(text: "- votre fourchette (minimum et maximum) ;\n"),
  TextSpan(
      text:
          "- la quantité de nombres à inclure dans la liste (en d'autres termes, le nombre de questions) ;\n"),
  TextSpan(text: "- les paramètres normatifs (réforme, standard).")
]));

const String stringAProposDeLAuteur = "À propos de l'auteur";

RichText textAProposDeLAuteur = RichText(
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(text: "Auteur : Ugo CAVITTE\n"),
  TextSpan(text: "Telegram : @francaisugo"),
]));

const String stringMenuPrincipalConstantes = "Constantes de l'application";

RichText textMenuPrincipalConstantes = RichText(
    // textAlign: TextAlign.justify,
    text:
        TextSpan(style: const TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "- nombre minimal : ${Nombre.montreAvecEspace(Nombre.removeDecimalZero(nombreMin))}\n"),
  TextSpan(
      text:
          "- nombre maximal : ${Nombre.montreAvecEspace(Nombre.removeDecimalZero(nombreMax))}\n"),
  const TextSpan(
      text:
          "- nombre maximal de répétitions (Onglet \"$tabsNomExercices\") : $repMax")
]));

// Menu Enchaîner
const TextStyle chaineTextStyleNombreGras = TextStyle(
    color: couleurTexteGeneral, fontWeight: FontWeight.bold, fontSize: 48);
const String chaineLabelTextField = "Réponse";
const Text chaineNomBoutonValider = Text("Valider");
const Text chaineNomBoutonChangerNombre = Text("Changer");
const Text chaineNomBoutonAfficherReponse = Text("Afficher la réponse");
const TextStyle chaineTextStyleMauvaiseReponse = TextStyle(color: Colors.red);
const Text chaineNomBoutonRegenerer =
    Text("Regénérer selon la nouvelle fourchette");

// Règles
const Text textNomRegleEt = Text("Et");
const Text textSousTitreRegleEt =
    Text("Quand mettre \"et\" et quand l'omettre ?");

RichText textRegleEt = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "\"Et\" se place entre une dizaine (\"vingt\", \"trente\"...) et le chiffre \"un\".\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: "Vingt (20), vingt-et-un (21) MAIS vingt-deux (22)\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: "Trente (30), trente-et-un (31) MAIS trente-deux (32)\n"),
  TextSpan(
      text:
          "\nAttention, \"et\" ne concerne ni \"quatre-vingts\", ni \"quatre-vingt-dix\".\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text:
          "Soixante-et-onze (71) MAIS quatre-vingt-un (81), quatre-vingt-onze (91)"),
]));

const Text textNomRegleVingtCent = Text("Vingt, cent");
const Text textSousTitreRegleVingtCent =
    Text("Quand mettre un S à la fin de \"vingt\" et de \"cent\" ?");

RichText textRegleVingtCent = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "\"Vingt\" et \"cent\" prennent un S au pluriel seulement s'ils ne sont pas suivis d'un autre numéral. \"Vingt\" prend donc un S seulement dans \"quatre-vingts\".\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text:
          "Quatre-vingts (80) MAIS quatre-vingt-un (81), quatre-vingt-quinze (95)\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text:
          "Deux-cents (200) MAIS deux-cent-un (201), deux-cent-cinquante-six (256)\n"),
  TextSpan(
      text:
          "\nAttention, \"million\", \"milliard\", etc. ne sont pas des adjectifs, mais des noms. La règle ne les concerne pas.\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text:
          "Quatre-vingt-mille (80 000) MAIS quatre-vingts-millions (80 000 000)"),
]));

const Text textNomRegleMille = Text("Mille");
const Text textSousTitreRegleMille = Text("Le pluriel de \"mille\"");

RichText textRegleMille = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(text: "\"Mille\" ne prend jamais de S.\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: "Mille (1000), deux-mille (2000), trois-mille (3000)")
]));

const Text textNomRegleTraitReforme =
    Text("Trait d'union depuis la réforme de 1990");
const Text textSousTitreRegleTraitReforme =
    Text("Quand mettre le trait d'union selon l'orthographe réformée ?");

RichText textRegleTraitReforme = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "La réforme orthographique de 1990 a simplifié l'emploi du trait d'union (-) en permettant de le mettre entre chaque mot d'un nombre composé. Il existe ainsi deux orthographes possibles pour les nombres composés : l'orthographe traditionnelle et l'orthographe réformée.\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: "Quatre-vingt-cinq-mille-six-cent-vingt-et-un (85 621)")
]));

const Text textNomRegleTraitTradition =
    Text("Trait d'union selon l'orthographe traditionnelle");
const Text textSousTitreRegleTraitTradition =
    Text("Quand mettre le trait selon l'orthographe traditionnelle ?");

RichText textRegleTraitTradition = RichText(
    // textAlign: TextAlign.justify,
    text:
        const TextSpan(style: TextStyle(color: couleurTexteGeneral), children: [
  TextSpan(
      text:
          "Avant la réforme orthographique de 1990, le trait d'union se mettait uniquement pour les parties d'un nombre composé inférieures à 100.\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text:
          "Quatre-vingt-dix millions six cent soixante-dix-neuf mille trois cent vingt-sept (90 679 327)\n"),
  TextSpan(
      text: "\nAttention, le trait d'union ne s'emploie pas avec \"et\".\n"),
  TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: "Vingt-deux (22) MAIS vingt et un (21)\n"),
  TextSpan(
      text:
          "\nGardez bien en tête que ces règles ne sont pas nécessaires à apprendre, puisque la réforme orthographique de 1990 permet les deux orthographes : la traditionnelle et la réformée.")
]));

// Paramètres
RichText textParametresEcrivezMoi = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(children: [
    TextSpan(
        style: TextStyle(color: Color(0xff00049f)),
        text:
            "Si vous rencontrez le moindre problème, n'hésitez pas à me contacter pour que je puisse le corriger le plus rapidement possible.")
  ]),
);

RichText textParametresContacts = RichText(
  textAlign: TextAlign.center,
  text: const TextSpan(children: [
    TextSpan(
        style: TextStyle(color: Color(0xff00049f)),
        text: "Telegram : @ucavitte / @francaisugo\n"),
    TextSpan(
        style: TextStyle(color: Color(0xff00049f)),
        text: "Mail : contact@ugocavitte.com")
  ]),
);
