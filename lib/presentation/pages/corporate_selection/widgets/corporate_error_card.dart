import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CorporateErrorCard extends StatefulWidget {
  CorporateErrorCard({Key key}) : super(key: key);

  @override
  _CorporateErrorCardState createState() => _CorporateErrorCardState();
}

class _CorporateErrorCardState extends State<CorporateErrorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Card(
        elevation: 10,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/icn-info.svg',
                color: Colors.white,
                height: 35,
                width: 35,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Incorrect Corporate ID',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Please try Again!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
