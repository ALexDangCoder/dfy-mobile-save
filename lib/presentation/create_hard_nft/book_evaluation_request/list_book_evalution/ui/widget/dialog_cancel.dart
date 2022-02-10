import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/bloc/bloc_list_book_evaluation.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_icon_text.dart';

class DialogCancel extends StatelessWidget {
  final AppointmentModel appointment;
  final BlocListBookEvaluation bloc;

  const DialogCancel({
    Key? key,
    required this.bloc,
    required this.appointment,
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
                                    '${ApiConstants.BASE_URL_IMAGE}${appointment.evaluator?.avatarCid ?? ''}',
                                    width: 46.w,
                                    height: 46.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 206.w,
                                  child: Text(
                                    appointment.evaluator?.name ?? '',
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
                              text:
                                  '(${appointment.evaluator?.phoneCode?.code ?? ''})${appointment.evaluator?.phone ?? ''}',
                              icon: ImageAssets.ic_phone,
                            ),
                            spaceH16,
                            ItemIconText(
                              text: appointment.evaluator?.email ?? '',
                              icon: ImageAssets.ic_mail,
                            ),
                            spaceH16,
                            ItemIconText(
                              text: appointment.evaluator?.address ?? '',
                              icon: ImageAssets.ic_location,
                            ),
                            spaceH16,
                            ItemIconText(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              text: 0.formatDateTimeMy(
                                appointment.appointmentTime ?? 0,
                              ),
                              icon: ImageAssets.ic_calendar_market,
                            ),
                            spaceH16,
                            Text(
                              bloc.getTextStatus(
                                appointment.status ?? 0,
                                appointment.acceptedTime ?? 0,
                              ),
                              style: textNormalCustom(
                                bloc.checkColor(
                                  bloc.getTextStatus(
                                    appointment.status ?? 0,
                                    appointment.acceptedTime ?? 0,
                                  ),
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
                                onTap: () async {
                                  final navigator = Navigator.of(context);
                                  await bloc.getHexString(
                                    appointmentId:
                                        appointment.bcAppointmentId.toString(),
                                    reason: appointment.rejectedReason ?? '',
                                  );
                                  unawaited(
                                    navigator.push(
                                      MaterialPageRoute(
                                        builder: (context) => Approve(
                                          hexString: bloc.hexString,
                                          title: S.current.cancel_appointment,
                                          listDetail: [
                                            DetailItemApproveModel(
                                              title: '${S.current.evaluator} :',
                                              value:
                                                  appointment.evaluator?.name ??
                                                      '',
                                            ),
                                            DetailItemApproveModel(
                                              title: '${S.current.date_time} :',
                                              value: 0.formatDateTimeMy(
                                                appointment.appointmentTime ??
                                                    0,
                                              ),
                                            ),
                                            DetailItemApproveModel(
                                              title: '${S.current.location} :',
                                              value: appointment
                                                      .evaluator?.address ??
                                                  '',
                                            ),
                                          ],
                                          onErrorSign: (context) {
                                            showLoadFail(context);
                                          },
                                          onSuccessSign: (context, data) async {
                                            await bloc.cancelEvaluation(
                                              bcTxnHashCancel: data,
                                              evaluatorId: appointment.id ?? '',
                                            );
                                            unawaited(
                                              showLoadSuccess(context)
                                                  .whenComplete(
                                                () {
                                                  navigator.pop();
                                                  navigator.pop();
                                                  navigator.pop();
                                                },
                                              ),
                                            );
                                          },
                                          textActiveButton:
                                              S.current.cancel_appointment,
                                          spender: eva_dev2,
                                        ),
                                      ),
                                    ),
                                  );
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
