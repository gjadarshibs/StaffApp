import 'package:flutter/cupertino.dart';

import 'app_color.dart';
import 'app_decoration.dart';
import 'app_text_style.dart';

/// Model class that holds all entities in the configuration json

class AppConfigurationContainer {
  _ThemeConfiguration _themeConfiguration;

  AppConfigurationContainer(
      {@required _ThemeConfiguration themeConfiguration}) {
    _themeConfiguration = themeConfiguration;
  }

  _ThemeConfiguration get _themeConfig =>
      _themeConfiguration ?? _ThemeConfiguration.withDefaultValue();

  AppColorContainer get appColor => _themeConfig._color;

  AppTextStyleContainer get appTextStyles => _themeConfig._textStyle;

  AppDecorations get appDecoration => _themeConfig._containerDecoration;

  AppConfigurationContainer.fromJson(Map<String, dynamic> json) {
    _themeConfiguration = json['theme_configuration'] != null
        ? _ThemeConfiguration.fromJson(json['theme_configuration'])
        : _ThemeConfiguration.withDefaultValue();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_themeConfiguration != null) {
      data['theme_configuration'] = _themeConfiguration.toJson();
    }
    return data;
  }
}

class _ThemeConfiguration {
  AppColorContainer _color;
  AppTextStyleContainer _textStyle;
  AppDecorations _containerDecoration;

  _ThemeConfiguration.withDefaultValue() {
    _color = AppColorContainer.withDefaultValues();
    _textStyle = AppTextStyleContainer.withDefaultValues();
  }

  _ThemeConfiguration(
      {AppColorContainer color,
      AppTextStyleContainer textStyle,
      AppDecorations containerDecoration}) {
    _color = color;
    _textStyle = textStyle;
    _containerDecoration = containerDecoration;
  }

  AppColorContainer get color => _color;

  AppTextStyleContainer get textStyle => _textStyle;

  AppDecorations get containerDecoration => _containerDecoration;

  _ThemeConfiguration.fromJson(Map<String, dynamic> json) {
    _color = json['color'] != null
        ? AppColorContainer.fromJson(json['color'])
        : AppColorContainer.withDefaultValues();
    _textStyle = json['text_style'] != null
        ? AppTextStyleContainer.fromJson(json['text_style'])
        : AppTextStyleContainer.withDefaultValues();
    _containerDecoration = json['decoration'] != null
        ? AppDecorations.fromJson(json['decoration'])
        : AppDecorations.withDefaultValue();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_color != null) {
      data['color'] = _color.toJson();
    }
    if (_textStyle != null) {
      data['text_style'] = _textStyle.toJson();
    }
    if (_containerDecoration != null) {
      data['container_decoration'] = _containerDecoration.toJson();
    }
    return data;
  }
}
