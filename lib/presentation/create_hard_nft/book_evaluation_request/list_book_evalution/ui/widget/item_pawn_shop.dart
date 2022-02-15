import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
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
  final bool isLoading;

  const ItemPawnShop({
    Key? key,
    required this.bloc,
    required this.appointment,
    required this.isLoading,
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
                          builder: (context) => CreateBookEvaluation(
                            isSuccess: bloc.isSuccess.value,
                            appointmentList: bloc.appointmentList,
                            idEvaluation: appointment.evaluator?.id ?? '',
                            type: bloc.checkStatus(
                              appointment.evaluator?.id ?? '',
                            ),
                            date: appointment.appointmentTime,
                            assetId: bloc.assetId ?? '',
                          ),
                          settings: const RouteSettings(
                            name: AppRouter.step2Create,
                          ),
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
                        '${ApiConstants.BASE_URL_IMAGE}'
                        '${appointment.evaluator?.avatarCid ?? ''}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppTheme.getInstance().bgBtsColor(),
                        ),
                      ),
                    ),
                  ),
                  spaceW8,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateBookEvaluation(
                            isSuccess: bloc.isSuccess.value,
                            appointmentList: bloc.appointmentList,
                            idEvaluation: appointment.evaluator?.id ?? '',
                            type: bloc.checkStatus(
                              appointment.evaluator?.id ?? '',
                            ),
                            date: appointment.appointmentTime,
                            assetId: bloc.assetId ?? '',
                          ),
                          settings: const RouteSettings(
                            name: AppRouter.step2Create,
                          ),
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
                child: RichText(
                  text: TextSpan(
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
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: bloc.isLoadingText
                            ? Container(
                                width: 18.w,
                                height: 18.h,
                                margin: EdgeInsets.only(right: 10.w),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      TextSpan(
                        text: bloc.getTextStatus(
                          appointment.status ?? 0,
                          appointment.acceptedTime ?? 0,
                        ),
                      ),
                    ],
                  ),
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
            top: -15.h,
            right: -15.w,
            child: bloc.isCancel
                ? InkWell(
                    onTap: () {
                      if (!isLoading) {
                        Navigator.of(context)
                            .push(
                              HeroDialogRoute(
                                builder: (context) {
                                  return DialogCancel(
                                    appointment: appointment,
                                    bloc: bloc,
                                  );
                                },
                                isNonBackground: false,
                              ),
                            )
                            .then(
                              (value) => bloc.getListPawnShop(
                                assetId: bloc.assetId ?? '',
                              ),
                            );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 11.h,
                      ),
                      child: Image.asset(
                        ImageAssets.imgCancelMarket,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
