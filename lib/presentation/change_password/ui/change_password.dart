import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:Dfy/presentation/change_password/ui/components/form_setup_password.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/wallet_dialog_when_core_logged.dart';
import 'package:Dfy/widgets/success/successful_by_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//declare enum base on type form : old pass, new pass, confirm pass
enum typeForm { OLD, NEW, CONFIRM }

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // String oldPWFetchFromApi = 'Huydepzai1102.';
  late ChangePasswordCubit passwordCubit;
  late TextEditingController _txtOldPW;
  late TextEditingController _txtNewPW;
  late TextEditingController _txtConfirmPW;

  @override
  void initState() {
    passwordCubit = ChangePasswordCubit();
    _txtOldPW = TextEditingController();
    _txtNewPW = TextEditingController();
    _txtConfirmPW = TextEditingController();
    trustWalletChannel
        .setMethodCallHandler(passwordCubit.nativeMethodCallBackTrustWallet);
    super.initState();
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
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        bloc: passwordCubit,
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showSuccessfulByTitle(
              title: S.current.change_pword_success,
              callBack: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: walletInfoIndex,
                    ),
                  ),
                  (route) => route.isFirst,
                );
              },
              context: context,
            );
          } else {
            _showDialog(
              alert: S.current.change_pw_fail,
            );
          }
        },
        builder: (context, state) {
          return BaseDesignScreen(
            title: S.current.change_password,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        formSetupPassWord(
                          controller: _txtOldPW,
                          hintText: S.current.old_password,
                          // oldPassWordFetch: oldPWFetchFromApi,
                          cubit: passwordCubit,
                          type: typeForm.OLD,
                        ),
                        showTextValidateOldPassword(),
                        SizedBox(
                          height: 16.h,
                        ),
                        formSetupPassWord(
                          controller: _txtNewPW,
                          hintText: S.current.new_pass,
                          cubit: passwordCubit,
                          type: typeForm.NEW,
                        ),
                        showTextValidateNewPassword(),
                        SizedBox(
                          height: 16.h,
                        ),
                        formSetupPassWord(
                          controller: _txtConfirmPW,
                          hintText: S.current.confirm_new_password,
                          cubit: passwordCubit,
                          type: typeForm.CONFIRM,
                        ),
                        showTextValidateConfirmPassword(),
                        SizedBox(
                          height: 349.h,
                        ),
                      ],
                    ),
                  ),
                ),
                //handle enable or disable btn
                StreamBuilder<bool>(
                  stream: passwordCubit.isEnableButtonStream,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      child: ButtonGold(
                        title: S.current.continue_s,
                        isEnable: snapshot.data ?? true,
                      ),
                      onTap: () {
                        if (snapshot.data ?? false) {
                          //todo show fail when change pw fail
                          passwordCubit.showTxtWarningOldPW(
                            _txtOldPW.text,
                            // passwordOld: oldPWFetchFromApi,
                          );
                          if (passwordCubit.checkAllValidate(
                            // oldPWFetch: oldPWFetchFromApi,
                            oldPW: _txtOldPW.text,
                            newPW: _txtNewPW.text,
                            confirmPW: _txtConfirmPW.text,
                          )) {
                            passwordCubit.changePasswordIntoWalletCore(
                              oldPassword: _txtOldPW.text,
                              newPassword: _txtNewPW.text,
                            );
                          } else {
                            //nothing
                          }
                        } else {
                          // nothing
                        }
                      },
                    );
                  },
                ),
                spaceH38,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showTextValidateOldPassword() {
    return StreamBuilder(
      stream: passwordCubit.matchOldPWStream,
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
                  stream: passwordCubit.txtWarnOldPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 108, 108, 1),
                      ),
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

  Widget showTextValidateNewPassword() {
    return StreamBuilder(
      stream: passwordCubit.validatePWStream,
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
                  stream: passwordCubit.txtWarnNewPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 108, 108, 1),
                      ),
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

  Widget showTextValidateConfirmPassword() {
    return StreamBuilder(
      stream: passwordCubit.matchPWStream,
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
                  stream: passwordCubit.txtWarnCfPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 108, 108, 1),
                      ),
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

  void _showDialog({String? alert, String? text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                36.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  alert ?? S.current.password_is_not_correct,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              spaceH16,
              Text(
                text ?? S.current.please_try_again,
                style: textNormalCustom(
                  Colors.white,
                  12,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            Center(
              child: TextButton(
                child: Text(
                  S.current.ok,
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    20,
                    FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
