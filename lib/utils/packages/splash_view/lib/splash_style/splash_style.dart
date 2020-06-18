import 'package:flutter/material.dart';

import 'model/splash_background.dart';
import 'model/splash_image_asset.dart';
import 'model/splash_label.dart';

/// Here the Splash Screen styles are defined with a default value.
/// Modifing these elemets will reflect the Splash Screen UI automatically.
class SplashStyle {
  SplashType splashType;
  SplashScreenLogo splashScreenImageAssets;
  SplashScreenLogoLabel splashScreenLabel;
  SplashScreenBackground splashScreenBackground;

  SplashStyle(
      {@required SplashType splashType,
      SplashScreenLogo splashScreenImageAssets,
      SplashScreenLogoLabel splashScreenLabel,
      SplashScreenBackground splashScreenBackground}) {
    this.splashType = splashType ?? SplashType.withBackgroundColor;
    this.splashScreenImageAssets = splashScreenImageAssets;
    this.splashScreenLabel = splashScreenLabel;
    this.splashScreenBackground =
        splashScreenBackground ?? SplashScreenBackground();
  }

  /// Checks whether the image/gif is empty
  ///
  bool get showLogo => (splashScreenImageAssets == null) ? false : true;

  /// Checks whether the image/gif is empty
  ///
  bool get showLabel => (splashScreenLabel == null) ? false : true;
}

/// Represent the types of splash screens
enum SplashType {
  withBackgroundImage,
  withBackgroundColor,
  withBackgroundGradient
}
