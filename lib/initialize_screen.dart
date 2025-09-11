import 'package:flutter/material.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';

import 'initialization_helper.dart';

class InitializeScreen extends StatefulWidget {
  final Widget targetWidget;

  const InitializeScreen({super.key, required this.targetWidget});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  final _initializationHelper = InitializationHelper();

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: couleurFondGeneral,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: paddingMarginGeneral,
                child: Text(
                  "Chargement du formulaire RGPD si nécessaire...",
                  style: textStyleNormal,
                )),
            Padding(
              padding: paddingMarginGeneral,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          ],
        )),
      );

  Future<void> _initialize() async {
    final navigator = Navigator.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializationHelper.initialize();
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => widget.targetWidget),
      );
    });
  }
}
