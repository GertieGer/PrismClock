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
    this.size,
    this.thickness,
  });

  final Color color;
  final double size;
  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          //size: Size(window.physicalSize.height*(5/3), window.physicalSize.height),
          painter: _PolyPainter(
             lineWidth: thickness,
             angleRadians: 0,
             color: color,
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
  })  : assert(lineWidth != null),
        assert(color != null);
        
  double lineWidth;
  double angleRadians;
  Color color;

  
  @override
  void paint(Canvas canvas, Size size) {
    final angle = angleRadians;
    final length = size.longestSide * 2;
    


    Path polyPath = Path();
    polyPath.addPolygon([
      Offset.zero,
      Offset(math.cos(angle),math.sin(angle)) * length,
      Offset(math.cos(angle+0.2),math.sin(angle+0.2)) * length,], 
      true);

    Paint polyPaint = Paint()
    ..color = color
    ..blendMode = (color == Color.fromRGBO(0, 0, 0, 1)) ? BlendMode.clear : BlendMode.screen;
    
    canvas.drawPath(polyPath, polyPaint);

    Path shinePath = Path();
    shinePath.addPolygon([
      Offset.zero,
      Offset(math.cos(angle+0.01),math.sin(angle+0.01)) * length,
      Offset(math.cos(angle+0.04),math.sin(angle+0.04)) * length,], 
      true);

    Paint shinePaint = Paint()
    ..color = Color.fromRGBO(255, 255, 255, 0.15);
    canvas.drawPath(shinePath, shinePaint);
 
  }

  @override
  bool shouldRepaint(_PolyPainter oldDelegate) {
    return
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.angleRadians != angleRadians ||
        oldDelegate.color != color;
  }
}
