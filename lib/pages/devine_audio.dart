import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';
import 'package:nombres_apprendre_exercices/types/bouton_elevated.dart';
import 'package:nombres_apprendre_exercices/types/container_titre.dart';
import 'package:provider/provider.dart';

class DevineAudio extends StatelessWidget {
  const DevineAudio({super.key});

  @override
  Widget build(BuildContext context) {

    ProviderDevineAudio provider = context.watch<ProviderDevineAudio>();

    if (!provider.initialized) {
      provider.initialize();
    }

    return ListView(
      children: [
        Padding(
          padding: paddingMarginGeneral,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getAudioPlayer(provider),
              _getMainSettings(provider),
              _getAdditionalSettings()
            ],
          ),
        )
      ],
    );
  }

  Widget _getAudioPlayer (ProviderDevineAudio provider) {

    return Padding(padding: paddingMarginGeneral, child: ContainerTitre(title: "Deviner", childWidget:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: provider.playSound, icon: Icon(Icons.play_arrow_rounded)),
          TextField(controller: provider.controller, keyboardType: TextInputType.number,),
          Text(provider.labelAnswer),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: paddingEntreBoutons, child: BoutonElevated(chaineNomBoutonValider, provider.checkAnswer),),
              Padding(padding: paddingEntreBoutons, child: BoutonElevated(chaineNomBoutonAfficherReponse, provider.showAnswer),)
            ],)
        ],
      ),)
    
    );      
  }

  Widget _getMainSettings (ProviderDevineAudio provider) {
    return Padding(
              padding: paddingMarginGeneral,
              child: ContainerTitre(
                title: stringParametresGeneraux,
                childWidget: Column(
                  children: [
                    // Minimum
                    Padding(
                      padding: paddingMarginGeneral,
                      child: TextField(controller: provider.controllerMin, keyboardType: TextInputType.number,)
                    ),

                    // Maximum
                    Padding(
                      padding: paddingMarginGeneral,
                      child: TextField(controller: provider.controllerMax, keyboardType: TextInputType.number,)
                    ),

                        // Bouton
                    BoutonElevated(
                        chaineNomBoutonRegenerer, provider.regenerate)
                  ],
                ),
              ),
            );
  }

  Widget _getAdditionalSettings () {
    return Text("Will be done later");
  }

}

class ProviderDevineAudio with ChangeNotifier {

  late int currentNumber;
  Random random = Random();

  int min = nombreMin.round();
  int max = 99;

  FlutterTts flutterTts = FlutterTts();

  bool initialized = false;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerMin = TextEditingController(text: nombreMin.round().toString());
  TextEditingController controllerMax = TextEditingController(text: "99");
  String labelAnswer = "";

  void initialize () async {
    await flutterTts.setLanguage("fr-FR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    regenerate();
  }

  void playSound () async {
    await flutterTts.speak(currentNumber.toString());
  }

  void checkAnswer () {
    //
  }

  void showAnswer () {
    //
  }

  void regenerate () {
    min = int.parse(controllerMin.text);
    max = int.parse(controllerMax.text);
    currentNumber = random.nextInt(max - min) + min;
  }

}
