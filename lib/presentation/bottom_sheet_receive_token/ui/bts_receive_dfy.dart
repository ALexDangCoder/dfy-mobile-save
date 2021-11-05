import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/bloc/receive_cubit.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/save_pop_up.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/set_amount_pop_up.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/hero_dialog_route.dart';
import 'package:share/share.dart';

import 'custom_rect_tween.dart';

class ReceiveDFY extends StatefulWidget {
  const ReceiveDFY({Key? key, required this.walletAddress}) : super(key: key);
  final String walletAddress;

  @override
  _ReceiveDFYState createState() => _ReceiveDFYState();
}

class _ReceiveDFYState extends State<ReceiveDFY> {
  late final TextEditingController amountController;
  late final ReceiveCubit receiveCubit;
  late final FToast toast;
  String? prize;
  late final GlobalKey key;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    receiveCubit = ReceiveCubit();
    key = GlobalKey();
    toast = FToast();
    toast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    receiveCubit.dispose();
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
              left: 37.14.w,
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
                  width: 93.w,
                ),
                Text(
                  S.current.receive_dfy,
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
            height: 1,
            thickness: 1,
            color: AppTheme.getInstance().divideColor(),
          ),
          SizedBox(
            height: 41.h,
          ),
          Container(
            height: 367.h,
            width: 311.w,
            padding: EdgeInsets.only(
              top: 16.h,
              bottom: 12.h,
              right: 40.w,
              left: 40.w,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff585782),
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 125.w,
                  height: 29.83.h,
                  child: Image.asset(ImageAssets.defiText),
                ),
                SizedBox(
                  height: 13.17.h,
                ),
                RepaintBoundary(
                  key: key,
                  child: QrImage(
                    data: widget.walletAddress,
                    size: 230.w,
                    gapless: false,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 54.h,
                  width: 232.w,
                  child: Text(
                    widget.walletAddress,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      null,
                      18.sp,
                      FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          StreamBuilder<String>(
            stream: receiveCubit.amountStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                prize = snapshot.data;
              } else {
                prize = '';
              }
              return Visibility(
                visible: prize!.isNotEmpty,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 12.h,
                    bottom: 24.h,
                  ),
                  child: Text(
                    '${receiveCubit.value} BNB',
                    style: textNormal(const Color(0xffE4AC1A), 24.sp).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
            ),
            width: 311.w,
            height: 76.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumnButton(
                  path: ImageAssets.save,
                  label: S.current.save,
                  callback: () {
                   toast.showToast(
                      child: popMenu(),
                      toastDuration: const Duration(seconds: 1),
                     gravity: ToastGravity.CENTER,
                    );
                  },
                ),
                _buildColumnButton(
                  path: ImageAssets.set_amount,
                  label: S.current.set_amount,
                  callback: () {
                    Navigator.of(context).push(
                      HeroDialogRoute(
                        builder: (context) {
                          return SetAmountPopUp(
                            controller: amountController,
                            cubit: receiveCubit,
                            focusNode: FocusNode(),
                          );
                        },
                        isNonBackground: false,
                      ),
                    );
                  },
                ),
                _buildColumnButton(
                  path: ImageAssets.share,
                  label: S.current.share,
                  callback: () async {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  InkWell _buildColumnButton({
    required String path,
    required String label,
    Function()? callback,
  }) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                image: DecorationImage(image: AssetImage(path))),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: SizedBox(
              height: 22.h,
              child: Text(
                label,
                style: textNormalCustom(null, 16.sp, FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center popMenu() => Center(
        child: Hero(
          tag: '',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: buildBlur(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.white.withOpacity(0.6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                width: 232.w,
                height: 83.h,
                child: Center(
                  child: Text(
                    S.current.saved,
                    style: textNormal(
                      null,
                      20.sp,
                    ).copyWith(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 4,
    double sigmaY = 4,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
      ),
    );
  }
}
