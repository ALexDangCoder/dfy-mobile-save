import 'package:Dfy/config/themes/app_theme.dart';
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
      imageErrorBuilder: (context, error, stackTrace) => Container(
        color: AppTheme.getInstance().backgroundBTSColor(),
      ),
    );
  }
}
