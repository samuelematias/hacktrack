import 'package:get_it/get_it.dart';

import 'app_preferences.dart';

GetIt locator = GetIt();

Future setupLocator() async {
  var instance = await AppPreferencesService.getInstance();
  locator.registerSingleton<AppPreferencesService>(instance);
}
