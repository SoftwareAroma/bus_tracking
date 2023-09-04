import 'package:bus_tracking/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {
  final String imageUrl;
  final Color? color;

  const OpaqueImage({
    Key? key,
    required this.imageUrl,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Image.asset(
        //   imageUrl,
        //   width: double.maxFinite,
        //   height: double.maxFinite,
        //   fit: BoxFit.cover,
        // ),
        CachedNetworkImage(
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (BuildContext context, String url) => Image.asset(
            Assets.imagesAccount,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          errorWidget: (BuildContext context, String url, dynamic) {
            return Image.asset(
              Assets.imagesAccount,
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
        ),
        Container(
          color: color?.withOpacity(0.85) ?? BrandColors.kColorDarkGreen.withOpacity(0.85),
        ),
      ],
    );
  }
}
