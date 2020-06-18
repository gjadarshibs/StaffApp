import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final double height;
  final double width;
  final List<Color> colors;

  GradientContainer({this.height, this.width, this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          // stops: [0.7,0.8,0.9],
          begin: Alignment.bottomLeft,
          end: Alignment(-1.0, -1.0),
        ),
      ),
    );
  }
}
