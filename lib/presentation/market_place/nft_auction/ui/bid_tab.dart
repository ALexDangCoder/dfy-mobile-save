import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BidTab extends StatelessWidget {
  const BidTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildItemBid(index);
      },
    );
  }

  Widget _buildItemBid(int index) {
    return Container(
      height: 68.h,
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '0xFE5...4fd0 bid',
                        style: richTextWhite.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH7,
                Text(
                  DateTime.now().toString(),
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    14,
                    FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    sizedSvgImage(
                      w: 20,
                      h: 20,
                      image: ImageAssets.ic_token_dfy_svg,
                    ),
                    spaceW4,
                    Text(
                      '0.0025 ETH',
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                spaceH7,
                Text(
                  'Wining',
                  style: textNormalCustom(
                    const Color(0xff61C777),
                    14,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
