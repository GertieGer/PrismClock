// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';
import 'package:flutter/material.dart';

class WhiteLight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _PolyPainter(
            lineWidth: 4,
            angleRadians: 0,
          ),
        ),
      ),
    );
  }
}

class _PolyPainter extends CustomPainter {
  _PolyPainter({
    @required this.lineWidth,
    @required this.angleRadians,
  }) : assert(lineWidth != null);

  double lineWidth;
  double angleRadians;

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = 0.7;

    final Paint whitePaint = new Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    var whitePath = Path();
    whitePath.moveTo(0, size.height / 2.23);
    whitePath.lineTo(0, size.height / 2.2);
    whitePath.lineTo(size.width / 6.27, size.height / 2.02);
    whitePath.lineTo(size.width / 6, size.height / 2.1);
    whitePath.close();
    canvas.drawPath(whitePath, whitePaint);

    var redPath = Path();
    redPath.moveTo(size.width / 3.5, size.height / 2.19); //top right
    redPath.lineTo(size.width / 3.5, size.height / 2.18); //bottom right
    redPath.lineTo(size.width / 6.25, size.height / 2.02); //bottom left
    redPath.lineTo(size.width / 6, size.height / 2.1); //top left
    redPath.close();

    var greenPath = Path();
    greenPath.moveTo(size.width / 3.5, size.height / 2.18); //top right
    greenPath.lineTo(size.width / 3.5, size.height / 2.16); //bottom right
    greenPath.lineTo(size.width / 6.28, size.height / 2.02); //bottom left
    greenPath.lineTo(size.width / 6.05, size.height / 2.08); //top left
    greenPath.close();

    var bluePath = Path();
    bluePath.moveTo(size.width / 3.6, size.height / 2.16); //top right
    bluePath.lineTo(size.width / 3.5, size.height / 2.12); //bottom right
    bluePath.lineTo(size.width / 6.2, size.height / 2.02); //bottom left
    bluePath.lineTo(size.width / 6.1, size.height / 2.05); //top left
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
