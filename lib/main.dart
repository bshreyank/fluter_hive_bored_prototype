import 'package:flutter/material.dart';
import 'package:flutter_hive_bored/model/activity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ActivityImplAdapter()); // Register the ActivityAdapter
  runApp(ProviderScope(child: MyApp()));
}
