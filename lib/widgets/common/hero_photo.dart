import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class PhotoHero extends StatefulWidget {
  const PhotoHero({
    Key? key,
    required this.photo,
    required this.onTap,
    required this.width,
    required this.typeImage,
  }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final TypeImage typeImage;

  @override
  _PhotoHeroState createState() => _PhotoHeroState();
}

class _PhotoHeroState extends State<PhotoHero> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Hero(
        tag: widget.photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: widget.onTap,
              child: FadeInImage.assetNetwork(
                placeholder: ImageAssets.image_loading,
                image: widget.photo,
                imageCacheHeight: 2000,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.getInstance().backgroundBTSColor(),
                ),
              )),
        ),
      ),
    );
  }
}
