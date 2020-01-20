// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import './rotateAnimatedContainer.dart';
import './static_hand.dart';
import './white_light.dart';
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
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());

    SystemChrome.setEnabledSystemUIOverlays([]);
    double safearea = 26; //THIS ISNT ACCTUALY TRUE
    final appHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - safearea;
    // notic this appHeight isn't accurate with safe area, thats 
    final appWidth = appHeight * (5 / 3);

    // Prism Position & size
    final prismPosition = EdgeInsets.only(top: 0, left: appWidth / 12.5);
    final prismSize = appHeight / 2;

    // Light Position
    final lightPosition = EdgeInsets.only(
        top: ((appHeight / 3) + prismSize / 4),
        left: prismPosition.left + (prismSize * 0.65));

    // Offset due to the Numbers
    final scaleOffset = 35;

    double getRadiansbyTime(double time, double type) {
      if (type == 60) {
        time += 1;
      } else {
        time += 1 / 60;
      }

      double angle = math.atan(
          (((appHeight) * (time) / type) - lightPosition.top) /
              (appWidth - lightPosition.left - scaleOffset));
      if (type == 60 && time < 29) {
        angle -= 0.01;
      } //small correction
      return angle;
    }

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/stars.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            WhiteLight(), // The light entering the prism
            Stack(
              children: [
                Container(
                  // HOUR HAND
                  margin: lightPosition,
                  child: RotatingHand(
                    duration: Duration(minutes: 1),
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(255, 0, 0, 1), //RED
                      accent: Color.fromRGBO(255, 50, 0, 1),
                    ),
                    angleRadians: getRadiansbyTime(
                        ((_now.hour >= 12 ? _now.hour - 12 : _now.hour) +
                            (_now.minute / 60)),
                        12),
                  ),
                ),
                Container(
                  // MINUTES HAND
                  margin: lightPosition,
                  child: RotatingHand(
                    duration: Duration(minutes: 1),
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(0, 255, 0, 1), //GREEN
                      accent: Color.fromRGBO(0, 255, 50, 1),
                    ),
                    angleRadians: getRadiansbyTime(_now.minute.toDouble(), 60),
                  ),
                ),
                Container(
                  //SECONDS HAND
                  margin: lightPosition,
                  child: RotatingHand(
                    duration: Duration(seconds: 1),
                    child: DrawnStaticHand(
                      color: Color.fromRGBO(0, 0, 255, 1), //BLUE
                      accent: Color.fromRGBO(50, 0, 255, 1),
                    ),
                    angleRadians:
                        getRadiansbyTime((_now.second).toDouble(), 60),
                  ),
                ),
              ],
            ),
            Row(
              // Numbers - Hours and minutes
              children: <Widget>[
                NumberColumn(),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            Column(
              //Prism Animation
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: prismPosition,
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
