import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/ui/private_key_seed_phrase.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPWShowPRVSeedPhr extends StatelessWidget {
  ConfirmPWShowPRVSeedPhr({required this.cubit, Key? key}) : super(key: key);

  late String password = 'Huydepzai1102.';
  final ConfirmPwPrvKeySeedpharseCubit cubit;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.prv_key_ft_seed_phr,
      text: ImageAssets.ic_close,
      isImage: true,
      callback: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          spaceH24,
          formSetupPassWordConfirm(
            hintText: S.current.enter_password,
            controller: controller,
            isShow: true,
          ),
          SizedBox(
            height: 40.h,
          ),
          // cubit.isEnableBtnStream,
          StreamBuilder<bool>(
            stream: cubit.isEnableBtnStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  if (snapshot.data ?? false) {
                    showPrivateKeySeedPhrase(
                        context, PrivateKeySeedPhraseBloc());
                  }
                },
                child: ButtonGold(
                  title: S.current.continue_s,
                  isEnable: snapshot.data ?? false,
                ),
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
      width: 343.w,
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
          16,
        ),
        cursorColor: Colors.white,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textNormal(
            Colors.grey,
            14,
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
