import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/pages/slide_menu/slide_menu_page.dart';

class MakeBookingPage extends StatefulWidget {
  final Widget drawer;
  MakeBookingPage({Key key, this.drawer}) : super(key: key);
  @override
  _MakeBookingPageState createState() => _MakeBookingPageState();
}

class _MakeBookingPageState extends State<MakeBookingPage> {
    Pages pageSelection = Pages.makeBooking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Booking'),),
      drawer: widget.drawer,
    );
  }
}
