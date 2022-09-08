import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async
//save all generic dependencies will be used in all app

{
  //shared prefs instance

  final sherdPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sherdPrefs);

  //app prefs instance

  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );
}

Future<void> initLoginModule() async {}
