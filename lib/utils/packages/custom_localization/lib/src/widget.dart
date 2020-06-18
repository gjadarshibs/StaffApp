import 'package:flutter/material.dart';

import 'localization_delegate.dart';

/// A simple but useful widget that allows to load CustomLocalization easier.
class CustomLocalizationBuilder extends StatefulWidget {
  /// The delegate builder.
  final CustomLocalizationDelegate delegate;

  /// The widget builder.
  final Widget Function(BuildContext context, CustomLocalizationDelegate customLocalizationDelegate) builder;

  /// Creates a new CustomLocalization builder instance.
  const CustomLocalizationBuilder({
    this.delegate = const CustomLocalizationDelegate(),
    @required this.builder,
  });

  @override
  State<StatefulWidget> createState() => CustomLocalizationBuilderState();

  /// Allows to change the preferred locale (if using the builder).
  static CustomLocalizationBuilderState of(BuildContext context) => context.findAncestorStateOfType<CustomLocalizationBuilderState>();
}

/// The CustomLocalization builder state.
class CustomLocalizationBuilderState extends State<CustomLocalizationBuilder> {
  /// The current CustomLocalization delegate.
  CustomLocalizationDelegate _customLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    _customLocalizationDelegate = widget.delegate;
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _customLocalizationDelegate);

  /// Allows to change the preferred locale.
  void changeLocale(Locale locale) {
    if(mounted) {
      setState(() {
        _customLocalizationDelegate = CustomLocalizationDelegate(
          supportedLocales: _customLocalizationDelegate.supportedLocales,
          getPathFunction: _customLocalizationDelegate.getPathFunction,
          notFoundString: _customLocalizationDelegate.notFoundString,
          locale: locale,
        );
      });
    }
  }
}