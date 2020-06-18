part of 'theme_bloc.dart';

/// A class holds the ThemeData instance
///
///[themeData] is the reference to ThemeData

class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState({@required this.themeData});

  @override
  List<Object> get props => [themeData];
}
