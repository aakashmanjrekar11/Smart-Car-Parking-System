import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color cardColour;
  final Widget cardChild;
  final Function onPress;
  final Color gradient1;
  final Color gradient2;

  ReusableCard({
    @required this.cardChild,
    this.cardColour,
    this.onPress,
    this.gradient1,
    this.gradient2,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> _colors = [gradient1, gradient2];
    List<double> _stops = [0.0, 0.7];

    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, -1.0),
            end: Alignment(1.0, 1.0),
            colors: _colors,
            stops: _stops,
          ),
          color: cardColour,
          borderRadius: BorderRadius.circular(11.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7090B0), //Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 8), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
