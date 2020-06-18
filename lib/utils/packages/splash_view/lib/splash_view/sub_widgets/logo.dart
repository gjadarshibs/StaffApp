import 'package:flutter/material.dart';
import 'package:splash_view/splash_style/model/splash_image_asset.dart';
import 'package:splash_view/splash_style/model/splash_label.dart';

import 'label.dart';

/// Here the splash screen image/gif widget will be rendered and positioned
///
/// [assets] is the splash screen image/gif configuration object.
/// [label] is the splash screen label configuration object.
///
class Logo extends StatefulWidget {
  final SplashScreenLogo assets;
  final SplashScreenLogoLabel label;

  const Logo({Key key, this.assets, this.label}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    Widget logo = widget.assets.isAutoSize
        ? Image.asset(
            widget.assets.splashScreenImageOrGifPath,
          )
        : Image.asset(
            widget.assets.splashScreenImageOrGifPath,
            width: widget.assets.width,
            height: widget.assets.height,
          );

    if (widget.label != null) {
      logo = Label(label: widget.label, baseWidget: logo);
    } else {
      logo = Container(
        child: logo,
        margin: EdgeInsets.all(50),
      );
    }
    switch (widget.assets.position) {
      case AssetImagePosition.topCenter:
        return Align(
          alignment: Alignment.topCenter,
          child: logo,
        );
        break;
      case AssetImagePosition.center:
        return Align(
          alignment: Alignment.center,
          child: logo,
        );
        break;
      default:
        return Align(
          alignment: Alignment.bottomCenter,
          child: logo,
        );
        break;
    }
  }
}
