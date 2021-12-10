import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/receive_token/bloc/receive_cubit.dart';
import 'package:Dfy/utils/animate/custom_rect_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'receive_token.dart';

class SetAmountPopUp extends StatelessWidget {
  const SetAmountPopUp({
    Key? key,
    required this.controller,
    required this.cubit,
    this.symbol,
  }) : super(key: key);
  final TextEditingController controller;
  final ReceiveCubit cubit;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: '',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
          child: Material(
            color: AppTheme.getInstance().selectDialogColor(),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            child: SizedBox(
              width: 312.w,
              height: 225.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      right: 20.w,
                      left: 20.w,
                      bottom: 20.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.set_amount,
                            style: textNormal(
                              null,
                              20,
                            ).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ItemForm(
                          prefix: ImageAssets.ic_token,
                          hint: S.current.amount,
                          suffix: symbol ?? 'BNB',
                          formType: FormType.AMOUNT,
                          isShow: true,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white,
                            width: 0.2,
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
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color:
                                          AppTheme.getInstance().divideColor(),
                                    ),
                                  ),
                                ),
                                width: 156.w,
                                child: Center(
                                  child: Text(
                                    S.current.cancel,
                                    style: textNormal(null, 20).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                handleNumber();
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: 156.w,
                                child: Center(
                                  child: Text(
                                    S.current.confirm,
                                    style: textNormal(
                                      AppTheme.getInstance().fillColor(),
                                      20,
                                    ).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

  void handleNumber() {
    if (controller.text.isNotEmpty) {
      final number = double.parse(controller.text);
      if (number == 0) {
        cubit.amountSink.add('');
        controller.clear();
      } else {
        cubit.amountSink.add(controller.text);
      }
    } else {
      cubit.amountSink.add(controller.text);
    }
  }
}
