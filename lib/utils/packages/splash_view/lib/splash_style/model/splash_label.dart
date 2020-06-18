import 'package:flutter/material.dart';

/// Represets the position of label with in the screen
///
enum LabelPosition { belowImageOrGif, aboveImageOrGif }

/// Container holds splash screen label text, label position and style details
///
/// If any label is needed to be displayed somewhere in splash screen, mention here with label text, label position and label text style
/// [label] is by default set as empty
/// [position] is the label position, default position is below to the image
/// [labelStyle] is the label text style
///
class SplashScreenLogoLabel {
  LabelPosition position;
  String label;
  TextStyle labelStyle;

  SplashScreenLogoLabel(
      {LabelPosition position, @required String label, TextStyle labelStyle}) {
    this.labelStyle = labelStyle ??
        const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            wordSpacing: 1.0);
    this.position = position ?? LabelPosition.belowImageOrGif;
    this.label = label ?? '';
  }
}
