import 'package:flutter/material.dart';

/// Container holds splash screen image path and size details
///
///[splashScreenImageOrGifPath] is the image or gif asset path
///[width,height] is the image or gif size
///[position] is the image or gif position on the splash screen
///
class SplashScreenLogo {
  String splashScreenImageOrGifPath;
  double width;
  double height;
  AssetImagePosition position;

  SplashScreenLogo(
      {@required this.splashScreenImageOrGifPath,
      AssetImagePosition position,
      this.width,
      this.height}) {
    this.position = position ?? AssetImagePosition.center;
  }

  /// Checks whether any size of the image/gif is set
  ///
  bool get isAutoSize => (width == 0) ? true : false;
}

/// Represent the image/gif position with in the screen
///
enum AssetImagePosition { topCenter, center, bottomCenter }
