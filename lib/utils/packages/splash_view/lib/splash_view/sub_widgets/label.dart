import 'package:flutter/material.dart';
import 'package:splash_view/splash_style/model/splash_label.dart';

/// Splash screen label will be rendered here.
/// [label] is an instance of [SplashScreenLogoLabel] class contains
/// informations like label text, label style and label postion
/// [baseWidget] is the reference widget above or below the label will be placed.
/// For example the label can be place top to or bottom to the Logo.
///
class Label extends StatefulWidget {
  final SplashScreenLogoLabel label;
  final Widget baseWidget;

  const Label({Key key, @required this.label, @required this.baseWidget})
      : super(key: key);

  @override
  _LabelState createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    final logoLabel = Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          widget.label.label,
          textAlign: TextAlign.center,
          style: widget.label.labelStyle,
        ));
    Widget container = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.label.position == LabelPosition.aboveImageOrGif) logoLabel,
        widget.baseWidget,
        if (widget.label.position == LabelPosition.belowImageOrGif) logoLabel
      ],
    );

    container = Container(
      width: double.maxFinite,
      child: container,
      margin: EdgeInsets.all(50),
    );
    return container;
  }
}
