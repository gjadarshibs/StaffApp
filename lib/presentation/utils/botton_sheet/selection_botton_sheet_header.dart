import 'package:flutter/material.dart';

class SelectionBottomSheetHeader extends StatelessWidget {
  const SelectionBottomSheetHeader({@required this.title});
  final title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: 4.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1,
          ),
        ],
      ),
    );
  }
}
