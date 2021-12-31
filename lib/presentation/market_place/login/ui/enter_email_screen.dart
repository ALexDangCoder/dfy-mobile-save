import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/ui/confirm_email.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.continue_s,
        isEnable: true,
        onTap: () {
          //todo:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConfirmEmail(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
        ],
        child: BaseBottomSheet(
          title: S.current.enter_email,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Text(
                  S.current.enter_email_to_link,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ),
                ),
              ),
              Container(
                height: 64.h,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().itemBtsColors(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                  ),
                  controller: textEditingController,
                  cursorColor: AppTheme.getInstance().textThemeColor(),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16.sp,
                    ),
                    prefixIcon: ImageIcon(
                      const AssetImage(ImageAssets.ic_email),
                      color: AppTheme.getInstance().textThemeColor(),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
