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
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getAudioPlayer(provider),
              _getMainSettings(provider),
              _getAudioSettings(provider),
              // _getAdditionalSettings()
            ],
          ),
        
      ],
    );
  }

  Widget _getAudioPlayer (ProviderDevineAudio provider) {

    return Padding(padding: paddingMarginGeneral, child: ContainerTitre(title: "Deviner", childWidget:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 30, backgroundColor: couleurTexteGeneral, child: IconButton(onPressed: provider.playSound, icon: Icon(Icons.play_arrow, color: Colors.white,))),
          TextField(controller: provider.controller, keyboardType: TextInputType.number,),
          Padding(padding: paddingMarginGeneral, child: provider.labelAnswer,),
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

  Widget _getAudioSettings (ProviderDevineAudio provider) {
    return Padding(
      padding: paddingMarginGeneral,
      child: ContainerTitre(title: "Audio",
          childWidget: Column(
            children: [
              // Volume setter
              const Text("Volume", style: textStyleNormal,),
              Padding(padding: paddingMarginGeneral, child: Slider(value: provider.volume, activeColor: couleurTexteGeneral, onChanged: (v) => provider.setVolume(v)),),

              // Speed setter
              const Text("Vitesse", style: textStyleNormal,),
              Padding(padding: paddingMarginGeneral, child: Slider(value: provider.speedRate, activeColor: couleurTexteGeneral, onChanged: (v) => provider.setSpeechRate(v)),)
            ],
          )),
    );
  }

  Widget _getAdditionalSettings () {
    return Text("Will be done later");
  }

}

class ProviderDevineAudio with ChangeNotifier {

  late int currentNumber;
  Random random = Random();

  double volume = 1.0;
  double speedRate = 0.5;

  int min = nombreMin.round();
  int max = 99;

  FlutterTts flutterTts = FlutterTts();

  bool initialized = false;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerMin = TextEditingController(text: nombreMin.round().toString());
  TextEditingController controllerMax = TextEditingController(text: "99");
  RichText labelAnswer = RichText(text: TextSpan(text: ""));

  void initialize () async {
    await flutterTts.setLanguage("fr-FR");
    await flutterTts.setSpeechRate(speedRate);
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(1.0);

    regenerate();

    initialized = true;
  }

  void playSound () async {
    await flutterTts.speak(currentNumber.toString());
  }

  void checkAnswer () {
    int givenAnswer = int.parse(controller.text);

    // Bonne réponse
    if (givenAnswer == currentNumber) {
      labelAnswer = RichText(text: TextSpan(text: "Bonne réponse !", style: TextStyle(color: Colors.green)));
      controller.text = "";
      regenerate();
    }

    else {
      labelAnswer = RichText(text: TextSpan(text: "Mauvaise réponse !", style: TextStyle(color: Colors.red)));
    }

    notifyListeners();
  }

  void showAnswer () {
    labelAnswer = RichText(text: TextSpan(text: "La bonne réponse était : $currentNumber", style: TextStyle(color: couleurTexteGeneral)));
    notifyListeners();
  }

    void setVolume (double v) async {
    volume = v;
    await flutterTts.setVolume(volume);
    notifyListeners();
  }

  void setSpeechRate (double v) async {
    speedRate = v;
    await flutterTts.setSpeechRate(v);
    notifyListeners();
  }

  void regenerate () {
    min = int.parse(controllerMin.text);
    max = int.parse(controllerMax.text);
    currentNumber = random.nextInt(max - min) + min;
  }

}
