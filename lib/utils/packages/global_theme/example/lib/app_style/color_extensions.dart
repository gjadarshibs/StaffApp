import 'package:flutter/material.dart';

/// Here we can add custom colors and can be accessed via context from anywhere with in the app
///
/// Below are the steps to access the text style
/// * import theme_extensions.dart file
/// * Theme.of(context).colorScheme.logoColor

extension customColors on ColorScheme {
  Color get logoColor => const Color(0xFFdc3545);
}
