import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/restore_account/bloc/pass_cubit.dart';
import 'package:Dfy/presentation/restore_account/bloc/string_cubit.dart';
import 'package:Dfy/presentation/restore_account/bloc/string_state.dart';
import 'package:Dfy/presentation/restore_account/bloc/validate_cubit.dart';
import 'package:Dfy/presentation/restore_account/ui/custom_show.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoreAccount extends StatefulWidget {
  const RestoreAccount({Key? key}) : super(key: key);

  @override
  _RestoreAccountState createState() => _RestoreAccountState();
}

class _RestoreAccountState extends State<RestoreAccount> {
  String dropdownValue = S.current.seed_phrase;
  late final NewPassCubit newCubit;
  late final ConPassCubit conCubit;
  late final StringCubit stringCubit;
  late final PrivatePassCubit privatePassCubit;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController privateKeyController;
  late final TextEditingController seedPhraseController;
  late final CheckPassCubit isValidPassCubit;
  bool visible = false;
  FormType formType = FormType.PASS_PHRASE;

  @override
  void initState() {
    super.initState();
    stringCubit = StringCubit();
    newCubit = NewPassCubit();
    conCubit = ConPassCubit();
    privatePassCubit = PrivatePassCubit();
    seedPhraseController = TextEditingController();
    passwordController = TextEditingController();
    privateKeyController = TextEditingController();
    confirmPasswordController = TextEditingController();
    isValidPassCubit = CheckPassCubit();
    trustWalletChannel
        .setMethodCallHandler(stringCubit.nativeMethodCallBackTrustWallet);
  }

  @override
  void dispose() {
    super.dispose();
    stringCubit.close();
    newCubit.close();
    conCubit.close();
    privatePassCubit.close();
    seedPhraseController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    privateKeyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stringCubit.hidePopMenu();
      },
      child: Container(
        height: 764.h,
        width: 375.w,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 16.h,
                left: 26.w,
                right: 26.w,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      height: 16.8.h,
                      width: 16.8.w,
                      child: const ImageIcon(
                        AssetImage(ImageAssets.back),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                  Text(
                    'Restore Account',
                    style: textNormal(null, 20.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 26.w,
                right: 26.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Restore your account with using secret seed phrase',
                    style: textNormal(
                      null,
                      16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Only first account on this wallet will auto load. '
                    'After completing this process, to add additional accounts,'
                    ' you can create new account or import account',
                    style: textNormal(
                      null,
                      16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 26.w),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          BlocBuilder(
                            bloc: stringCubit,
                            builder: (context, state) {
                              if (state is StringInitial) {
                                dropdownValue = state.key;
                                formType = FormType.PASS_PHRASE;
                              }
                              if (state is StringSelectSeed) {
                                dropdownValue = state.key;
                                formType = FormType.PASS_PHRASE;
                              }

                              if (state is StringSelectPrivate) {
                                dropdownValue = state.key;
                                formType = FormType.PASSWORD;
                              }
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      stringCubit.showPopMenu();
                                    },
                                    child: Container(
                                      height: 64.h,
                                      width: 323.w,
                                      padding: EdgeInsets.only(
                                        top: 6.h,
                                        bottom: 6.h,
                                        right: 8.w,
                                        left: 8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: AppTheme.getInstance()
                                            .itemBtsColor(),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageAssets.security,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 8.h),
                                            height: 24.h,
                                            width: 215.w,
                                            child: Text(
                                              dropdownValue,
                                              style: textNormal(
                                                null,
                                                16.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 27.15.w,
                                          ),
                                          const Expanded(
                                            child: ImageIcon(
                                              AssetImage(ImageAssets.expand),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (formType == FormType.PASS_PHRASE)
                                    ItemForm(
                                      leadPath: ImageAssets.key,
                                      trailingPath: ImageAssets.show,
                                      hint: S.current.wallet_secret,
                                      formType: FormType.PASS_PHRASE,
                                      isShow: true,
                                      controller: seedPhraseController,
                                    )
                                  else
                                    BlocBuilder<PrivatePassCubit, bool>(
                                      bloc: privatePassCubit,
                                      builder: (ctx, state) {
                                        return ItemForm(
                                          leadPath: ImageAssets.lock,
                                          trailingPath: state
                                              ? ImageAssets.hide
                                              : ImageAssets.show,
                                          hint: S.current.private_key,
                                          formType: FormType.PRIVATE_KEY,
                                          isShow: state,
                                          callback: state
                                              ? privatePassCubit.showPass
                                              : privatePassCubit.hidePass,
                                          controller: privateKeyController,
                                        );
                                      },
                                    ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          BlocBuilder<NewPassCubit, bool>(
                            bloc: newCubit,
                            builder: (ctx, state) {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath:
                                    state ? ImageAssets.hide : ImageAssets.show,
                                hint: 'New password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: state
                                    ? newCubit.showPass
                                    : newCubit.hidePass,
                                controller: passwordController,
                              );
                            },
                          ),
                          showTextValidatePassword(),
                          SizedBox(
                            height: 20.h,
                          ),
                          BlocBuilder<ConPassCubit, bool>(
                            bloc: conCubit,
                            builder: (ctx, state) {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath:
                                    state ? ImageAssets.hide : ImageAssets.show,
                                hint: 'Confirm password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: state
                                    ? conCubit.showPass
                                    : conCubit.hidePass,
                                controller: confirmPasswordController,
                              );
                            },
                          ),
                          showTextValidateMatchPassword(),
                          SizedBox(
                            height: 150.h,
                          ),
                        ],
                      ),
                      BlocBuilder<StringCubit, StringState>(
                        bloc: stringCubit,
                        builder: (context, state) {
                          if (state is Show) {
                            return Visibility(
                              visible: state.show,
                              child: Positioned(
                                top: 72.h,
                                child: CustomDialog(
                                  cubit: stringCubit,
                                  controller1: seedPhraseController,
                                  controller2: privateKeyController,
                                ),
                              ),
                            );
                          } else if (state is Hide) {
                            return Visibility(
                              visible: state.show,
                              child: Positioned(
                                top: 72.h,
                                child: CustomDialog(
                                  cubit: stringCubit,
                                  controller1: seedPhraseController,
                                  controller2: privateKeyController,
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            ButtonGradient(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                colors: <Color>[
                  Color(0xffE4AC1A),
                  Color(0xffFFE284),
                ],
              ),
              onPressed: () {
                isValidPassCubit.isValidate(passwordController.text);
                isValidPassCubit.isMatchPW(
                  password: passwordController.text,
                  confirmPW: confirmPasswordController.text,
                );
                if (isValidPassCubit.isValidFtMatchPW(
                  passwordController.text,
                  confirmPasswordController.text,
                )) {
                  if (stringCubit.select == 'Seed phrase') {
                    stringCubit.importWallet(
                      type: 'PASS_PHRASE',
                      content: seedPhraseController.text,
                      password: passwordController.text,
                    );
                    Navigator.pop(context);
                  } else {
                    stringCubit.importWallet(
                      type: 'PRIVATE_KEY',
                      content: privateKeyController.text,
                      password: passwordController.text,
                    );
                    Navigator.pop(context);
                  }

                }
              },
              child: Text(
                'Restore',
                style: textNormal(
                  null,
                  20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }

  //huy
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
                  'Your password did not match',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 108, 108, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                  'Password must include at least a number, '
                  'an upper case, a lower\n case and a special '
                  'character',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 108, 108, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
