import 'package:flutter/material.dart';

@immutable
class ColoredSafeArea extends StatelessWidget {
 const ColoredSafeArea(
      {@required this.child,
      @required this.topColor,
      @required this.bottomColor});
  final Widget child;
  final Color topColor, bottomColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                child: Container(
                  color: topColor,
                )),
            Container(
              width: double.infinity,
              height: 64,
              color: bottomColor,
            ),
          ],
        ),
        Positioned.fill(
          child: SafeArea(
           child: child,
        )),
      ],
    );
  }
}

class GradientSafeArea extends StatelessWidget {

  const GradientSafeArea(
      {@required this.child,
      @required this.topGradient,
      @required this.bottomGradient,
      @required this.backgroundColor});
  final Widget child;
  final LinearGradient topGradient, bottomGradient;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    gradient: topGradient,
                  ),
                ),),
            Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                    color: backgroundColor,
                    gradient: bottomGradient,
                  ),
            ),
          ],
        ),
        Positioned.fill(
            child: SafeArea(
          child: child,
        )),
      ],
    );
  }
}
