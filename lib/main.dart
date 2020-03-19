import 'package:flutter/material.dart';
import 'package:notification_push/screens/gyroscope.dart';
import 'package:notification_push/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification push',
      home: Sensor(),
    );
  }
}
