import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/confirm_email.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EnterEmail extends StatefulWidget {
  const EnterEmail({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  late final LoginWithEmailCubit cubit;
  final TextEditingController emailEditingController = TextEditingController();
  bool isValidateSuccess = false;

  @override
  void initState() {
    super.initState();
    cubit = LoginWithEmailCubit();
    cubit.validateStream.listen((event) {
      if (event == '') {
        isValidateSuccess = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.continue_s,
        isEnable: true,
        onTap: () async {
          //todo:
          final nav = Navigator.of(context);
          if (isValidateSuccess) {
            final bool checkValidate =
                cubit.checkValidate(emailEditingController.value.text);
            if (checkValidate) {
              showLoading(context);
              final String transactionId = await cubit.sendOTP(
                email: emailEditingController.value.text,
                type: 1,
              );
              hideLoading(context);

              if (transactionId.isNotEmpty) {
                unawaited(
                  nav.push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmEmail(
                        transactionId: transactionId,
                        email: emailEditingController.value.text,
                      ),
                    ),
                  ).then(
                    (value) => {
                      if (value) {Navigator.pop(context, true)}
                    },
                  ),
                );
              }
            }
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: KeyboardDismisser(
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
                    16,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 64.h,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
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
                      onChanged: (value) {
                        cubit.checkValidate(value);
                      },
                      controller: emailEditingController,
                      cursorColor: AppTheme.getInstance().textThemeColor(),
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        counterText: '',
                        hintStyle: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        prefixIcon: ImageIcon(
                          const AssetImage(ImageAssets.ic_email),
                          color: AppTheme.getInstance().textThemeColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  StreamBuilder<String>(
                      stream: cubit.validateStream,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4,
                          ),
                          child: Text(
                            //todo
                            snapshot.data ?? '',
                            // state.errText,
                            style: textNormal(
                              AppTheme.getInstance().wrongColor(),
                              12,
                            ).copyWith(fontWeight: FontWeight.w400),
                          ),
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
