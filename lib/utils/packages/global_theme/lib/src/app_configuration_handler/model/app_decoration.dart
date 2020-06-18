/// Model class that holds the decoration params in the configuration json.

class AppDecorations {
  _RoundedEdge _roundedEdge;
  _ImageBackgrounded _imageBackgrounded;

  AppDecorations(
      {_RoundedEdge roundedEdge, _ImageBackgrounded imageBackgrounded}) {
    _roundedEdge = roundedEdge;
    _imageBackgrounded = imageBackgrounded;
  }

  AppDecorations.withDefaultValue() {
    _roundedEdge = _RoundedEdge.withDefaultValue();
    _imageBackgrounded = _ImageBackgrounded.withDefaultValue();
  }

  _RoundedEdge get roundedEdge => _roundedEdge;

  _ImageBackgrounded get imageBackgrounded => _imageBackgrounded;

  AppDecorations.fromJson(Map<String, dynamic> json) {
    _roundedEdge = json['rounded_edge'] != null
        ? _RoundedEdge.fromJson(json['rounded_edge'])
        : _RoundedEdge.withDefaultValue();
    _imageBackgrounded = json['image_backgrounded'] != null
        ? _ImageBackgrounded.fromJson(json['image_backgrounded'])
        : _ImageBackgrounded.withDefaultValue();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_roundedEdge != null) {
      data['rounded_edge'] = _roundedEdge.toJson();
    }
    if (_imageBackgrounded != null) {
      data['image_backgrounded'] = _imageBackgrounded.toJson();
    }
    return data;
  }
}

class _RoundedEdge {
  double _cornerRadius;
  double _borderWidth;
  String _borderColor;
  String _color;

  _RoundedEdge.withDefaultValue() {
    setDefaultValue();
  }

  void setDefaultValue() {
    _cornerRadius = 10.0;
    _borderWidth = 1.0;
    _borderColor = '#999999';
    _color = '#FFFFFF';
  }

  _RoundedEdge(
      {double cornerRadius,
      double borderWidth,
      String borderColor,
      String color}) {
    _cornerRadius = cornerRadius;
    _borderWidth = borderWidth;
    _borderColor = borderColor;
    _color = color;
  }

  double get cornerRadius => _cornerRadius;

  double get borderWidth => _borderWidth;

  String get borderColor => _borderColor;

  String get color => _color;

  _RoundedEdge.fromJson(Map<String, dynamic> json) {
    setDefaultValue();
    _cornerRadius = json['corner_radius'] ?? _cornerRadius;
    _borderWidth = json['border_width'] ?? _borderWidth;
    _borderColor = json['border_color'] ?? _borderColor;
    _color = json['color'] ?? _color;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['corner_radius'] = _cornerRadius;
    data['border_width'] = _borderWidth;
    data['border_color'] = _borderColor;
    data['color'] = _color;
    return data;
  }
}

class _ImageBackgrounded {
  String _assetLocation;

  void setDefaultValue() {
    _assetLocation = 'assets/images/background.png';
  }

  _ImageBackgrounded({String assetLocation}) {
    _assetLocation = assetLocation;
  }

  _ImageBackgrounded.withDefaultValue() {
    setDefaultValue();
  }

  String get assetLocation => _assetLocation;

  _ImageBackgrounded.fromJson(Map<String, dynamic> json) {
    _assetLocation = json['asset_location'];
  }

  Map<String, dynamic> toJson() {
    setDefaultValue();
    final data = <String, dynamic>{};
    data['asset_location'] = _assetLocation;
    return data;
  }
}
