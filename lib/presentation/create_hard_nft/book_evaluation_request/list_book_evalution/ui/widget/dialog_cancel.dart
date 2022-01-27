import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/bloc/bloc_list_book_evaluation.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_icon_text.dart';

class DialogCancel extends StatelessWidget {
  final String urlAvatar;
  final String numPhone;
  final String numPhoneCode;
  final String mail;
  final String location;
  final String date;
  final String status;
  final String title;
  final BlocListBookEvaluation bloc;

  const DialogCancel({
    Key? key,
    required this.urlAvatar,
    required this.numPhone,
    required this.mail,
    required this.location,
    required this.date,
    required this.status,
    required this.title,
    required this.bloc,
    required this.numPhoneCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
        child: Center(
          child: Center(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 32.h,
                          left: 26.w,
                          right: 26.w,
                          top: 21.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: 8.w,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    urlAvatar,
                                    width: 46.w,
                                    height: 46.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 206.w,
                                  child: Text(
                                    title,
                                    style: textNormalCustom(
                                      null,
                                      20,
                                      FontWeight.w600,
                                    ).copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            spaceH16,
                            ItemIconText(
                              text: '($numPhoneCode)$numPhone',
                              icon: ImageAssets.ic_phone,
                            ),
                            spaceH16,
                            ItemIconText(
                              text: mail,
                              icon: ImageAssets.ic_mail,
                            ),
                            spaceH16,
                            ItemIconText(
                              text: location,
                              icon: ImageAssets.ic_location,
                            ),
                            spaceH16,
                            ItemIconText(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              text: date,
                              icon: ImageAssets.ic_calendar_market,
                            ),
                            spaceH16,
                            Text(
                              status,
                              style: textNormalCustom(
                                bloc.checkColor(
                                  status,
                                ),
                                12,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 64.h,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppTheme.getInstance().divideColor(),
                              width: 1.h,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //todo event
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: AppTheme.getInstance()
                                            .divideColor(),
                                        width: 1.h,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      S.current.close,
                                      style: textNormal(null, 20.sp).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //todo event
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 64.h,
                                  child: Center(
                                    child: Text(
                                      S.current.cancel_appointment,
                                      style: textNormal(
                                        AppTheme.getInstance().yellowColor(),
                                        20,
                                      ).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
