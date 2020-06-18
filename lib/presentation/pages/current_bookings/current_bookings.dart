import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/pages/slide_menu/slide_menu_page.dart';

class CurrentBookingsPage extends StatefulWidget {
  final Widget drawer;
  CurrentBookingsPage({Key key, this.drawer}) : super(key: key);
  @override
  _CurrentBookingsPageState createState() => _CurrentBookingsPageState();
}

class _CurrentBookingsPageState extends State<CurrentBookingsPage> {
    Pages pageSelection = Pages.currentBookings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Bookings'),),
      drawer: widget.drawer,
    );
  }
}
