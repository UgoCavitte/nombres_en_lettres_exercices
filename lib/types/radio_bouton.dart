import 'package:flutter/material.dart';

class MyRadio<T> extends StatelessWidget {
  final Text titre;
  final dynamic valeur;

  const MyRadio({super.key, required this.titre, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: titre,
        leading: Radio<T>(value: valeur, activeColor: const Color(0xffff3131),),
    );
  }

}
