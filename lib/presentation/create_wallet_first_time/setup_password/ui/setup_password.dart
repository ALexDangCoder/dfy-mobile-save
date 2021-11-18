import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase.dart';
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
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
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
            StreamBuilder<bool>(
              stream: isValidPassCubit.isEnableBtnStream,
              builder: (context, snapshot) {
                return GestureDetector(
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: snapshot.data ?? true,
                  ),
                  onTap: () {
                    if (snapshot.data ?? false) {
                      isValidPassCubit.showTxtWarningNewPW(password.text);
                      isValidPassCubit.showTxtWarningConfirmPW(
                        confirmPassword.text,
                        newPW: password.text,
                      );
                      if (isValidPassCubit.validateAll()) {
                        showCreateSeedPhrase1(
                          context,
                          false,
                          BLocCreateSeedPhrase(password.text),
                          TypeScreen.tow,
                        );
                      } else {
                        //will not change screen
                      }
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
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
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: isValidPassCubit.txtWarningNewPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                          .copyWith(fontWeight: FontWeight.w400),
                    );
                  },
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
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: isValidPassCubit.txtWarningConfirmPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                          .copyWith(fontWeight: FontWeight.w400),
                    );
                  },
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
      // height: 48.h,
      width: 343.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: StreamBuilder<bool>(
                initialData: true,
                stream: isValidPassCubit.ckcBoxStream,
                builder: (context, snapshot) {
                  return Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    fillColor:
                        MaterialStateProperty.all(const Color(0xffE4AC1A)),
                    activeColor: const Color.fromRGBO(228, 172, 26, 1),
                    // checkColor: const Colors,
                    onChanged: (bool? value) {
                      isValidPassCubit.ckcBoxSink.add(value ?? false);
                      if (value == true) {
                        checkBox = 2;
                        isValidPassCubit.isEnable(2);
                      } else {
                        checkBox = 1;
                        isValidPassCubit.isEnable(1);
                      }
                    },
                    value: snapshot.data ?? false,
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
            // height: 48.h,
            child: Text(
              S.current.understand_defi,
              style: textNormal(const Color.fromRGBO(255, 255, 255, 1), 14)
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Container formSetupPassWord({required String hintText}) {
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
      child: StreamBuilder(
        stream: isValidPassCubit.showPWStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return TextFormField(
            onChanged: (value) {
              isValidPassCubit.checkHaveValuePW(value);
            },
            obscureText: snapshot.data ?? false,
            style: textNormal(
              Colors.white,
              16,
            ),
            cursorColor: Colors.white,
            controller: password,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14,
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
          );
        },
      ),
    );
  }

  Container formSetupPassWordConfirm({required String hintText}) {
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
      child: StreamBuilder(
        stream: isValidPassCubit.showConfirmPWStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return TextFormField(
            onChanged: (value) {
              isValidPassCubit.checkHaveValueConfirmPW(value);
            },
            obscureText: snapshot.data ?? false,
            style: textNormal(Colors.white, 16)
                .copyWith(fontWeight: FontWeight.w400),
            cursorColor: Colors.white,
            controller: confirmPassword,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14,
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
          );
        },
      ),
    );
  }

  Padding textShowSetupPass() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: SizedBox(
        width: 343.w,
        // height: 72.h,
        child: Text(
          S.current.please,
          style: textNormal(const Color.fromRGBO(255, 255, 255, 1.0), 16)
              .copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Container header() {
    return Container(
      width: 343.w,
      // height: 28.h,
      margin: EdgeInsets.only(
        top: 16.h,
        // bottom: 20.h,
        left: 16.w,
        right: 16.w,
      ),
      // EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 26.w,),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),

          Text(
            S.current.create_new_wallet,
            style: textNormal(Colors.white, 20)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_close),
          ),
        ],
      ),
    );
  }
}
