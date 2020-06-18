/// Model class that holds the color params in the configuration json.

class AppColorContainer {
  bool _autoBrightness;
  String _primaryColor;
  String _accentColor;
  String _appBarColor;
  String _scaffoldBackgroundColor;

  AppColorContainer.withDefaultValues() {
    setDefaultValues();
  }

  void setDefaultValues() {
    _autoBrightness = false;
    _primaryColor = '#000080';
    _accentColor = '#808080';
    _appBarColor = '#000080';
    _scaffoldBackgroundColor = '#FF5F5F5';
  }

  AppColorContainer(
      {bool autoBrightness,
      String primaryColor,
      String accentColor,
      String appBarColor,
      String scaffoldBackgroundColor}) {
    _autoBrightness = autoBrightness;
    _primaryColor = primaryColor;
    _accentColor = accentColor;
    _appBarColor = appBarColor;
    _scaffoldBackgroundColor = scaffoldBackgroundColor;
  }

  bool get autoBrightness => _autoBrightness;

  String get primaryColor => _primaryColor;

  String get accentColor => _accentColor;

  String get appBarColor => _appBarColor;

  String get scaffoldBackgroundColor => _scaffoldBackgroundColor;

  AppColorContainer.fromJson(Map<String, dynamic> json) {
    setDefaultValues();

    _autoBrightness = json['auto_brightness'] ?? _autoBrightness;
    _primaryColor = json['primary_color'] ?? _primaryColor;
    _accentColor = json['accent_color'] ?? _accentColor;
    _appBarColor = json['app_bar_color'] ?? _appBarColor;
    _scaffoldBackgroundColor =
        json['scaffold_background_color'] ?? _scaffoldBackgroundColor;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['auto_brightness'] = _autoBrightness;
    data['primary_color'] = _primaryColor;
    data['accent_color'] = _accentColor;
    data['app_bar_color'] = _appBarColor;
    data['scaffold_background_color'] = _scaffoldBackgroundColor;
    return data;
  }
}
