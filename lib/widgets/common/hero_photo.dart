import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.photo)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
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
            child: widget.typeImage == TypeImage.IMAGE
                ? Image.network(
                    widget.photo,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        VideoPlayer(controller),
                        Center(
                          child: Icon(
                            Icons.play_circle_outline_sharp,
                            size: 34.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
