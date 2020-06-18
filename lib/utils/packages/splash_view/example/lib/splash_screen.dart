import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashView(
      showProgressIndicator: false,
      splashProgressIndicator: SplashProgressIndicator(
        progressIndicatorPosition: Alignment.topCenter,
      ),
      splashStyle: configureSplashStyle(),
      childPosition: Alignment.bottomCenter,
      child: Container(
        child: const Text('© 2020 Etihad. All Rights Reserved.',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'roboto',
            )),
      ),
    );
  }

  /// Return a [SplashStyle] object.
  /// Splash screen configurations are all set in this object.
  ///
  SplashStyle configureSplashStyle() {
    return SplashStyle(
        splashType: SplashType.withBackgroundColor,
        splashScreenLabel: SplashScreenLogoLabel(
            label: 'Show Times'.toUpperCase(),
            position: LabelPosition.belowImageOrGif,
            labelStyle: TextStyle(
                color: Colors.white70,
                wordSpacing: 0,
                fontFamily: 'roboto',
                letterSpacing: 5,
                fontSize: 30,
                fontWeight: FontWeight.w900)),
        splashScreenImageAssets: SplashScreenLogo(
            splashScreenImageOrGifPath: "assets/images/splash_screen/logo5.png",
            position: AssetImagePosition.center),
        splashScreenBackground: SplashScreenBackground(
            backgroundColor: Colors.blue,
            backgroundImage: 'assets/images/splash_screen/bg.jpg',
            gradient: SplashGradient(
                startColor: HexColor.fromHex('#7B1FA2'),
                endColor: HexColor.fromHex('#4A148C'))));
  }
}
