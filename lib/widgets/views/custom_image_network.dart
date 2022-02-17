import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_gifs/loading_gifs.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    Key? key,
    required this.image,
    this.fit, this.placeholderImage ,
  }) : super(key: key);
  final String image;
  final BoxFit? fit;
  final String? placeholderImage;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeholderImage ??  cupertinoActivityIndicatorSmall ,
      image: image,
      fit: fit ?? BoxFit.fitWidth,
      imageErrorBuilder: (context, error, stackTrace) => Container(
        color: AppTheme.getInstance().backgroundBTSColor(),
      ),
    );
  }
}
