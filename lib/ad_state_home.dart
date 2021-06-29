/* import 'dart:io';


import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdStateHome {
  Future<InitializationStatus> initialization;
  AdStateHome(this.initialization);

  String get bannerAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '';

  AdListener get adListener => _adListener;

  AdListener _adListener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded. ${ad.adUnitId}'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened. ${ad.adUnitId}'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) {
      ad.dispose();
      print('Ad closed. ${ad.adUnitId}');
    },
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
}
 */
