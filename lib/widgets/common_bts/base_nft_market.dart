import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// use for common bottom sheet
/// child is a Column
/// padding bottom is 38, use common for bts have button
/// if has right icon or text, assign value for arg text
/// if this is arg text is image isImage = true, opposite with text
class BaseNFTMarket extends StatelessWidget {
  final String title;
  final Widget child;
  final Function() filterFunc;

  const BaseNFTMarket({
    Key? key,
    required this.title,
    required this.child,
    required this.filterFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      //width: 375.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 360.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  child: Image.network(
                    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 16.h,
                top: 16.h,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: roundButton(image: ImageAssets.ic_btn_back_svg),
                ),
              ),
              Positioned(
                right: 16.h,
                top: 16.h,
                child: InkWell(
                  onTap: filterFunc,
                  child: roundButton(image: ImageAssets.ic_filter_svg),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8.h,
              left: 16.h,
              right: 16.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: tokenDetailAmount(),
                  ),
                ),
                SizedBox(
                  width: 25.h,
                ),
                InkWell(
                  onTap: () {},
                  child: roundButton(
                    image: ImageAssets.ic_flag_svg,
                    whiteBackground: true,
                  ),
                ),
                SizedBox(
                  width: 20.h,
                ),
                InkWell(
                  onTap: () {},
                  child: roundButton(
                    image: ImageAssets.ic_share_svg,
                    whiteBackground: true,
                  ),
                ),

              ],
            ),
          ),
          line,
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget roundButton({
    required String image,
    bool whiteBackground = false,
  }) {
    return Container(
      padding: EdgeInsets.all(4.h),
      height: 32.h,
      width: 32.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: whiteBackground
            ? AppTheme.getInstance().whiteBackgroundButtonColor()
            : AppTheme.getInstance().backgroundButtonColor(),
      ),
      child: Center(
        child: SvgPicture.asset(
          image,
        ),
      ),
    );
  }
}
