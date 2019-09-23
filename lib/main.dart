import 'package:flutter/material.dart';

import 'src/app_module.dart';
import 'src/shared/locator.dart';

void main() async {
  await setupLocator();
  runApp(AppModule());
}
