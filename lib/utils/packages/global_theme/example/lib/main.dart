import 'package:flutter/material.dart';
import 'package:global_theme/global_theme.dart';

import 'app_style/theme_extensions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc()
          ..add(ThemeUpdateEvent(
              themeJson: 'assets/configurations/theme_one.json')),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: _buildWithTheme));
  }

  /// This widget is the root of your application.
  /// ThemeData will be configured based on the configuration json received.
  ///
  /// [state] contains the reference to the configured ThemeData.

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: state.themeData,
        home: MyHomePage(
          title: 'HOME',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _changeTheme() {
    BlocProvider.of<ThemeBloc>(context).add(
        ThemeUpdateEvent(themeJson: 'assets/configurations/theme_two.json'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'This is the heading style defined in configuration json.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),

              /// Here the caption text style is loaded using context.
              /// Caption text style is defined in theme_extensions.dart file
              Text(
                'Here the app theme is applied as per the field in the configuration json.',
                style: Theme.of(context).textTheme.captionText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeTheme,
        tooltip: 'Change Theme',
        child: Icon(Icons.color_lens),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
