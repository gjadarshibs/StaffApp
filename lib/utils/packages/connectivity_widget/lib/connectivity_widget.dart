import 'package:flutter/material.dart';

import 'package:connectivity_widget/utils/constants.dart';
import 'connectivity_helper.dart';

/// Connectivity Widget
///
/// Widget that is aware of the network status from the network.
///
/// Example:
///
/// ```dart
///  ConnectivityWidget(
///  decoration: BoxDecoration(
///    color: Colors.purple,
///    gradient: new LinearGradient(
///      colors: [Colors.red, Colors.cyan],
///    ),
///  ),
///  height: 150.0,
///  message: "You are Offline!",
///  messageStyle: TextStyle(
///   color: Colors.white,
///    fontSize: 40.0,
///  )
/// ```

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({
    Key key,
    this.child,
    this.color,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.offlineWidget,
    this.stacked = true,
    this.alignment,
    this.disableInteraction = false,
  });

  /// The [child] contained by the Connectivity Widget.
  final Widget child;

  /// The [offlineWidget] contained by the Connectivity Widget.
  final Widget offlineWidget;

  /// The decoration to paint behind the [child].
  final Decoration decoration;

  /// The color to paint behind the [child].
  final Color color;

  /// Disconnected message.
  final String message;

  /// If non-null, the style to use for this text.
  final TextStyle messageStyle;

  /// widget height.
  final double height;

  /// widget height.
  final bool stacked;

  /// Disable the user interaction with child widget
  final bool disableInteraction;

  /// How to align the offline widget.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final connectivityHelper = ConnectivityHelper();

    /// Initialize the connectivity listener.
    connectivityHelper.initialize();

    return StreamBuilder<ConnectionResult>(
        stream: connectivityHelper.connectionChange,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectionResult> snapShot) {
          final isOffline =
              snapShot.hasData ? !snapShot.data.hasConnection : true;

          Widget finalOfflineWidget = Align(
            alignment: alignment ?? Alignment.bottomCenter,
            child: offlineWidget ??
                Container(
                  height: height ?? defaultHeight,
                  width: MediaQuery.of(context).size.width,
                  decoration: decoration ??
                      BoxDecoration(color: color ?? Colors.red.shade300),
                  child: Center(
                    child: Text(
                      message ?? disconnectedMessage,
                      style: messageStyle ?? defaultMessageStyle,
                    ),
                  ),
                ),
          );

          Widget offlineNonInteractionView = Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: decoration ??
                      BoxDecoration(
                        color: Colors.black38,
                      ),
                ),
              )
            ],
          );

          if (stacked) {
            return Stack(
              children: <Widget>[
                child,
                disableInteraction && isOffline
                    ? offlineNonInteractionView
                    : ZeroSizeContainer(),
                isOffline ? finalOfflineWidget : ZeroSizeContainer(),
              ],
            );
          }
          return isOffline ? finalOfflineWidget : child;
        });
  }
}

class ZeroSizeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }
}
