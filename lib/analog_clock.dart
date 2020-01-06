import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'draw_clockface.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class AnalogClock extends StatefulWidget {
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();

    // Set the initial values.
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update every 10 milliseconds to give appearance of a smooth rotation.
      _timer = Timer(
        Duration(milliseconds: 10),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x40aaffc3),
      child: Center(
        child: DrawClockFace(
            (_now.second + _now.millisecond / 1000) * radiansPerTick,
            (_now.minute + _now.second / 60) * radiansPerTick,
            _now.hour * radiansPerHour + (_now.minute / 60) * radiansPerHour),
      ),
    );
  }
}
