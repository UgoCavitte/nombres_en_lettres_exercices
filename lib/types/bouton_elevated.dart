import 'package:flutter/material.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';

class BoutonElevated extends ElevatedButton {
  final Text text;
  final VoidCallback fonction;
  BoutonElevated(this.text, this.fonction, {super.key})
      : super(
            child: text,
            onPressed: fonction,
            style: ElevatedButton.styleFrom(
                backgroundColor: boutonsCouleurBackground,
                foregroundColor: boutonsCouleurText));
}
