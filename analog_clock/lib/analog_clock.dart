// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:flare_flutter/flare_actor.dart';

import './rotateAnimatedContainer.dart';
import './static_hand.dart';
import 'NumberColumn.dart';
import 'dart:math' as math;

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      //print(_now);
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.black,
            // Minute hand.
            highlightColor: Colors.black,
            // Second hand.
            accentColor: Colors.black,
            //backgroundColor: Color(0xFFD2E3FC),
            backgroundColor: Colors.black,
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: customTheme.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_temperatureRange),
          Text(_condition),
          Text(_location),
        ],
      ),
    );

    final appHeight = MediaQuery.of(context).size.height;
    final appWidth = appHeight * (5 / 3);

    final prismPosition = EdgeInsets.only(top: appHeight / 3, left: 0);
    final prismSize = appHeight / 2.5;

    final lightPosition = EdgeInsets.only(
        top: (prismPosition.top + prismSize / 4), left: prismSize * 0.6);
    final scaleOffset = 26;

    double getRadiansbyTime(double time) {
      return math.atan(((appHeight * (time+1) / 60) - lightPosition.top) /
          (appWidth - lightPosition.left - scaleOffset));
    }

    final double startAngle = getRadiansbyTime(-1.0);
    final double endAngle = getRadiansbyTime(59);
    final double totalAngle = startAngle - endAngle;

    //print("end: "+endAngle.toString());

    // final radiansPerTick = radians(360 / 60);
    //final radiansPerHour = radians(360 / 12);

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: customTheme.backgroundColor,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  margin: lightPosition,
                  child: RotatingHand(
                    duration: Duration(minutes: 1),
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(255, 0, 0, 1), //RED - HOURS
                      accent: Color.fromRGBO(255, 50, 0, 1),
                    ),
                    angleRadians: getRadiansbyTime(
                        (_now.hour > 12 ? _now.hour - 12 : _now.hour) +
                            (_now.minute / 60)),
                  ),
                ),
                Container(
                  margin: lightPosition,
                  child: RotatingHand(
                    //duration: Duration(minutes: 1),
                    duration: Duration(seconds: 1), //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(0, 255, 0, 1), //GREEN - MINUTES
                      accent: Color.fromRGBO(0, 255, 50, 1),
                    ),
                    //angleRadians: (_now.minute * radiansPerTick),
                    //angleRadians: getRadiansbyTime(_now.minute.toDouble()),
                    angleRadians: startAngle,
                  ),
                ),
                Container(
                  margin: lightPosition,
                  child: RotatingHand(
                    duration: Duration(seconds: 1),
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(0, 0, 255, 1), //BLUE - SECONDS
                      accent: Color.fromRGBO(50, 0, 255, 1),
                    ),
                    //angleRadians: (_now.second * radiansPerTick),
                    //angleRadians: getRadiansbyTime(_now.second.toDouble()),
                    angleRadians: endAngle,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  child: Text(
                    _now.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  onPressed: () => {},
                ),
                NumberColumn(),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FlareActor("assets/prism.flr",
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.contain,
                      animation: "spin"),
                  height: prismSize,
                  width: prismSize,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
