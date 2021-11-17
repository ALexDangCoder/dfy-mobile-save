import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/ui/setup_password.dart';
import 'package:Dfy/presentation/restore_bts/ui/restore_bts.dart';
import 'package:Dfy/utils/animate/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPopUp extends StatelessWidget {
  const AlertPopUp({
    Key? key, required this.type,
  }) : super(key: key);
  final KeyType type;
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 310.h,
                maxWidth: 312.w,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 246,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        right: 20.w,
                        left: 20.w,
                        //bottom: 20.h,
                      ),
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 3,
                              top: 4,
                              right: 3,
                            ),
                            child: Text(
                              S.current.are_you_sure,
                              textAlign: TextAlign.center,
                              style: textNormal(
                                AppTheme.getInstance().wrongColor(),
                                20,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 3.w,
                              right: 3.w,
                            ),
                            child: Text(
                              S.current.your_current_wallet,
                              textAlign: TextAlign.center,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                12,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 3.w,
                              right: 3.w,
                            ),
                            child: Text(
                              S.current.you_can_only,
                              textAlign: TextAlign.center,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                12,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 64,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppTheme.getInstance().divideColor(),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
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
                          VerticalDivider(
                            color: AppTheme.getInstance().divideColor(),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: type == KeyType.IMPORT ? () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => const RestoreBTS(),
                                ).then((value) => Navigator.pop(context));
                              } : () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => const SetupPassWord(),
                                ).then((value) => Navigator.pop(context));
                              } ,
                              child: SizedBox(
                                width: 156.w,
                                child: Center(
                                  child: Text(
                                    S.current.continue_s,
                                    style: textNormal(
                                      AppTheme.getInstance().wrongColor(),
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
}
