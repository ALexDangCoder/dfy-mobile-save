import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluatorTab extends StatelessWidget {
  const EvaluatorTab({Key? key, required this.evaluatorsDetailModel})
      : super(key: key);
  final EvaluatorsDetailModel evaluatorsDetailModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceH20,
        title('Delivery/Collection'),
        spaceH10,
        InkWell(
          onTap: () {},
          child: item(
            ImageAssets.ic_map,
            'Physical Hard NFT asset is stored in ',
            script: evaluatorsDetailModel.storageLocation,
          ),
        ),
        spaceH10,
        InkWell(
          onTap: () {
            if (evaluatorsDetailModel.conditionDetail != '') {
              showInfo(context, evaluatorsDetailModel.conditionDetail ?? '');
            }
          },
          child: item(
            ImageAssets.ic_about_2,
            evaluatorsDetailModel.storageShortScrip ?? '',
            script: 'learn more',
          ),
        ),
        spaceH20,
        title('Protection and assurance'),
        spaceH10,
        item(ImageAssets.ic_crown, evaluatorsDetailModel.protection ?? ''),
        spaceH20,
        title('Storage'),
        spaceH10,
        item(
          ImageAssets.ic_receipt,
          'This item will be securely stored free of charge for the life of the NFT',
        ),
        spaceH40,
      ],
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: textNormalCustom(purple, 14, FontWeight.w400),
    );
  }

  Widget item(String image, String text, {String? script}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedPngImage(w: 16, h: 16, image: image),
        spaceW10,
        SizedBox(
          width: 315.w,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: textNormal(
                    Colors.white,
                    14,
                  ),
                ),
                if (script?.isNotEmpty ?? false)
                  TextSpan(
                    text: script,
                    style: textNormal(
                      amountColor,
                      14,
                    ).copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showInfo(BuildContext context, String textInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 20.h,bottom: 20.h,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          content: SizedBox(
              height: 310.h,
              width: 343.w,
              child: Column(
                children: [
                  Text(
                    'Description',
                    style: textNormal(
                      amountColor,
                      16,
                    ),
                  ),
                  spaceH10,
                  SizedBox(
                    height: 280.h,
                    width: 343.w,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                      ),
                      child: Text(
                        textInfo,
                        style: textNormal(
                          Colors.white,
                          14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        );
      },
    );
  }
}
