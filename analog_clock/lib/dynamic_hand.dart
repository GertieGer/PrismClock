// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'hand.dart';


class DrawnStaticHand extends StatelessWidget {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  const DrawnStaticHand({
    this.color,
    this.accent,
    this.position,
    this.angleRadians,
  });

  final Color color;
  final Color accent;
  final Offset position;
  final double angleRadians;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _PolyPainter(
             lineWidth: 4,
             angleRadians: angleRadians,
             color: color,
             accent: accent,
             position: position,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _PolyPainter extends CustomPainter {
  _PolyPainter({
    @required this.lineWidth,
    @required this.angleRadians,
    @required this.color,
    @required this.position,
    @required this.accent,
  })  : assert(lineWidth != null),
        assert(color != null);
        
  double lineWidth;
  double angleRadians;
  Color color;
  Color accent;
  Offset position;
  

  
  @override
  void paint(Canvas canvas, Size size) {
  
    final length = size.longestSide;

    Rect rect = new Rect.fromCircle(
      center: position,
      radius: length*1.5,
    );

    final Gradient gradient = new SweepGradient(
      center: FractionalOffset.center,
      startAngle: angleRadians,
      endAngle: angleRadians+math.pi/12,
      colors: <Color>[
        accent.withOpacity(0.9),
        accent.withOpacity(0.9),
        color.withOpacity(0.95),
        color.withOpacity(0.8),
        accent.withOpacity(0.7),
        accent.withOpacity(0.5),
      ],
      stops: [
        0.0,
        0.1,
        0.2,
        0.7,
        0.8,
        9,
      ],
    );

    // create the Shader from the gradient and the bounding square
    final Paint paint = new Paint()
    ..shader = gradient.createShader(rect)
    ..blendMode = (color == Color.fromRGBO(0, 0, 0, 1)) ? BlendMode.clear : BlendMode.screen;

    // and draw an arc
    canvas.drawArc(rect, angleRadians, angleRadians+math.pi/12, true, paint);
  }

  @override
  bool shouldRepaint(_PolyPainter oldDelegate) {
    return
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.angleRadians != angleRadians ||
        oldDelegate.color != color;
  }
}
