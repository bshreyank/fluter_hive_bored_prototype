import 'package:flutter/material.dart';
import 'package:flutter_hive_bored/activity_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bored Activities',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityScreen(),
    );
  }
}
