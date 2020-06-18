/// Model class that holds the text style params in the configuration json.

class AppTextStyleContainer {
  String _fontFamily;
  _TextStyleEntity _heading;
  _TextStyleEntity _subHeading;
  _TextStyleEntity _body;

  AppTextStyleContainer.withDefaultValues() {
    _setDefaultValue();
  }

  void _setDefaultValue() {
    _fontFamily = 'roboto';
    _heading = _TextStyleEntity.heading();
    _subHeading = _TextStyleEntity.subHeading();
    _body = _TextStyleEntity.body();
  }

  AppTextStyleContainer(
      {String fontFamily,
      _TextStyleEntity heading,
      _TextStyleEntity subHeading,
      _TextStyleEntity body}) {
    _fontFamily = fontFamily;
    _heading = heading;
    _subHeading = subHeading;
    _body = body;
  }

  String get fontFamily => _fontFamily;

  _TextStyleEntity get heading => _heading;

  _TextStyleEntity get subHeading => _subHeading;

  _TextStyleEntity get body => _body;

  AppTextStyleContainer.fromJson(Map<String, dynamic> json) {
    _fontFamily = json['font_family'];
    _heading = json['heading'] != null
        ? _TextStyleEntity.fromJson(json['heading'])
        : _TextStyleEntity.heading();
    _subHeading = json['sub_heading'] != null
        ? _TextStyleEntity.fromJson(json['sub_heading'])
        : _TextStyleEntity.subHeading();
    _body = json['body'] != null
        ? _TextStyleEntity.fromJson(json['body'])
        : _TextStyleEntity.body();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['font_family'] = _fontFamily;
    if (_heading != null) {
      data['heading'] = _heading.toJson();
    }
    if (_subHeading != null) {
      data['sub_heading'] = _subHeading.toJson();
    }
    if (_body != null) {
      data['body'] = _body.toJson();
    }
    return data;
  }
}

class _TextStyleEntity {
  String _color;
  double _fontSize;

  _TextStyleEntity({String color, double fontSize}) {
    _color = color;
    _fontSize = fontSize;
  }

  _TextStyleEntity.heading() {
    _color = '#454545';
    _fontSize = 25;
  }

  _TextStyleEntity.subHeading() {
    _color = '#454545';
    _fontSize = 20;
  }

  _TextStyleEntity.body() {
    _color = '#454545';
    _fontSize = 17;
  }

  String get color => _color;

  double get fontSize => _fontSize;

  _TextStyleEntity.fromJson(Map<String, dynamic> json) {
    _color = json['color'];
    _fontSize = json['font_size'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['color'] = _color;
    data['font_size'] = _fontSize;
    return data;
  }
}
