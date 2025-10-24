import 'package:flutter/material.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';

class ContainerTitre extends InputDecorator {
  final Widget childWidget;
  final String title;

  ContainerTitre({required this.title, required this.childWidget, super.key})
      : super(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff00049f), width: 1.0)),
                label: Text(title, style: textStyleTitledContainer)),
            child: childWidget);

  ContainerTitre.avecBordure(this.title, Color couleurBordure, this.childWidget,
      {super.key})
      : super(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: couleurBordure, width: 1.0)),
                label: Text(title, style: textStyleTitledContainer)),
            child: childWidget);
}
