import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeWalletName extends StatefulWidget {
  final WalletCubit bloc;
  final TextEditingController textEditingController;

  const ChangeWalletName({
    Key? key,
    required this.bloc,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<ChangeWalletName> createState() => _ChangeWalletNameState();
}

class _ChangeWalletNameState extends State<ChangeWalletName> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SizedBox(
            height: 225.h,
            width: 312.w,
            child: Hero(
              tag: '',
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: AppTheme.getInstance().selectDialogColor(),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: SizedBox(
                  width: 312.w,
                  height: 278.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20.w,
                          left: 20.w,
                          bottom: 24.h,
                        ),
                        child: Text(
                          S.current.enter_name,
                          style: textNormal(
                                  AppTheme.getInstance().whiteColor(), 20.sp)
                              .copyWith(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 271.w,
                          height: 64.h,
                          padding: EdgeInsets.only(
                            right: 15.w,
                            left: 15.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().backgroundBTSColor(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.r,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.ic_wallet,
                                height: 17.67.h,
                                width: 19.14.w,
                              ),
                              SizedBox(
                                width: 20.5.w,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: TextFormField(
                                    controller: widget.textEditingController,
                                    maxLength: 20,
                                    cursorColor:
                                        AppTheme.getInstance().whiteColor(),
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      16.sp,
                                    ),
                                    onChanged: (value) {
                                      widget.bloc.getIsWalletName(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: S.current.name_wallet,
                                      hintStyle: textNormal(
                                        AppTheme.getInstance()
                                            .whiteWithOpacityFireZero(),
                                        16.sp,
                                      ),
                                      counterText: '',
                                      border: InputBorder.none,
                                    ),
                                    // onFieldSubmitted: ,
                                  ),
                                ),
                              ),
                              StreamBuilder(
                                stream: widget.bloc.isWalletName,
                                builder:
                                    (context, AsyncSnapshot<bool> snapshot) {
                                  return SizedBox(
                                    child: snapshot.data ?? false
                                        ? InkWell(
                                            onTap: () {
                                              widget.textEditingController
                                                  .text = '';
                                              widget.bloc.getIsWalletName('');
                                            },
                                            child: Image.asset(
                                              ImageAssets.ic_close,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          )
                                        : null,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: widget.bloc.isWalletName,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return SizedBox(
                            width: 343.w,
                            child: snapshot.data ?? false
                                ? spaceH24
                                : Container(
                                    padding: EdgeInsets.only(
                                      right: 15.w,
                                      left: 28.w,
                                    ),
                                    height: 24.h,
                                    child: Text(
                                      S.current.name_not_null,
                                      style: textNormal(
                                        Colors.red,
                                        14.sp,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                          );
                        },
                      ),
                      spaceH8,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppTheme.getInstance().divideColor(),
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    S.current.cancel,
                                    style: textNormal(null, 20.sp).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: AppTheme.getInstance().divideColor(),
                              ),
                              StreamBuilder(
                                stream: widget.bloc.isWalletName,
                                builder:
                                    (context, AsyncSnapshot<bool> snapshot) {
                                  return Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (snapshot.data ?? false) {
                                          final String value =
                                              widget.textEditingController.text;
                                          widget.bloc.walletName.sink
                                              .add(value);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        S.current.confirm,
                                        style: textNormal(
                                          snapshot.data ?? false
                                              ? AppTheme.getInstance()
                                                  .fillColor()
                                              : AppTheme.getInstance()
                                                  .whiteWithOpacityFireZero(),
                                          20.sp,
                                        ).copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
