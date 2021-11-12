import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/ui/components/header.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

import 'components/header.dart';

class ConfirmPWShowPRVSeedPhr extends StatelessWidget {
  ConfirmPWShowPRVSeedPhr({required this.cubit, Key? key}) : super(key: key);

  late String password = 'Huydepzai1102.';
  final ConfirmPwPrvKeySeedpharseCubit cubit;
  TextEditingController controller = TextEditingController();

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
          headerPRVAndSeedPhr(
            leftFunction: () {
              Navigator.pop(context);
            },
            rightFunction: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            thickness: 1,
            color: AppTheme.getInstance().divideColor(),
          ),
          SizedBox(
            height: 24.h,
          ),
          formSetupPassWordConfirm(
            hintText: S.current.enter_password,
            controller: controller,
            isShow: true,
          ),
          SizedBox(
            height: 40.h,
          ),
          StreamBuilder<bool>(
            stream: cubit.isEnableBtnStream,
            builder: (context, snapshot) {
              return snapshot.data ?? false
                  ? ButtonGold(
                      title: S.current.continue_s,
                      isEnable: true,
                    )
                  : ButtonGold(
                      title: S.current.continue_s,
                      isEnable: false,
                    );
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          const Image(
            image: AssetImage(ImageAssets.faceID),
          ),
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
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: TextFormField(
        onChanged: (value) {
          cubit.isEnableButton(
            value: value,
          );
        },
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
