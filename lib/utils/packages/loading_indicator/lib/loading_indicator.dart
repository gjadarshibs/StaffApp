import 'package:flutter/material.dart';
import 'dart:async';

enum LoadingIndicatorPosition { top, center, bottom }

class LoadingIndicator extends StatefulWidget {

  /// Creates a Loading Indicator widget with a CircularProgressIndicator.
  ///
  /// [loadingIndicatorPosition] this will define the position loading indicator.
  /// [LoadingIndicatorPosition.center] by default.
  ///
  /// [backgroundColor]s define the progress indicator's background color.
  ///
  /// The [loadingMessage] define the purpose of the loading indicator.
  ///
  /// The [valueColor] which provides a lower-level way to draw text.
  ///
  /// The [messageTextStyle] style to use for this loadingMessage.
  /// TextStyle(color: Colors.black, fontSize: 15) by default.
  LoadingIndicator(
      {Key key,
        this.loadingIndicatorPosition = LoadingIndicatorPosition.center,
        this.backgroundColor,
        this.loadingMessage,
        this.valueColor,
        this.messageTextStyle = const TextStyle(
          color: Colors.black,
          fontSize: 15,
        )})
      : super(key: key);

  /// Creates a Loading Indicator widget with a gif or image.
  ///
  /// [loadingIndicatorPosition] this will define the position loading indicator.
  /// [LoadingIndicatorPosition.center] by default.
  ///
  /// [backgroundColor]s define the progress indicator's background color.
  ///
  /// The [loadingMessage] define the purpose of the loading indicator.
  ///
  /// The [loadingSize] which provides the size of loading indicator view.
  /// [Size(150, 150)] by default.
  ///
  /// The [gifOrImagePath] which provide the path of image/gif file.
  ///
  /// The [messageTextStyle] style to use for this loadingMessage.
  /// TextStyle(color: Colors.black, fontSize: 15) by default.
  LoadingIndicator.gifOrImage(
      {Key key,
        this.loadingIndicatorPosition = LoadingIndicatorPosition.center,
        this.backgroundColor,
        this.loadingMessage,
        this.loadingSize = const Size(150, 150),
        this.gifOrImagePath,
        this.messageTextStyle = const TextStyle(
          color: Colors.black,
          fontSize: 15,
        )})
      : super(key: key);

  /// purpose of the loading indicator
  String loadingMessage;

  /// This will be give the indicator position.
  LoadingIndicatorPosition loadingIndicatorPosition;

  /// The progress indicator's background color.
  ///
  /// The current theme's [ThemeData.backgroundColor] by default.
  Color backgroundColor;

  /// Style to use for this loadingMessage
  TextStyle messageTextStyle;

  /// This will be give the size for the loading indicator.
  Size loadingSize;

  /// This will provide the path of image/gif file.
  String gifOrImagePath = '';

  /// The progress indicator's color.
  ///
  /// If null, the progress indicator is rendered with the current theme's
  /// [ThemeData.accentColor].
  Color valueColor;

  /// This value being updated based on loading indicator visibility.
  bool _isShowing = false;

  /// This will help to identify the indicator to dismiss from the view.
  static final GlobalKey<State> keyLoader = GlobalKey<State>();

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getValueColor(BuildContext context) =>
      valueColor ?? Theme.of(context).accentColor;

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();

  bool isShowing() => _isShowing;

  /// This will show the loading indicator on current context.
  ///
  /// [context] This will be provide the loading indicator presentation build context.
  /// NOTE: Here LoadingIndicatorPosition will not work.
  Future<void> show(BuildContext context) async {
    try {
      if (!_isShowing) {
        // ignore: unawaited_futures
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => WillPopScope(
                  onWillPop: () async => false,
                  child: SimpleDialog(
                      key: LoadingIndicator.keyLoader,
                      backgroundColor: Colors.transparent,
                      children: <Widget>[this])));

        _isShowing = true;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }

  /// This will hide the loading indicator from current context.
  Future<void> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(LoadingIndicator.keyLoader.currentContext).pop();
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  Widget get _defaultIndicator => Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: widget._getBackgroundColor(context),
      borderRadius: BorderRadius.circular(
        8,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(widget._getValueColor(context)),
        ),
        if (widget.loadingMessage != null) SizedBox(height: 24),
        if (widget.loadingMessage != null)
          Text(
            widget.loadingMessage,
            textAlign: TextAlign.center,
            style: widget.messageTextStyle,
          ),
      ],
    ),
  );

  Widget get _gifOrImageIndicator => Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget._getBackgroundColor(context),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            widget.gifOrImagePath,
            width: widget.loadingSize.width * 0.6,
            height: widget.loadingSize.height * 0.6,
          ),
          if (widget.loadingMessage != null)
            Text(
              widget.loadingMessage,
              textAlign: TextAlign.center,
              style: widget.messageTextStyle,
            ),
        ],
      ));

  @override
  void dispose() {
    widget._isShowing = false;
    super.dispose();
  }

  AlignmentGeometry _indicatorPosition() {
    switch (widget.loadingIndicatorPosition) {
      case LoadingIndicatorPosition.center:
        return Alignment.center;
        break;
      case LoadingIndicatorPosition.top:
        return Alignment.topCenter;
        break;
      case LoadingIndicatorPosition.bottom:
        return Alignment.bottomCenter;
        break;
    }
    return Alignment.center;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
          Align(
            alignment: _indicatorPosition(),
            child: widget.gifOrImagePath.isEmpty
                ? _defaultIndicator
                : _gifOrImageIndicator,
          )
        ]));
  }
}
