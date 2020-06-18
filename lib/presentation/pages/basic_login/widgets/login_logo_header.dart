import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginLogoHeader extends StatelessWidget {
  LoginLogoHeader(
      {this.aspectRatio = 1.8, this.airlineLogo, this.corporateLogo});

  final String airlineLogo;
  final String corporateLogo;
  final double aspectRatio;

  Widget _airlineLogoSection() {
    return airlineLogo != null
        ? FittedBox(child: SvgPicture.asset(airlineLogo, width: 300.0, height: 100.0,))
        : Container(width:300.0, height: 100.0,);
  }

  Widget _corporateLogoScetion() {
    return airlineLogo != null
        ? FittedBox(child: SvgPicture.asset(corporateLogo, width: 100.0, height: 100.0,))
        : Container(width: 100.0, height: 100.0,);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(12.0),
              child: FittedBox(
                child: _airlineLogoSection(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(12.0),
              child: FittedBox(
                child: _corporateLogoScetion(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

