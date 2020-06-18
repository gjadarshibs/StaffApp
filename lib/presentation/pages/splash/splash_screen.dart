import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:splash_view_package/splash_view_package.dart';

enum SplashScreenType { basic, iflyCorporate, corporateAdaptive, custom }

class SplashScreenConfig {
  SplashScreenConfig(
      {@required this.corporateLogo,
      @required this.background,
      this.airLineLogo})
      : type = SplashScreenType.custom;

  SplashScreenConfig.basic() : type = SplashScreenType.basic {
    background = 'assets/images/bg-login.jpg';
    airLineLogo = '';
  }
  SplashScreenConfig.iflyCorporate() : type = SplashScreenType.iflyCorporate {
    background = 'assets/images/bg-login.jpg';
    airLineLogo = 'assets/images/logo-ifly.svg';
  }

  SplashScreenConfig.corporateAdaptive(
      {@required this.corporateLogo, @required this.airLineLogo})
      : type = SplashScreenType.corporateAdaptive {
    background = 'assets/images/bg-login.jpg';
  }
  final type;
  String airLineLogo;
  String corporateLogo;
  String background;
}

class SplashScreen extends StatelessWidget {
  SplashScreen({@required this.config});
  final SplashScreenConfig config;

  List<Widget> _splashChildren() {
    switch (config.type) {
      case SplashScreenType.basic:
        return [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(config.background),
              ),
            ),
          )
        ];
      case SplashScreenType.iflyCorporate:
        return [
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(config.background),
            ),
          )),
          Align(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 4.5,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SvgPicture.asset(
                        config.airLineLogo,
                      ),
                    ),
                  ),
                ]),
          )
        ];
      case SplashScreenType.corporateAdaptive:
        return [
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(config.background),
            ),
          )),
          Container(
            color: Colors.white.withOpacity(0.6),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 3.5,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SvgPicture.asset(
                        config.airLineLogo,
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                AspectRatio(
                  aspectRatio: 4.5,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SvgPicture.asset(
                        config.corporateLogo,
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                Container(
                  child: Text(
                    'Loading to corporate travel ...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          )
        ];
      default:
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _splashChildren(),
      ),
    );
  }
}
