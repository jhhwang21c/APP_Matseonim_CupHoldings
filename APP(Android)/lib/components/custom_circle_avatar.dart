import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double size;
  final String url;

  const CustomCircleAvatar({Key? key, required this.size, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => const CircleAvatar(
          backgroundImage: AssetImage("assets/images/temp_avatar.png")
        ),
        errorWidget: (context, url, error) => const CircleAvatar(
          backgroundImage: AssetImage("assets/images/temp_avatar.png")
        )
      )
    );
  }
}
