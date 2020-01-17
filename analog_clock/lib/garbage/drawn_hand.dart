// // Copyright 2019 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'dart:math' as math;
// import 'dart:ui';
// import 'package:flutter/material.dart';

// import 'hand.dart';

// class DrawnHand extends Hand {

//   const DrawnHand({
//     @required Color color,
//     @required this.thickness,
//     @required double size,
//     @required double angleRadians,
//   })  : assert(color != null),
//         assert(thickness != null),
//         assert(size != null),
//         assert(angleRadians != null),
//         super(
//           color: color,
//           size: size,
//           angleRadians: angleRadians,
//         );

//   /// How thick the hand should be drawn, in logical pixels.
//   final double thickness;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox.expand(
//         child: CustomPaint(
//           size: Size(window.physicalSize.height*(5/3), window.physicalSize.height),
//           painter: _PolyPainter(
//              handSize: size,
//              lineWidth: thickness,
//              angleRadians: angleRadians,
//              color: color,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// [CustomPainter] that draws a clock hand.
// class _PolyPainter extends CustomPainter {
//   _PolyPainter({
//     @required this.handSize,
//     @required this.lineWidth,
//     @required this.angleRadians,
//     @required this.color,
//   })  : assert(handSize != null),
//         assert(lineWidth != null),
//         assert(angleRadians != null),
//         assert(color != null),
//         assert(handSize >= 0.0),
//         assert(handSize <= 1.0);

//   double handSize;
//   double lineWidth;
//   double angleRadians;
//   Color color;

  
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = (Offset.zero & size).center;
//     // We want to start at the top, not at the x-axis, so add pi/2.
//     //final angle = (angleRadians) / 4;
//     final angle = (angleRadians) / 4;
//     //final length = size.shortestSide * 0.5 * handSize;
//     final length = size.longestSide * 2;

//     //canvas.drawLine(center, position, linePaint);
//     Path path = Path();
//     Paint paint = Paint()
//     ..color = color
//     ..blendMode = BlendMode.screen;
//     //..color = Color.fromRGBO(255, 0, 0, 1);
//     //path.addPolygon([Offset.zero,Offset(size.width,0),Offset(size.width, 50.0)], true);
//     path.addPolygon([
//       Offset.zero,
//       Offset(math.cos(angle),math.sin(angle)) * length,
//       Offset(math.cos(angle+0.2),math.sin(angle+0.2)) * length,], 
//       true);
//     canvas.drawPath(path, paint);

//   }

//   @override
//   bool shouldRepaint(_PolyPainter oldDelegate) {
//     return oldDelegate.handSize != handSize ||
//         oldDelegate.lineWidth != lineWidth ||
//         oldDelegate.angleRadians != angleRadians ||
//         oldDelegate.color != color;
//   }
// }
