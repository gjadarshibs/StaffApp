import 'package:flutter/material.dart';

/// Holds the informations to render the loading indicator on splash screen
/// [progressIndicatorPosition] is the indicator postion.
/// [progressIndicator] is the custom progress indicator. [CircularProgressIndicator] will be taken as defult value.
///
class SplashProgressIndicator {
  final AlignmentGeometry progressIndicatorPosition;
  final Widget progressIndicator;

  const SplashProgressIndicator({
    Key key,
    this.progressIndicatorPosition,
    this.progressIndicator,
  });

  AlignmentGeometry get indicatorPosition =>
      progressIndicatorPosition ?? Alignment.bottomCenter;

  Widget get indicator =>
      progressIndicator ??
      CircularProgressIndicator(backgroundColor: Colors.white);
}
