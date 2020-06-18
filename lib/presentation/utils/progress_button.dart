import 'package:flutter/material.dart';

/// The button type
enum ProgressButtonType {
  /// Raised Button
  raised,

  /// Flat Button
  flat,

  /// Outline Button
  outline,
}

/// The state of of button, 'onProgress' button begin to show progress indicator.
enum ProgressButtonState {
  normal,
  onProgress,
}

/// Button which shows a linear progress indicator at bottom.
/// You can acheive this by change state of button,
/// there are  two state 'normal' and 'onProgress'. By changing the state from
/// 'normal' to 'onProgress' it will show indicator.
class ProgressButton extends StatelessWidget {
  const ProgressButton({
    Key key,
    @required this.type,
    @required this.title,
    @required this.onPressed,
    this.state = ProgressButtonState.normal,
    this.width = double.infinity,
    this.height = 55.0,
    this.borderRadius = 4.0,
    this.indicatorHeightFactor = 0.6,
    this.backgroundColor = Colors.blue,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.indicatorBackgroundColor = Colors.white60,
    this.indicatorForgroundColor = Colors.white,
  }) : super(key: key);

  /// Button State for show and hide indicator.
  final ProgressButtonState state;

  /// Type of button
  final ProgressButtonType type;

  /// Title shown in the button.
  final Widget title;

  /// Background color of button
  final Color backgroundColor;

  /// Active color of progress indicator.
  final Color indicatorForgroundColor;

  /// Inactive color of progress indicator
  final Color indicatorBackgroundColor;

  /// BorderRadius of the button.
  final double borderRadius;
  final double width;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  // If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be positive.
  final double indicatorHeightFactor;

  /// Button onPress callback.
  final VoidCallback onPressed;

  Widget _buildButtonContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 12.0),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: title,
          ),
        ),
        SizedBox(height: 8.0),
        state == ProgressButtonState.normal
            ? SizedBox(
                width: double.infinity,
                height: 6.0,
              )
            : ClipRect(
                child: Align(
                  heightFactor: indicatorHeightFactor,
                  child: LinearProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(indicatorForgroundColor),
                    backgroundColor: indicatorBackgroundColor,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildButton() {
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius));
    switch (type) {
      case ProgressButtonType.flat:
        return FlatButton(
          padding: const EdgeInsets.all(0.0),
          shape: shape,
          color: backgroundColor,
          child: _buildButtonContent(),
          onPressed: onPressed,
        );
      case ProgressButtonType.raised:
        return RaisedButton(
          padding: const EdgeInsets.all(0.0),
          shape: shape,
          color: backgroundColor,
          child: _buildButtonContent(),
          onPressed: onPressed,
        );
      case ProgressButtonType.outline:
        return OutlineButton(
          highlightedBorderColor: backgroundColor,
          color: backgroundColor,
          shape: shape,
          padding: const EdgeInsets.all(0.0),
          child: _buildButtonContent(),
          onPressed: onPressed,
        );
      default:
        return FlatButton(
          child: _buildButtonContent(),
          onPressed: onPressed,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: _buildButton(),
    );
  }
}

extension ProgressButtonFactory on ProgressButton {
  static ProgressButton authButton(
      {@required String title,
      @required ProgressButtonState state,
      Function() onPressed}) {
    return ProgressButton(
      state: state,
      type: ProgressButtonType.raised,
      backgroundColor: Color(0xFF159697),
      indicatorForgroundColor: Color(0xFF6ec1c4),
      indicatorBackgroundColor: Color(0xFF5ae1e6),
      indicatorHeightFactor: 0.8,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      onPressed: onPressed,
    );
  }
}
