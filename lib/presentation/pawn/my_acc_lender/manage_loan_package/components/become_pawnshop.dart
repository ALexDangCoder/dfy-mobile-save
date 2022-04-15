import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BecomeAPawnShop extends StatelessWidget {
  const BecomeAPawnShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
        title: 'Become a pawnshop',
        isImage: true,
        onRightClick: () {
          Navigator.pop(context);
        },
        text: ImageAssets.ic_close,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 117.h,),
              SizedBox(
                height: 138.h,
                width: 215.w,
                child: Image.asset(ImageAssets.becomeAPawnShop),
              ),
              spaceH24,
              Text(
                'You are not a pawnshop',
                style: textNormalCustom(
                  null,
                  16,
                  FontWeight.w600,
                ),
              ),
              spaceH24,
              InkWell(
                onTap: () {
                  launch(
                    '${Get.find<AppConstants>().basePawnUrl}/pawn/shop',
                  );
                },
                child: SizedBox(
                  width: 174.w,
                  child: const ButtonGold(
                    haveMargin: false,
                    fixSize: false,
                    isEnable: true,
                    title: 'Become a pawnshop',
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
