import 'package:flutter/material.dart';
import 'dart:ui';


Widget redCircle = CustomPaint(
  size: Size(window.physicalSize.height*(5/3), window.physicalSize.height),
  painter: RedPainter(),
);

class RedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    var circle = Offset.zero;
   
    // var gradient = RadialGradient(
    //   center: const Alignment(0.7, -0.6),
    //   radius: 0.2,
    //   colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
    //   stops: [0.4, 1.0],
    // );
    // canvas.drawRect(
    //   rect,
    //   Paint()..shader = gradient.createShader(rect),
    // );
    Paint paint = Paint()
    ..color = Color.fromRGBO(255, 0, 0, 1);
    //..blendMode = BlendMode.multiply;
    path.addPolygon([Offset.zero,Offset(size.width,0),Offset(size.width, 50.0)], true);
    canvas.drawPath(path, paint);
    //canvas.drawCircle(circle, 100.0, paint);

    
  }

  @override
  bool shouldRepaint(RedPainter oldDelegate) => false;
}

Widget blueCircle = CustomPaint(
  size: Size(300, 300),
  painter: BluePainter(),
);

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var circle = Offset(100, 0);
    Paint paint = Paint()
    ..color = Color.fromRGBO(0, 0, 255, 1)
    ..blendMode = BlendMode.screen;

    canvas.drawCircle(circle, 100.0, paint);
  }

  @override
  bool shouldRepaint(BluePainter oldDelegate) => false;
}

Widget greenCircle = CustomPaint(
  size: Size(300, 300),
  painter: GreenPainter(),
);

class GreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var circle = Offset(50, 100);
    Paint paint = Paint()
    ..color = Color.fromRGBO(0, 255, 0, 1)
    ..blendMode = BlendMode.screen;

    canvas.drawCircle(circle, 100.0, paint);
  }

  @override
  bool shouldRepaint(GreenPainter oldDelegate) => false;
}

