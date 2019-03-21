import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String path;
  final double height;

  CoverImage({
    Key key,
    this.path,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: AssetImage(path),
        ),
      ),
    );
  }
}
