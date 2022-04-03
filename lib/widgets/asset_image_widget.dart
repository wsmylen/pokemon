import 'package:flutter/material.dart';

class ImageAssetWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String asset;
  final BoxFit fit;

  const ImageAssetWidget({
    Key? key,
    this.width,
    this.height,
    this.color,
    required this.asset,
    required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image(
        image: AssetImage(asset),
        fit: fit,
        color: color,
      ),
    );
  }
}
