import 'package:flutter/material.dart';
import 'package:splash_view/splash_style/model/splash_progress_indicator.dart';
import 'package:splash_view/splash_style/splash_style.dart';
import 'package:splash_view/splash_view/sub_widgets/splash_body.dart';

/// A basic splash screen will be rendered with optional elements like
/// logo, background image,label and an progress indicator.
/// Splash screen will be configured based on the input params given.
///
/// [child] is the view that can be put above the basic splash screen.
/// The child position is completely adjustable.
/// [childPosition] decides the child view position on splash screen.
/// [showProgressIndicator] is flag which indicated whether a progreess indicator need to be shown or hide.
/// [splashProgressIndicator] hold a custom progress indicator.
/// By default [CircularProgressIndicator] will be taken if [splashProgressIndicator] is empty.
/// [splashStyle] contains the splash screen configurations like logo path, background color, etc.
///
class SplashView extends StatefulWidget {
  final Widget child;
  final bool showProgressIndicator;
  final SplashProgressIndicator splashProgressIndicator;
  final AlignmentGeometry childPosition;
  final SplashStyle splashStyle;

  const SplashView(
      {@required this.splashStyle,
      this.child,
      this.showProgressIndicator,
      this.splashProgressIndicator,
      this.childPosition});

  Widget get getChildWidget => child ?? SizedBox();

  bool get getProgressIndicatorVisibility => showProgressIndicator ?? false;

  SplashProgressIndicator get getProgressIndicator =>
      splashProgressIndicator ?? SplashProgressIndicator();

  AlignmentGeometry get getChildPosition =>
      childPosition ?? Alignment.bottomCenter;

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Material(
        child: SplashBody(
      key: ValueKey(111),
      splashStyle: widget.splashStyle,
      showLoader: widget.getProgressIndicatorVisibility,
      childPosition: widget.getChildPosition,
      splashProgressIndicator: widget.getProgressIndicator,
      child: widget.getChildWidget,
    ));
  }
}
