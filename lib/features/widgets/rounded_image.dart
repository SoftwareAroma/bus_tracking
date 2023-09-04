import 'package:bus_tracking/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imagePath;
  final Size size;

  const RoundedImage({
    Key? key,
    required this.imagePath,
    this.size = const Size.fromWidth(120),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        width: size.width,
        height: 100.0,
        imageUrl: imagePath,
        fit: BoxFit.fitWidth,
        placeholder: (context, url) => Image.asset(
          Assets.imagesAccount,
          width: size.width,
          height: 100.0,
        ),
        errorWidget: (context, url, dynamic) {
          return Image.asset(
            Assets.imagesAccount,
            width: size.width,
            height: 100.0,
          );
        },
      ),
      // child: Image.asset(
      //   imagePath,
      //   width: size.width,
      //   height: size.width,
      //   fit: BoxFit.fitWidth,
      // ),
    );
  }
}
