import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class currencyValues extends StatelessWidget {
  final String value;
  final String title;

  const currencyValues({
    Key key,
    this.value,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(

        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white30,
              width: 2,
            ),
          ),
        ),
      ),

      Text(title,
          style: GoogleFonts.thasadith(fontWeight: FontWeight.bold, color: Colors.black)),
      Text(value, style: GoogleFonts.thasadith(fontWeight: FontWeight.bold, color: Colors.black)),
    ]);
  }
}
