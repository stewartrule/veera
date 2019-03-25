import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String src;
  final EdgeInsets margin;
  final double size;

  Avatar({
    Key key,
    this.src,
    this.size = 48,
    this.margin = const EdgeInsets.only(right: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(src),
        ),
      ),
    );
  }
}
