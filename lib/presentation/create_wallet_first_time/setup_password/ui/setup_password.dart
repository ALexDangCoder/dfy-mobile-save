import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase1.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/bloc/check_pass_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupPassWord extends StatefulWidget {
  const SetupPassWord({Key? key}) : super(key: key);

  @override
  _SetupPassWordState createState() => _SetupPassWordState();
}

class _SetupPassWordState extends State<SetupPassWord> {
  late CheckPassCubit isValidPassCubit;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  int indexPW = 1;
  int indexConfirmPW = 1;
  int checkBox = 1;
  int isValidPass = 1;
  int isMatchPass = 1;

  @override
  void initState() {
    isValidPassCubit = CheckPassCubit();
    super.initState();
  }

  @override
  void dispose() {
    isValidPassCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 764.h,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          header(),
          Divider(
            thickness: 1,
            color: AppTheme.getInstance().divideColor(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  textShowSetupPass(),
                  SizedBox(
                    height: 28.h,
                  ),
                  formSetupPassWord(
                    hintText: S.current.new_pass,
                  ),
                  showTextValidatePassword(),
                  SizedBox(
                    height: 16.h,
                  ),
                  formSetupPassWordConfirm(
                    hintText: S.current.con_pass,
                  ),
                  showTextValidateMatchPassword(),
                  SizedBox(
                    height: 25.h,
                  ),
                  ckcBoxAndTextSetupPass(),
                  SizedBox(
                    height: 256.h,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: ButtonGold(
              title: S.current.continue_s, isEnable: true,
            ),
            onTap: () async {
              isValidPassCubit.isValidate(password.text);
              isValidPassCubit.isMatchPW(
                password: password.text,
                confirmPW: confirmPassword.text,
              );
              if (checkBox == 2 &&
                  isValidPassCubit.isValidFtMatchPW(
                    password.text,
                    confirmPassword.text,
                  )) {
                showCreateSeedPhrase1(
                  context,
                  BLocCreateSeedPhrase(password.text),
                );
              }
            },
          ),
          SizedBox(
            height: 38.h,
          ),
        ],
      ),
    );
  }

  Widget showTextValidatePassword() {
    return StreamBuilder(
      stream: isValidPassCubit.validatePWStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                height: 30.h,
                child: Text(
                  S.current.pass_must,
                  style: textNormal(
                    AppTheme.getInstance().wrongColor(),
                    12.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showTextValidateMatchPassword() {
    return StreamBuilder(
      stream: isValidPassCubit.matchPWStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                height: 30.h,
                child: Text(
                  S.current.not_match,
                  style: textNormal(
                    AppTheme.getInstance().wrongColor(),
                    12.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SizedBox ckcBoxAndTextSetupPass() {
    return SizedBox(
      height: 48.h,
      width: 323.w,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: StreamBuilder(
                stream: isValidPassCubit.ckcBoxStream,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  return Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    fillColor: MaterialStateProperty.all(
                      AppTheme.getInstance().fillColor(),
                    ),
                    activeColor: AppTheme.getInstance().activeColor(),
                    // checkColor: const Colors,
                    onChanged: (bool? value) {
                      isValidPassCubit.ckcBoxSink.add(value ?? false);
                      if (value == true) {
                        checkBox = 2;
                      } else {
                        checkBox = 1;
                      }
                    },
                    value: snapshot.data,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          SizedBox(
            width: 287.w,
            height: 48.h,
            child: Text(
              S.current.understand_defi,
              style: textNormal(
                AppTheme.getInstance().whiteWithOpacity(),
                14.sp,
              ).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container formSetupPassWord({required String hintText}) {
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
      child: StreamBuilder(
        stream: isValidPassCubit.showPWStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return TextFormField(
            obscureText: snapshot.data ?? false,
            style: textNormal(
              Colors.white,
              16.sp,
            ),
            cursorColor: Colors.white,
            controller: password,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14.sp,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  if (indexPW == 1) {
                    isValidPassCubit.isShowPW(1);
                    indexPW = 2;
                  } else {
                    isValidPassCubit.isShowPW(0);
                    indexPW = 1;
                  }
                },
                child: snapshot.data ?? false
                    ? const ImageIcon(
                        AssetImage(ImageAssets.hide),
                        color: Colors.grey,
                      )
                    : const ImageIcon(
                        AssetImage(ImageAssets.show),
                        color: Colors.grey,
                      ),
              ),
              prefixIcon: const ImageIcon(
                AssetImage(ImageAssets.lock),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  }

  Container formSetupPassWordConfirm({required String hintText}) {
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
      child: StreamBuilder(
        stream: isValidPassCubit.showConfirmPWStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return TextFormField(
            obscureText: snapshot.data ?? false,
            style: textNormal(
              Colors.white,
              16.sp,
            ),
            cursorColor: Colors.white,
            controller: confirmPassword,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14.sp,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  if (indexConfirmPW == 1) {
                    isValidPassCubit.isShowConfirmPW(1);
                    indexConfirmPW = 2;
                  } else {
                    isValidPassCubit.isShowConfirmPW(0);
                    indexConfirmPW = 1;
                  }
                },
                child: snapshot.data ?? false
                    ? const ImageIcon(
                        AssetImage(ImageAssets.hide),
                        color: Colors.grey,
                      )
                    : const ImageIcon(
                        AssetImage(ImageAssets.show),
                        color: Colors.grey,
                      ),
              ),
              prefixIcon: const ImageIcon(
                AssetImage(ImageAssets.lock),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  }

  Padding textShowSetupPass() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: SizedBox(
        width: 323.w,
        height: 72.h,
        child: Text(
          S.current.please,
          style: textNormal(
            AppTheme.getInstance().whiteWithOpacity(),
            16.sp,
          ).copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Padding header() {
    return Padding(
      padding:
          EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(ImageAssets.back),
            ),
          ),
          SizedBox(
            width: 66.w,
          ),
          Text(
            S.current.create_wallet,
            style: textNormal(
              AppTheme.getInstance().whiteWithOpacity(),
              20.sp,
            ).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 64.48.w,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(ImageAssets.ic_group),
            ),
          )
        ],
      ),
    );
  }
}
