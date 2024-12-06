import 'package:bloc_api/app.dart';
import 'package:bloc_api/persistent/hive_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Hive.openBox<String>(kBoxNameForUserToken);
  runApp(const MyApp());
}
