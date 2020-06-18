import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  ScaffoldBody(
      {@required this.child,
      this.backgroundColor = Colors.white,
      this.backgroundImage,
      this.gradient});

  ScaffoldBody.authSceneNormal({@required this.child})
      : backgroundColor = Colors.white,
        backgroundImage = 'assets/images/bg-login.jpg',
        gradient = null;
  ScaffoldBody.authSceneGradient({@required this.child})
      : backgroundColor = Colors.white,
        backgroundImage = 'assets/images/bg-login.jpg',
        gradient = LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.0),
          ],
          stops: [0, 0.8, 1.0],
        );
  final String backgroundImage;
  final Color backgroundColor;
  final Widget child;
  final LinearGradient gradient;

  BoxDecoration _getBackgroundDecoration() {
    return backgroundImage != null
        ? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  backgroundImage,
                ),
                fit: BoxFit.cover),
          )
        : BoxDecoration(
            color: backgroundColor,
          );
  }

  BoxDecoration _getGradientDecoration() {
    return gradient != null
        ? BoxDecoration(
            color: backgroundColor,
            gradient: gradient,
          )
        : BoxDecoration(
            color: Colors.transparent,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: _getBackgroundDecoration(),
        ),
        Container(
          decoration: _getGradientDecoration(),
        ),
        Positioned.fill(child: child)
      ],
    );
  }
}
