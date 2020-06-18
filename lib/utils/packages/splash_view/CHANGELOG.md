## [0.0.1] - 05-06-2020

* A basic splash screen view with logo, label and a progress indicator, these elements can be positioned anywhere on the screen.
* Splash view accepts a child view, that can be placed and positioned upon the default splash view layout.
/*
How to add splash screen?
Create a .dart file.
Use SplashView with parameters needed.
Pass child view if needed, that can be positioned above the default splash view.

SplashView(
      showProgressIndicator: false,
      splashProgressIndicator: SplashProgressIndicator(
        progressIndicatorPosition: Alignment.center,
      ),
      splashStyle: configureSplashStyle(),
      childPosition: Alignment.bottomCenter,
      child: Container(
        child: const Text('© 2020 Times Now. All Rights Reserved.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'roboto',
            )),
      ),
    );


configureSplashStyle()
This method return an instance SplashStyle which contain information's about the splash background image, logo, splash label etc.



Example:
SplashStyle configureSplashStyle() {
    return SplashStyle(
        splashType: SplashType.withBackgroundImage,
        splashScreenLabel: SplashScreenLogoLabel(
            label: 'Times Now'.toUpperCase(),
            position: LabelPosition.belowImageOrGif,
            labelStyle: TextStyle(
                color: Colors.white70,
                wordSpacing: 0,
                fontFamily: 'roboto',
                letterSpacing: 5,
                fontSize: 30,
                fontWeight: FontWeight.w900)),
        splashScreenImageAssets: SplashScreenLogo(
            splashScreenImageOrGifPath: "assets/images/splash_screen/logo.png",
            position: AssetImagePosition.center),
        splashScreenBackground: SplashScreenBackground(
            backgroundColor: Colors.blue,
            backgroundImage: 'assets/images/splash_screen/bg.jpg',
            gradient: SplashGradient(
                startColor: HexColor.fromHex('#7B1FA2'),
                endColor: HexColor.fromHex('#4A148C'))));
  }



SplashType is an Enum, which gives information to the UI that to choose the respective splash screen background. There are three types of splash screen background available.
enum SplashType {
  withBackgroundImage,
  withBackgroundColor,
  withBackgroundGradient
}

It is highly recommended to define Font family for all text widgets in splash screen

*/