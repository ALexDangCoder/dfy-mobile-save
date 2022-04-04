import 'dart:async';
import 'dart:io';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/alert_dialog/ui/alert_import_pop_up.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully.dart';
import 'package:Dfy/presentation/login/bloc/login_cubit.dart';
import 'package:Dfy/presentation/login/bloc/login_for_market_place.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/animate/hero_dialog_route.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    required this.walletCubit,
    this.isFromConnectDialog = false,
  }) : super(key: key);

  final bool isFromConnectDialog;
  final WalletCubit walletCubit;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController controller;
  final LoginCubit _cubit = LoginCubit();
  bool enableLogin = false;
  bool errorText = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    trustWalletChannel
        .setMethodCallHandler(_cubit.nativeMethodCallBackTrustWallet);

    controller.addListener(() {
      if (mounted) {
        setState(() {
          if (controller.text.isNotEmpty) {
            enableLogin = true;
          } else {
            enableLogin = false;
          }
        });
      }
    });
    _cubit.getConfig();
    _cubit.checkBiometrics();

    //login for market place:
    _cubit.getWallet();
    if (widget.isFromConnectDialog) {
      _cubit.isLoginSuccessStream.listen((event) {
        if (event) {
          _cubit.getSignature(
            walletAddress: _cubit.walletAddress,
            context: context,
          );
        }
      });
      _cubit.signatureStream.listen(
        (event) async {
          if (event.isNotEmpty) {
            final nav = Navigator.of(context);
            showLoading(context);
            final bool checkLogin = await _cubit.loginAndSaveInfo(
              walletAddress: _cubit.walletAddress,
              signature: event,
            );
            hideLoading(context);
            if (checkLogin) {
              unawaited(
                nav.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: walletInfoIndex,
                    ),
                  ),
                  (route) => route.isFirst,
                ),
              );
            } else {
              showErrDialog(
                context: context,
                title: S.current.notify,
                content: S.current.something_went_wrong,
              );
            }
          } else {
            showErrDialog(
              context: context,
              title: S.current.notify,
              content: S.current.something_went_wrong,
            );
          }
        },
      );
      _cubit.isSaveInfoSuccessStream.listen(
        (event) {
          if (event) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(
                  index: walletInfoIndex,
                ),
              ),
              (route) => route.isFirst,
            );
          } else {
            showErrDialog(
              context: context,
              title: S.current.notify,
              content: S.current.something_went_wrong,
            );
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    super.dispose();
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
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          },
          child: Container(
            width: 375.sw,
            height: 812.h,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                  Image(
                    image: AssetImage(ImageAssets.ic_symbol),
                    height: 100.h,
                    width: 100.w,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Image(
                    image: AssetImage(ImageAssets.centered),
                    height: 35.h,
                    width: 237.w,
                  ),
                  SizedBox(
                    height: 68.h,
                  ),
                  Container(
                    width: 343.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().itemBtsColors(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 19.w,
                        right: 19.w,
                      ),
                      child: Row(
                        children: [
                          ImageIcon(
                            const AssetImage(ImageAssets.ic_lock),
                            color: AppTheme.getInstance().whiteColor(),
                            size: 24,
                          ),
                          SizedBox(
                            width: 20.5.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                if (value.isEmpty || controller.text.isEmpty) {
                                  setState(() {
                                    errorText = true;
                                  });
                                } else {
                                  errorText = false;
                                }
                              },
                              cursorColor: AppTheme.getInstance().whiteColor(),
                              style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.getInstance().whiteColor(),
                              ),
                              controller: controller,
                              obscureText: _cubit.hidePass,
                              maxLength: 15,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: S.current.password,
                                hintStyle: textNormal(
                                  AppTheme.getInstance().textThemeColor(),
                                  18,
                                ),
                                border: InputBorder.none,
                              ),
                              // onFieldSubmitted: ,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  _cubit.hidePassword();
                                });
                              }
                            },
                            child: _cubit.hidePass
                                ? ImageIcon(
                                    const AssetImage(ImageAssets.ic_show),
                                    color: AppTheme.getInstance().suffixColor(),
                                  )
                                : ImageIcon(
                                    const AssetImage(ImageAssets.ic_hide),
                                    color: AppTheme.getInstance().suffixColor(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    width: 343.w,
                    child: Visibility(
                      visible: errorText,
                      child: Text(
                        S.current.password_is_required,
                        style: textNormal(
                          Colors.red,
                          12,
                        ).copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    bloc: _cubit,
                    listener: (context, state) {
                      final nav = Navigator.of(context);
                      if (state is LoginPasswordSuccess) {
                        PrefsService.saveCurrentWalletCore(
                          _cubit.walletAddress,
                        );
                        if (widget.isFromConnectDialog) {
                          _cubit.isLoginSuccessSubject.sink.add(true);
                        } else {
                          nav.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                index: walletInfoIndex,
                              ),
                            ),
                            (route) => route.isFirst,
                          );
                        }
                      }
                      if (state is LoginPasswordError) {
                        _showDialog();
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        child: enableLogin
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: ButtonRadial(
                                  child: Center(
                                    child: Text(
                                      S.current.login,
                                      style: textNormalCustom(
                                        Colors.white,
                                        20,
                                        FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: ErrorButton(
                                  child: Center(
                                    child: Text(
                                      S.current.login,
                                      style: textNormalCustom(
                                        Colors.white,
                                        20,
                                        FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        onTap: () {
                          if (controller.value.text.isNotEmpty && !errorText) {
                            _cubit.checkPasswordWallet(controller.value.text);
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  StreamBuilder<bool>(
                    stream: _cubit.isFaceIDStream,
                    builder: (context, state) {
                      return Visibility(
                        visible: state.data ?? true,
                        child: BlocListener<LoginCubit, LoginState>(
                          bloc: _cubit,
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              PrefsService.saveCurrentWalletCore(
                                _cubit.walletAddress,
                              );
                              if (widget.isFromConnectDialog) {
                                _cubit.isLoginSuccessSubject.sink.add(true);
                              } else {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(
                                      index: walletInfoIndex,
                                    ),
                                  ),
                                  (route) => route.isFirst,
                                );
                              }
                            }
                            if (state is LoginError) {
                              _showDialog(
                                alert: S.current.error,
                                text: state.error,
                              );
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              _cubit.checkBiometrics();
                            },
                            child: Platform.isIOS
                                ? Image(
                                    image: AssetImage(ImageAssets.faceID),
                                    height: 54.h,
                                    width: 54.w,
                                  )
                                : Image(
                                    image: AssetImage(ImageAssets.ic_finger),
                                    height: 54.h,
                                    width: 54.w,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            HeroDialogRoute(
                              builder: (context) {
                                return AlertPopUp(
                                  type: KeyType.CREATE,
                                  isFromConnectWlDialog:
                                      widget.isFromConnectDialog,
                                );
                              },
                              isNonBackground: false,
                            ),
                          )
                              .whenComplete(() {
                            trustWalletChannel.setMethodCallHandler(
                              _cubit.nativeMethodCallBackTrustWallet,
                            );
                          });
                        },
                        child: Text(
                          S.current.new_wallet,
                          style: textNormal(
                            Colors.amber,
                            18,
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
                          Navigator.of(context)
                              .push(
                            HeroDialogRoute(
                              builder: (context) {
                                return AlertPopUp(
                                  type: KeyType.IMPORT,
                                  isFromConnectWlDialog:
                                      widget.isFromConnectDialog,
                                );
                              },
                              isNonBackground: false,
                            ),
                          )
                              .whenComplete(() {
                            trustWalletChannel.setMethodCallHandler(
                              _cubit.nativeMethodCallBackTrustWallet,
                            );
                          });
                        },
                        child: Text(
                          S.current.import_seed_phrase,
                          style: textNormal(
                            Colors.amber,
                            18,
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

  void _showDialog({String? alert, String? text}) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                36.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          title: Column(
            children: [
              Text(
                alert ?? S.current.password_is_not_correct,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                text ?? S.current.please_try_again,
                style: textNormalCustom(
                  Colors.white,
                  12,
                  FontWeight.w400,
                ),
                textAlign: TextAlign.center,
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
                  _cubit.emit(LoginInitial());
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
