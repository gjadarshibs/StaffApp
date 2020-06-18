import 'package:ifly_corporate_app/app_environment/main.dart';
import 'package:ifly_corporate_app/app_environment/setup/config/app_enviroment.dart';
import 'package:ifly_corporate_app/app_environment/setup/config/flavor_conf.dart';

Future<void> main() async {
  await flavouredMain(FlavorConfig(environment: AppEnvironment.dev));
}