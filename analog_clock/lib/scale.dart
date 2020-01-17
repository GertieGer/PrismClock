// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';
import 'package:flutter/material.dart';


class ScaleMark extends StatelessWidget {
  
   const ScaleMark({
    this.size,
  });

  final Color color = Colors.white;
  final double size;
  /// How thick the hand should be drawn, in logical pixels.
  final double thickness = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          size: Size(window.physicalSize.height*(5/3), window.physicalSize.height),
          painter: _ScalePainter(
             lineWidth: thickness,
             size: size,
             color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _ScalePainter extends CustomPainter {
  _ScalePainter({
    @required this.lineWidth,
    @required this.size,
    @required this.color,
  })  : assert(lineWidth != null),
        assert(color != null);
        
  double lineWidth;
  double size;
  Color color;

  
  @override
  void paint(Canvas canvas, Size size) {
    final diff = size.shortestSide/12;
    final rightside = size.longestSide;
    Rect rect; 
    double short = 10;
    double long = 20;
    double thickness = 5.0;


    Path path = Path();
    for (var i = 0; i <= 12; i++) {
      double len = (i%3==0)? long : short;
      rect = Offset(rightside-len, i*diff-(thickness/2)) & Size(len, 5.0);
      path.addRect(rect);
    }

    Paint paint = Paint()
    ..color = color;

    canvas.drawPath(path, paint);

 
  }

  @override
  bool shouldRepaint(_ScalePainter oldDelegate) {
    return
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.size != size ||
        oldDelegate.color != color;
  }
}
