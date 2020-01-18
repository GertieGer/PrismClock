// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

//import 'hand.dart';


class WhiteLight extends StatelessWidget {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  // const DrawnStaticHand({
  //   this.color,
  //   this.accent,
  // });

  // final Color color;
  // final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _PolyPainter(
             lineWidth: 4,
             angleRadians: 0,
            //  color: color,
            //  accent: accent,
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
    // @required this.color,
    // @required this.accent,
  })  : assert(lineWidth != null);
        //assert(color != null);
        
  double lineWidth;
  double angleRadians;
  // Color color;
  // Color accent;

  
  @override
  void paint(Canvas canvas, Size size) {
  
    final opacity = 0.7;

    final Paint whitePaint = new Paint()
    ..color = Colors.white.withOpacity(opacity)
    ..style = PaintingStyle.fill;
  
    var whitePath = Path();
    whitePath.moveTo(0,size.height/2.03);
    whitePath.lineTo(0,size.height/2);
    whitePath.lineTo(size.width/6.2, size.height/2);
    whitePath.lineTo(size.width/6, size.height/2.1);
    whitePath.close();
    canvas.drawPath(whitePath, whitePaint);

    var redPath = Path();
    redPath.moveTo(size.width/4,size.height/2.3); //top right
    redPath.lineTo(size.width/3.95,size.height/2.27); //bottom right
    redPath.lineTo(size.width/6.2, size.height/2); //bottom left
    redPath.lineTo(size.width/6, size.height/2.1); //top left
    redPath.close();

    var greenPath = Path();
    greenPath.moveTo(size.width/4,size.height/2.27); //top right
    greenPath.lineTo(size.width/3.95,size.height/2.25); //bottom right
    greenPath.lineTo(size.width/6.2, size.height/2); //bottom left
    greenPath.lineTo(size.width/6, size.height/2.1); //top left
    greenPath.close();

    var bluePath = Path();
    bluePath.moveTo(size.width/4,size.height/2.25); //top right
    bluePath.lineTo(size.width/3.95,size.height/2.25); //bottom right
    bluePath.lineTo(size.width/6.2, size.height/2); //bottom left
    bluePath.lineTo(size.width/6, size.height/2.05); //top left
    bluePath.close();

    final Paint redPaint = new Paint()
    ..color = Color.fromRGBO(255, 0, 0, opacity)
    ..style = PaintingStyle.fill;
    final Paint greenPaint = new Paint()
    ..color = Color.fromRGBO(0, 255, 0, opacity)
    ..style = PaintingStyle.fill;
    final Paint bluePaint = new Paint()
    ..color = Color.fromRGBO(0, 0, 255, opacity)
    ..style = PaintingStyle.fill;
  
    
    canvas.drawPath(redPath, redPaint);
    canvas.drawPath(greenPath, greenPaint);
    canvas.drawPath(bluePath, bluePaint);

  
  }

  @override
  bool shouldRepaint(_PolyPainter oldDelegate) {
    return false;
  }
}
