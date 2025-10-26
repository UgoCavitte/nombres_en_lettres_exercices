import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


const adUnitId = 'ca-app-pub-2601867806541576/8322066581';
const AdSize bannerSize = AdSize(width: 320, height: 50);

class BannerAdStateful extends StatefulWidget {
  const BannerAdStateful({super.key});

  @override
  State<StatefulWidget> createState() => _StateBannerAdStateful();
  
}

class _StateBannerAdStateful extends State<BannerAdStateful> {

  late BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoaded || bannerAd == null) {
      isLoaded = false;
      fetch();
      return Center(child: Text("Loadind ad..."),);
    }

    return SizedBox(
              width: bannerAd!.size.width.toDouble(),
              height: bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            );
  }

  void fetch () {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: bannerSize,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            isLoaded = true;
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
    
    setState(() {
      isLoaded = true;
    });
  }
  
}
