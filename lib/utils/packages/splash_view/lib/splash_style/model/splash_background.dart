import 'package:flutter/material.dart';

/// Splash screen background can be set as single color background or gradient color or an image
///
/// [gradient] contains the gradient start and end colors
/// [backgroundColor] is the splash screen background color
/// [backgroundImage] is the background image of splash screen
///
class SplashScreenBackground {
  SplashGradient gradient;
  Color backgroundColor;
  String backgroundImage;

  SplashScreenBackground(
      {Color backgroundColor, this.gradient, this.backgroundImage}) {
    this.backgroundColor = backgroundColor ?? Colors.blue;
  }

  /// Checks whether the background image asset path string is empty or not
  ///
  bool get isValidImage => (backgroundImage == null) ? false : true;

  /// Return a [List<Color>]
  /// If gradient colors are not empty, return a List of gradient start and end colors.
  /// If gradient is empty, return a List of a sigle value, ie backgroudColor
  ///
  List<Color> get splashBackgroundColor {
    if (gradient != null) {
      return [gradient.startColor, gradient.endColor];
    }
    return [backgroundColor ?? Colors.blue];
  }
}

/// Class holds gradient start and end color
///
class SplashGradient {
  final Color startColor;
  final Color endColor;

  SplashGradient({@required this.startColor, @required this.endColor});
}
