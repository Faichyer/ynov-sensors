import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_push/screens/compass.dart';
import 'package:sensors/sensors.dart';

class Sensor extends StatefulWidget {
  @override
  _SensorState createState() => _SensorState();
}

class _SensorState extends State<Sensor> {

  List<double> _accelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {

    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(2))?.toList();
    final gyrX = gyroscope.getRange(0, 1);
    final gyrY = gyroscope.getRange(1, 2);
    final gyrZ = gyroscope.getRange(2, 3);

    return Scaffold(
      appBar: AppBar(
        title: Text("Ynov Sensors"),
        backgroundColor: Colors.cyan[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Gyroscope",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Color(0xff373876),
              decoration: TextDecoration.none)
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('X: $gyrX '),
                Text(' Y: $gyrY '),
                Text(' Z: $gyrZ'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Container(
            height: 200.0,
            child: Compass(),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x*100, event.y*100, event.z*100];
      });
    }));
  }
}