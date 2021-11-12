import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/ui/private_key_seed_phrase.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/face_id_button.dart';
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
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: () {
              showPrivateKeySeedPhrase(context, PrivateKeySeedPhraseBloc());
            },
            child: ButtonGold(title: S.current.continue_s, isEnable: true),
          ),
          SizedBox(
            height: 40.h,
          ),
          faceIDButton(),
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
                    AssetImage(ImageAssets.show),
                    color: Colors.grey,
                  )
                : const ImageIcon(
                    AssetImage(ImageAssets.hide),
                    color: Colors.grey,
                  ),
          ),
          prefixIcon: const ImageIcon(
            AssetImage(ImageAssets.lock),
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
