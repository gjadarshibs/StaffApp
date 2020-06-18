import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class BannerImage extends StatefulWidget {
  BannerImage({Key key}) : super(key: key);

  @override
  _BannerImageState createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  int defaultDisplayIndex = 1;
  List<String> sampleImages = [
    'assets/images/images1.jpg',
    'assets/images/images2.jpg',
    'assets/images/images3.jpg',
    'assets/images/images4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.22,
      child: PageView.builder(
        itemCount: sampleImages.length,
        controller: PageController(viewportFraction: 0.75, initialPage: 1),
        onPageChanged: (int index) =>
            setState(() => defaultDisplayIndex = index),
        itemBuilder: (context, imageIndex) {
          return Transform.scale(
            scale: imageIndex == defaultDisplayIndex ? 1 : 0.85,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .shortcutBackgroundShadow
                                .withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage(sampleImages[imageIndex]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Early Birds Special',
                              style: Theme.of(context)
                                  .textTheme
                                  .bannerImagesTitle),
                          Text('Etihad Airways',
                              style: Theme.of(context)
                                  .textTheme
                                  .bannerImagesSubTitle),
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  print('Banner image tappedd');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
