import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/restore_account/bloc/pass_cubit.dart';
import 'package:Dfy/presentation/restore_account/bloc/state.dart';
import 'package:Dfy/presentation/restore_account/bloc/string_cubit.dart';
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
  final newCubit = NewPassCubit();
  final conCubit = ConPassCubit();
  late StringCubit stringCubit;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  bool visible = false;
  FormType formType = FormType.SEED_PHRASE;

  @override
  void initState() {
    super.initState();
    stringCubit = StringCubit();
  }

  @override
  void dispose() {
    super.dispose();
    stringCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                formType = FormType.SEED_PHRASE;
                              }
                              if (state is StringSelectSeed) {
                                dropdownValue = state.key;
                                formType = FormType.SEED_PHRASE;
                              }

                              if (state is StringSelectPrivate) {
                                dropdownValue = state.key;
                                formType = FormType.PASSWORD;
                              }
                              return Column(
                                children: [
                                  Container(
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
                                      color:
                                          AppTheme.getInstance().itemBtsColor(),
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
                                        GestureDetector(
                                          onTap: () {
                                            stringCubit.show();
                                          },
                                          child: Container(
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
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  ItemForm(
                                    leadPath: ImageAssets.key,
                                    trailingPath: ImageAssets.show,
                                    hint: formType == FormType.SEED_PHRASE
                                        ? 'Wallet secret seed phrase'
                                        : '',
                                    formType: formType,
                                    isShow: true,
                                    controller: keyController,
                                  ),
                                ],
                              );
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        BlocBuilder<NewPassCubit, bool>(
                          bloc: newCubit,
                          builder: (ctx, state) {
                            if (state) {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath: ImageAssets.hide,
                                hint: 'New password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: newCubit.show,
                                controller: passwordController,
                              );
                            } else {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath: ImageAssets.show,
                                hint: 'New password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: newCubit.hide,
                                controller: passwordController,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        BlocBuilder<ConPassCubit, bool>(
                          bloc: conCubit,
                          builder: (ctx, state) {
                            if (state) {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath: ImageAssets.hide,
                                hint: 'Confirm password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: conCubit.show,
                                controller: passwordController,
                              );
                            } else {
                              return ItemForm(
                                leadPath: ImageAssets.lock,
                                trailingPath: ImageAssets.show,
                                hint: 'Confirm password',
                                formType: FormType.PASSWORD,
                                isShow: state,
                                callback: conCubit.hide,
                                controller: passwordController,
                              );
                            }
                          },
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
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ButtonGradient(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: <Color>[
                Color(0xffE4AC1A),
                Color(0xffFFE284),
              ],
            ),
            onPressed: () {},
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
    );
  }
}
