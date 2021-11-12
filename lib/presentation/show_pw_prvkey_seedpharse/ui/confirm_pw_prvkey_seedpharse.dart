import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

import 'components/header.dart';

class ConfirmPWShowPRVSeedPhr extends StatelessWidget {
  const ConfirmPWShowPRVSeedPhr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 764.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(62, 61, 92, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          headerPRVAndSeedPhr(leftFunction: () {}, rightFunction: () {}),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(255, 255, 255, 0.1),
          ),
          SizedBox(
            height: 24.h,
          ),
          formSetupPassWordConfirm(
            hintText: S.current.enter_password,
            controller: TextEditingController(),
            isShow: true,
          ),
          SizedBox(height: 40.h,),
          ButtonGold(title: S.current.continue_s, isEnable: true),
          SizedBox(height: 40.h,),
          const Image(image: AssetImage(ImageAssets.faceID),),
        ],
      ),
    );
  }

  Container formSetupPassWordConfirm({
    required String hintText,
    required TextEditingController controller,
    required bool isShow,
  }) {
    return Container(
      height: 64.h,
      width: 323.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: TextFormField(
        style: textNormal(
          Colors.white,
          16.sp,
        ),
        cursorColor: Colors.white,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textNormal(
            Colors.grey,
            14.sp,
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: isShow
                ? const ImageIcon(
                    AssetImage(ImageAssets.ic_show),
                    color: Colors.grey,
                  )
                : const ImageIcon(
                    AssetImage(ImageAssets.ic_hide),
                    color: Colors.grey,
                  ),
          ),
          prefixIcon: const ImageIcon(
            AssetImage(ImageAssets.ic_lock),
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
