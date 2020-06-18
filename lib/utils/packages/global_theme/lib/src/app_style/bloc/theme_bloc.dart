import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_theme/src/app_configuration_handler/app_configuration_handler.dart';

import '../basic_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// Contains the business logic to load configuration json and generate corresponding ThemeData

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(themeData: ThemeData.light());

  /// here the state is thrown based on the event triggered
  ///
  /// [event] is the bloc event

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeUpdateEvent) {
      final configObject = await getConfigurationFile(event.themeJson);
      yield ThemeState(themeData: generateThemeData(configObject));
    }
  }
}
