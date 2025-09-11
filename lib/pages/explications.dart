import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';

import '../types/my_expansion_tile.dart';

class Explications extends StatefulWidget {
  const Explications({super.key});

  @override
  State<StatefulWidget> createState() => _ExplicationsState();
}

class _ExplicationsState extends State<Explications> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  final adUnitId = 'ca-app-pub-2601867806541576/8322066581';
  final AdSize bannerSize = const AdSize(width: 320, height: 50);

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: bannerSize,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    List<MyExpansionTile> page = [
      MyExpansionTile.subtitle(
        textNomRegleEt,
        textSousTitreRegleEt,
        [
          ListTile(
            title: textRegleEt,
          )
        ],
      ),
      MyExpansionTile.subtitle(
        textNomRegleVingtCent,
        textSousTitreRegleVingtCent,
        [
          ListTile(
            title: textRegleVingtCent,
          )
        ],
      ),
      MyExpansionTile.subtitle(
        textNomRegleMille,
        textSousTitreRegleMille,
        [ListTile(title: textRegleMille)],
      ),
      MyExpansionTile.subtitle(
        textNomRegleTraitReforme,
        textSousTitreRegleTraitReforme,
        [
          ListTile(
            title: textRegleTraitReforme,
          )
        ],
      ),
      MyExpansionTile.subtitle(
        textNomRegleTraitTradition,
        textSousTitreRegleTraitTradition,
        [
          ListTile(
            title: textRegleTraitTradition,
          )
        ],
      ),
    ];

    return _isLoaded
        ? ListView(
            children: [
              ...page,
              Padding(
                  padding: paddingMarginGeneral,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
                  ))
            ],
          )
        : ListView(
            children: [...page],
          );
  }
}
