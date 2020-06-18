part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// BLoC event to update theme
///
/// [themeJson] is an Enum contains theme configuration json names

class ThemeUpdateEvent extends ThemeEvent {
  final String themeJson;

  ThemeUpdateEvent({@required this.themeJson});

  @override
  List<Object> get props => [themeJson];
}
