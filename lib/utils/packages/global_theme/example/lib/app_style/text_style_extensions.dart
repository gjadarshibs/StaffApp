import 'package:flutter/material.dart';

/// Here we can add custom text styles and can be accessed via context from anywhere with in the app
///
/// Below are the steps to access the text style
/// * import theme_extensions.dart file
/// * Theme.of(context).textTheme.captionText

extension textStyles on TextTheme {
  TextStyle get captionText {
    return TextStyle(
        color: Colors.grey[700], fontSize: 12.0, fontWeight: FontWeight.w400);
  }
}
