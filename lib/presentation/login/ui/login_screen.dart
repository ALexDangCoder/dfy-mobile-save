import 'dart:io';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/ui/setup_password.dart';
import 'package:Dfy/presentation/login/bloc/login_cubit.dart';
import 'package:Dfy/presentation/restore_bts/ui/restore_bts.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  final LoginCubit _cubit = LoginCubit();
  bool enableLogin = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.text.isNotEmpty) {
          enableLogin = true;
        } else {
          enableLogin = false;
        }
      });
    });
    trustWalletChannel
        .setMethodCallHandler(_cubit.nativeMethodCallBackTrustWallet);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: 375.sw,
            height: 812.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: listBackgroundColor,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 113.h,
                  ),
                  const Image(
                    image: AssetImage(ImageAssets.symbol),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  const Image(
                    image: AssetImage(ImageAssets.center),
                  ),
                  SizedBox(
                    height: 68.h,
                  ),
                  Container(
                    width: 323.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().backgroundLoginTextField(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 19.w,
                        right: 19.w,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Icon(
                                Icons.lock_outline,
                                color: AppTheme.getInstance().whiteColor(),
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(
                              width: 20.5.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                cursorColor:
                                    AppTheme.getInstance().whiteColor(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.getInstance().whiteColor(),
                                ),
                                controller: controller,
                                obscureText: _cubit.hidePass,
                                decoration: InputDecoration(
                                  hintText: S.current.password,
                                  hintStyle: textNormal(
                                    AppTheme.getInstance().textThemeColor(),
                                    18.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                                // onFieldSubmitted: ,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _cubit.hidePassword();
                                }),
                                child: _cubit.hidePass
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: AppTheme.getInstance()
                                            .suffixColor(),
                                      )
                                    : Icon(
                                        Icons.visibility_outlined,
                                        color: AppTheme.getInstance()
                                            .suffixColor(),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _cubit.checkPasswordWallet(controller.value.text);
                    },
                    child: BlocListener<LoginCubit, LoginState>(
                      bloc: _cubit,
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushNamed(
                            context,
                            AppRouter.wallet,
                          );
                        } else if (state is LoginError) {
                        } else {
                          const CircularProgressIndicator();
                        }
                      },
                      child: enableLogin
                          ? ButtonRadial(
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: textNormalCustom(
                                    Colors.white,
                                    20.sp,
                                    FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : ErrorButton(
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: textNormalCustom(
                                    Colors.white,
                                    20.sp,
                                    FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    bloc: _cubit,
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushNamed(
                          context,
                          AppRouter.wallet,
                        );
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        _cubit.authenticate();
                      },
                      child: Platform.isIOS
                          ? const Image(
                              image: AssetImage(ImageAssets.faceID),
                            )
                          : const Image(
                              image: AssetImage(ImageAssets.ic_finger),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const SetupPassWord();
                            },
                          );
                        },
                        child: Text(
                          'New wallet',
                          style: textNormal(
                            Colors.amber,
                            18.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.h,
                      ),
                      Container(
                        height: 4.h,
                        width: 4.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD4D4D4),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 16.h,
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const RestoreBTS(),
                          );
                        },
                        child: Text(
                          S.current.import_seed_phrase,
                          style: textNormal(
                            Colors.amber,
                            18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
