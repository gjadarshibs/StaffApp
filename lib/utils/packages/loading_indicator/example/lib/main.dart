import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Loading Indicators',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Loading Indicators'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _defaultLoadingIndicator =  LoadingIndicator(loadingMessage: 'Loading....');
  final _gifLoadingIndicator = LoadingIndicator.gifOrImage(gifOrImagePath: 'assets/images/ic_loading.gif',
  loadingMessage: 'Loading....');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Default'),
            LoadingIndicator(loadingMessage: 'Loading....'),
            SizedBox(height: 20.0),
            Text('Gif loading indicator'),
            SizedBox(height: 16.0),
            LoadingIndicator.gifOrImage(gifOrImagePath: 'assets/images/ic_loading.gif',
                loadingMessage: 'Loading....'),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () async {
                await _defaultLoadingIndicator.show(context);
                 Future.delayed(Duration(seconds: 5), () {
                   _defaultLoadingIndicator.hide();
                 });
              },
              child: Text("Show default indicator"),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () async {
                await _gifLoadingIndicator.show(context);
                Future.delayed(Duration(seconds: 5), () {
                  _gifLoadingIndicator.hide();
                });
              },
              child: Text("Show gif indicator"),
            )
          ],
        ),
      ),
    );
  }
}
