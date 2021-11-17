import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:Dfy/presentation/change_password/ui/components/form_setup_password.dart';
import 'package:Dfy/presentation/change_password/ui/components/header_change_password.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/setting_wallet.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/wallet_screen.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/success/successful_by_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//declare enum base on type form : old pass, new pass, confirm pass
enum typeForm { OLD, NEW, CONFIRM }

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPWFetchFromApi = 'Huydepzai1102.@';
  late ChangePasswordCubit _passwordCubit;
  late TextEditingController _txtOldPW;
  late TextEditingController _txtNewPW;
  late TextEditingController _txtConfirmPW;

  @override
  void initState() {
    _txtOldPW = TextEditingController();
    _txtNewPW = TextEditingController();
    _txtConfirmPW = TextEditingController();
    _passwordCubit = ChangePasswordCubit();
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
      child: Container(
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
            headerChangePW(
              callBack: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
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
                      oldPassWordFetch: oldPWFetchFromApi,
                      cubit: _passwordCubit,
                      type: typeForm.OLD,
                    ),
                    showTextValidateOldPassword(),
                    SizedBox(
                      height: 16.h,
                    ),
                    formSetupPassWord(
                      controller: _txtNewPW,
                      hintText: S.current.new_pass,
                      cubit: _passwordCubit,
                      type: typeForm.NEW,
                    ),
                    showTextValidateNewPassword(),
                    SizedBox(
                      height: 16.h,
                    ),
                    formSetupPassWord(
                      controller: _txtConfirmPW,
                      hintText: S.current.confirm_new_password,
                      cubit: _passwordCubit,
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
              stream: _passwordCubit.isEnableButtonStream,
              builder: (context, snapshot) {
                return GestureDetector(
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: snapshot.data ?? true,
                  ),
                  onTap: () {
                    if (snapshot.data ?? false) {
                      _passwordCubit.showTxtWarningOldPW(
                        _txtOldPW.text,
                        passwordOld: oldPWFetchFromApi,
                      );
                      _passwordCubit.showTxtWarningNewPW(_txtNewPW.text);
                      _passwordCubit.showTxtWarningConfirmPW(
                        _txtConfirmPW.text,
                        newPassword: _txtNewPW.text,
                      );

                      if (_passwordCubit.checkAllValidate(
                        oldPWFetch: oldPWFetchFromApi,
                        oldPW: _txtOldPW.text,
                        newPW: _txtNewPW.text,
                        confirmPW: _txtConfirmPW.text,
                      )) {
                        showSuccessfulByTitle(
                          title: S.current.change_pw_success,
                          callBack: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(
                                  index: 2,
                                ),
                              ),
                              (route) => route.isFirst,
                            );
                          },
                          context: context,
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
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget showTextValidateOldPassword() {
    return StreamBuilder(
      stream: _passwordCubit.matchOldPWStream,
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
                  stream: _passwordCubit.txtWarnOldPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 108, 108, 1),
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
      stream: _passwordCubit.validatePWStream,
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
                  stream: _passwordCubit.txtWarnNewPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 108, 108, 1),
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
      stream: _passwordCubit.matchPWStream,
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
                  stream: _passwordCubit.txtWarnCfPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 108, 108, 1),
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
}
