import 'package:flutter/material.dart';

import 'app/core/app_widget.dart';
import 'app/core/config/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  runApp(const AppWidget());
}
