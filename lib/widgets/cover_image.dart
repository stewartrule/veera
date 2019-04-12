import 'package:flutter/material.dart';

import '../models/image_model.dart';
import '../app_config.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key key,
    @required this.image,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: image.getColor(),
      ),
      child: Stack(
        children: <Widget>[
          FadeInImage(
            width: double.infinity,
            height: double.infinity,
            placeholder: AssetImage('assets/images/1x1.png'),
            fit: BoxFit.cover,
            image: NetworkImage("${config.cdnUrl}/images/${image.src}"),
          ),
        ],
      ),
    );
  }
}
