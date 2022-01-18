import 'package:flutter/cupertino.dart';
import 'package:loading_gifs/loading_gifs.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    Key? key,
    required this.image,
    this.fit = BoxFit.fitWidth,
  }) : super(key: key);
  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: cupertinoActivityIndicatorSmall,
      image: image,
      fit: fit,
    );
  }
}
