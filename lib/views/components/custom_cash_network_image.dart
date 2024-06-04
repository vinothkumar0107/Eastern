import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/my_images.dart';

import 'image_loader.dart';



class CustomCashNetworkImage extends StatelessWidget {

  final double? imageHeight;
  final double? imageWidth;
  final String imageUrl;
  final Widget? imageBuilder;
  final double borderRadius;
  final BorderRadius? customBorderRadius;
  final BoxFit? boxFit;

  const CustomCashNetworkImage({
    super.key,
    this.imageHeight,
    this.imageWidth,
    required this.imageUrl,
    this.imageBuilder,
    this.borderRadius = 4,
    this.customBorderRadius,
    this.boxFit = BoxFit.cover
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: customBorderRadius != null ? customBorderRadius! : BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: imageHeight,
        width: imageWidth,
        fit: boxFit,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CustomImageLoader(),
        errorWidget: (context, url, error) => Image.asset(MyImages.defaultImage,width: imageWidth,height: imageHeight,),
      ),
    );
  }
}


