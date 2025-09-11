import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constantes.dart';
import 'nombres.dart';

class TextFormFieldOnlyNumbers extends TextFormField {
  final TextEditingController textController;
  final String label;
  final double? value;
  final String? Function(String?)? validation;

  TextFormFieldOnlyNumbers(
      this.textController, this.label, this.value, this.validation,
      {super.key, super.onFieldSubmitted, super.focusNode})
      : super(
            style: textStyleNormal,
            controller: textController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: validation,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff00049f), width: 1.0)),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff00049f), width: 1.0)),
                labelText: label,
                labelStyle: textStyleNormal)) {
    if (value != null) textController.text = Nombre.removeDecimalZero(value!);
  }
}
