import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OfferTab extends StatelessWidget {
  const OfferTab({Key? key, required this.listOffer}) : super(key: key);
  final List<OfferDetail> listOffer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const ScrollPhysics(),
      itemCount: listOffer.length,
      itemBuilder: (context, index) {
        return _buildItemOffer(listOffer[index]);
      },
    );
  }

  Widget _buildItemOffer(OfferDetail objOffer) {
    final String duration = (objOffer.durationType == 0) ? 'week' : 'month';
    return BaseItem(
      child: GestureDetector(
        onTap: (){
          /// push to Offer detail
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    '${objOffer.addressLender}'.handleString(),
                    style: richTextWhite.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'offered',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '${objOffer.supplyCurrency?.amount ?? ''} '
                              '${objOffer.supplyCurrency?.symbol ?? ''}',
                          style: textNormal(
                            amountColor,
                            14,
                          ),
                        ),
                        TextSpan(
                          text: 'with a ${objOffer.duration ?? ''} $duration',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'loan term',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ImageIcon(
                const AssetImage(ImageAssets.ic_line_right),
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
