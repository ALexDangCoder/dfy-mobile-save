import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl extends StatelessWidget {
  final String? urlFace;
  final String? urlTelegram;
  final String? urlTwitter;
  final String? urlInstagram;

  const LaunchUrl(
      {Key? key,
      this.urlFace,
      this.urlTelegram,
      this.urlTwitter,
      this.urlInstagram})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: urlFace?.isEmpty ?? true ? 0 : 14.w,
            left: urlFace?.isEmpty ?? true ? 0 : 14.w,
          ),
          child: urlFace?.isEmpty ?? true
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    _launchURL(urlFace ?? '');
                  },
                  child: Image.asset(
                    ImageAssets.img_facebook,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: urlInstagram?.isEmpty ?? true ? 0 : 14.w,
            left: urlInstagram?.isEmpty ?? true ? 0 : 14.w,
          ),
          child: urlInstagram?.isEmpty ?? true
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    _launchURL(urlInstagram ?? '');
                  },
                  child: Image.asset(
                    ImageAssets.img_instagram,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: urlTwitter?.isEmpty ?? true ? 0 : 14.w,
            left: urlTwitter?.isEmpty ?? true ? 0 : 14.w,
          ),
          child: urlTwitter?.isEmpty ?? true
              ? null
              : GestureDetector(
                  onTap: () {
                    _launchURL(urlTwitter ?? '');
                  },
                  child: Image.asset(
                    ImageAssets.img_twitter,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: urlTelegram?.isEmpty ?? true ? 0 : 14.w,
            left: urlTelegram?.isEmpty ?? true ? 0 : 14.w,
          ),
          child: urlTelegram?.isEmpty ?? true
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    _launchURL(urlTelegram ?? '');
                  },
                  child: Image.asset(
                    ImageAssets.img_telegram,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Could not launch $url>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>';
    }
  }
}
