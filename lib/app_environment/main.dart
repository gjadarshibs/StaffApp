import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/app_environment/setup/config/flavor_conf.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/app/app.dart';

Future<void> flavouredMain(FlavorConfig config) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  // Load the JSON config into memory
  await config.initialize();
  final userRepository = UserRepository();
  final corporateRepository = CorporateRepository();
  final bookingRepository = BookingRepository();
  runApp(BlocProvider(
    create: (context) {
      return AuthenticationBloc(
          corporateRepository: corporateRepository,
          userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      bookingRepository: bookingRepository,
      userRepository: userRepository,
      corporateRepository: corporateRepository,
    ),
  ));
}
