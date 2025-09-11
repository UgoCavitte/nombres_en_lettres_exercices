import 'package:flutter/material.dart';

class MyExpansionTile extends ExpansionTile {
  final Text titre;
  final List<Widget> enfants;

  const MyExpansionTile(this.titre, this.enfants, {super.key})
      : super(
            title: titre,
            children: enfants,
            iconColor: const Color(0xffff3131),
            shape: const ContinuousRectangleBorder(
                side: BorderSide(color: Color(0xff00049f), width: 1.0)),
            collapsedIconColor: const Color(0xffff3131));

  const MyExpansionTile.subtitle(this.titre, Text sousTitre, this.enfants,
      {super.key})
      : super(
            title: titre,
            subtitle: sousTitre,
            textColor: const Color(0xff00049f),
            collapsedTextColor: const Color(0xff00049f),
            children: enfants,
            iconColor: const Color(0xffff3131),
            shape: const ContinuousRectangleBorder(
                side: BorderSide(color: Color(0xff00049f), width: 1.0)),
            collapsedIconColor: const Color(0xffff3131));
}
