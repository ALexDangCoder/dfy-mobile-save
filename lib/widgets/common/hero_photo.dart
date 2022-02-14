import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoHero extends StatelessWidget {
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

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: typeImage == TypeImage.IMAGE ? Image.network(
              photo,
              fit: BoxFit.cover,
            ) : Container(
              color: Colors.black,
              child: Center(
                child: Icon(
                  Icons.play_circle_outline_sharp,
                  size: 34.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
