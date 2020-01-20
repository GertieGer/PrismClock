import 'package:flutter/material.dart';
class RotatingHand extends StatelessWidget{

  RotatingHand({
    this.angleRadians,
    this.duration,
    this.child,
  })  : assert(angleRadians != null);

  final Duration duration;
  final double angleRadians;
  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
          transform: Matrix4.rotationZ(angleRadians),
          duration: (angleRadians!=0? duration : Duration(milliseconds: 950)),
          child: child,
        );
  }
}
