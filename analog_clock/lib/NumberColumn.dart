import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Widget> scalemaker(int len, double size, int start, int spacing){
      List<Widget> numList = [];
      for (int num = start; num < len; num+=spacing) {
        numList.add(
          Text(
            num.toString(),
            style: GoogleFonts.montserrat(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: size,
                color: Colors.grey,
              ),
            ),
          ),
        );
      }
      return numList;
    }
    return Row(
      children: <Widget>[
        Column(
          children: scalemaker(60,10.0,5,5),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Column(
          children: scalemaker(12,18.0,1,1),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ],
    );
  }
}
