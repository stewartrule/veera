import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final int factor;

  Heading(
    this.text, {
    Key key,
    this.factor = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: (10 + (factor * 5)).toDouble(),
      ),
    );
  }
}
