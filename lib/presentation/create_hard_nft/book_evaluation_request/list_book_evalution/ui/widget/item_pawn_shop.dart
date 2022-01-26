import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/bloc/bloc_list_book_evaluation.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_cancel.dart';
import 'dialog_reason_detail.dart';

class ItemPawnShop extends StatelessWidget {
  final BlocListBookEvaluation bloc;
  final AppointmentModel appointment;

  const ItemPawnShop({
    Key? key,
    required this.bloc,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      margin: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.r,
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateBookEvaluation(),
                        ),
                      );
                    },
                    child: Container(
                      height: 46.h,
                      width: 46.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        '${ApiConstants.BASE_URL_IMAGE}${appointment.evaluator?.avatarCid ?? ''}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  spaceW8,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateBookEvaluation(),
                        ),
                      );
                    },
                    child: Text(
                      appointment.evaluator?.name ?? '',
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              spaceH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    ImageAssets.ic_calendar_market,
                    width: 24.w,
                    height: 24.w,
                  ),
                  spaceW15,
                  Text(
                    0.formatDateTimeMy(appointment.appointmentTime ?? 0),
                    style: textNormalCustom(
                      null,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
              spaceH4,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
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
                    null,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              spaceH8,
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  child: bloc.isDetail
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              HeroDialogRoute(
                                builder: (context) {
                                  return DialogReasonDetail(
                                    contentDetail: 'sdfsadf', //todo content
                                    dateDetail: 0.formatDateTimeMy(
                                      appointment.appointmentTime ?? 0,
                                    ),
                                  );
                                },
                                isNonBackground: false,
                              ),
                            );
                          },
                          child: Text(
                            S.current.view_reason,
                            style: textNormalCustom(
                              null,
                              12,
                              null,
                            ).copyWith(decoration: TextDecoration.underline),
                            textAlign: TextAlign.end,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          Positioned(
            top: -4.h,
            right: -4.w,
            child: bloc.isCancel
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) {
                            return DialogCancel(
                              title: appointment.evaluator?.name ?? '',
                              urlAvatar:
                                  '${ApiConstants.BASE_URL_IMAGE}${appointment.evaluator?.avatarCid ?? ''}',
                              date: 0.formatDateTimeMy(
                                  appointment.appointmentTime ?? 0),
                              location: appointment.evaluator?.address ?? '',
                              mail: appointment.evaluator?.email ?? '',
                              numPhone: appointment.evaluator?.phone ?? '',
                              status: bloc.getTextStatus(
                                appointment.status ?? 0,
                                appointment.acceptedTime ?? 0,
                              ),
                              bloc: bloc,
                            );
                          },
                          isNonBackground: false,
                        ),
                      );
                    },
                    child: Image.asset(
                      ImageAssets.imgCancelMarket,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
