import 'package:flutter/material.dart';
import 'package:splash_view/splash_style/model/splash_progress_indicator.dart';
import 'package:splash_view/splash_style/splash_style.dart';

import 'label.dart';
import 'logo.dart';

/// Here the splash screen layouting will be done.
///
/// [showLoader] is to show or hide loading indicator
/// [splashStyle] contains the splash screen configurations like logo path, background color, etc.
/// [child] is the view that can be put above the basic splash screen.
/// [childPosition] The child position is completely adjustable.
/// [splashProgressIndicator] hold a custom progress indicator.
///
class SplashBody extends StatefulWidget {
  final bool showLoader;
  final SplashStyle splashStyle;
  final Widget child;
  final AlignmentGeometry childPosition;
  final SplashProgressIndicator splashProgressIndicator;

  const SplashBody(
      {Key key,
      @required this.splashStyle,
      @required this.showLoader,
      @required this.child,
      @required this.childPosition,
      @required this.splashProgressIndicator})
      : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: getDecoration(widget.splashStyle),
          ),
        ),
        if (widget.splashStyle.showLogo)
          Logo(
              assets: widget.splashStyle.splashScreenImageAssets,
              label: widget.splashStyle.splashScreenLabel),
        if (!widget.splashStyle.showLogo && widget.splashStyle.showLabel)
          Label(
            label: widget.splashStyle.splashScreenLabel,
            baseWidget: SizedBox(),
            key: ValueKey(22),
          ),
        Align(
            alignment: widget.childPosition,
            child: SafeArea(
              child: widget.child,
            )),
        if (widget.showLoader)
          Align(
            alignment: widget.splashProgressIndicator.indicatorPosition,
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: widget.splashProgressIndicator.indicator),
            ),
          ),
      ],
    );
  }
}

/// Return a [Decoration] instance based on the [splashStyle] provided.
/// [splashStyle] contains the splash screen configurations like logo path, background color, etc.
///
Decoration getDecoration(SplashStyle splashStyle) {
  var decoration = BoxDecoration();

  switch (splashStyle.splashType) {
    case SplashType.withBackgroundImage:
      decoration = splashStyle.splashScreenBackground.isValidImage
          ? decoration.copyWith(
              image: DecorationImage(
                  image: AssetImage(
                      splashStyle.splashScreenBackground.backgroundImage),
                  fit: BoxFit.cover))
          : decoration.copyWith(
              color: splashStyle.splashScreenBackground.backgroundColor);
      break;
    case SplashType.withBackgroundGradient:
      if (splashStyle.splashScreenBackground.gradient != null) {
        decoration = decoration.copyWith(
          gradient: LinearGradient(
              colors: splashStyle.splashScreenBackground.splashBackgroundColor,
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        );
      } else {
        decoration = decoration.copyWith(
            color: splashStyle.splashScreenBackground.splashBackgroundColor[0]);
      }
      break;
    case SplashType.withBackgroundColor:
      decoration = decoration.copyWith(
          color: splashStyle.splashScreenBackground.backgroundColor);

      break;
  }
  return decoration;
}
