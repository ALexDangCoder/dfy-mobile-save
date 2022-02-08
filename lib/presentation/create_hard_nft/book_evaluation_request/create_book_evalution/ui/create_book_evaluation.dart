import 'dart:ui';

import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/bloc/bloc_create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/widget/item_map.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/widget/item_working_time.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/widget/type_nft.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/custom_calandar.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/pick_time.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum TypeEvaluation { NEW_CREATE, CREATE }

class CreateBookEvaluation extends StatefulWidget {
  final String idEvaluation;
  final TypeEvaluation type;
  final int? date;
  final String? typeNFT;

  const CreateBookEvaluation({
    Key? key,
    required this.idEvaluation,
    required this.type,
    this.date,
    this.typeNFT,
  }) : super(key: key);

  @override
  _CreateBookEvaluationState createState() => _CreateBookEvaluationState();
}

class _CreateBookEvaluationState extends State<CreateBookEvaluation> {
  late final BlocCreateBookEvaluation bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocCreateBookEvaluation();
    bloc.getDataInput(widget.date ?? 0);
    bloc.getDetailEvaluation(
      evaluationID: widget.idEvaluation,
    );
    bloc.getEvaluationFee();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EvaluatorsDetailModel>(
      stream: bloc.objDetail,
      builder: (context, snapshot) {
        final pawn = snapshot.data ?? EvaluatorsDetailModel();
        if (snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 767.h,
                      width: 375.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().bgBtsColor(),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: CustomScrollView(
                        physics: const ScrollPhysics(),
                        slivers: [
                          BaseAppBar(
                            image:
                                '${ApiConstants.BASE_URL_IMAGE}${pawn.coverCid}',
                            title: pawn.name ?? '',
                            initHeight: 145.h,
                            leading: SizedBox(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(ImageAssets.img_back),
                                ),
                              ),
                            ),
                            actions: const [],
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 16.w,
                                    left: 16.w,
                                    top: 16.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              '${ApiConstants.BASE_URL_IMAGE}'
                                              '${pawn.avatarCid}',
                                              height: 68.h,
                                              width: 68.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          spaceW16,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                pawn.name ?? '',
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              spaceH5,
                                              RichText(
                                                text: TextSpan(
                                                  style: textNormalCustom(
                                                    null,
                                                    14,
                                                    FontWeight.w400,
                                                  ),
                                                  children: [
                                                    WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Image.asset(
                                                        ImageAssets.img_star,
                                                        width: 14.w,
                                                        height: 14.w,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' ${pawn.starCount} |'
                                                          ' ${bloc.getTextCreateAt(pawn.createdAt ?? 0)}',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              spaceH5,
                                              Text(
                                                bloc.addressCheckNull(
                                                  pawn.walletAddress ?? '',
                                                ),
                                                style: textNormalCustom(
                                                  null,
                                                  14,
                                                  FontWeight.w600,
                                                ).copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      spaceH12,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            14,
                                            null,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_location,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: pawn.address ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH12,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            14,
                                            null,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_edit_square,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: pawn.description ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH32,
                                      Text(
                                        S.current.book_evaluation_appointment
                                            .toUpperCase(),
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .titleTabColor(),
                                          14,
                                          null,
                                        ),
                                      ),
                                      spaceH16,
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.type ==
                                              TypeEvaluation.NEW_CREATE) {
                                            final result = await Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    Duration.zero,
                                                opaque: false,
                                                pageBuilder: (_, __, ___) {
                                                  return CustomCalendar(
                                                    isCheckDate: true,
                                                    selectDate:
                                                        bloc.dateTimeDay,
                                                  );
                                                },
                                              ),
                                            );
                                            if (result != null) {
                                              final date =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(result);
                                              final dateChoose =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(result);
                                              bloc.dateStream.add(date);
                                              bloc.dateTimeDay =
                                                  DateTime.tryParse(dateChoose);
                                              final dateFormat =
                                                  DateFormat('EEEE')
                                                      .format(result);
                                              bloc.dateMy = dateFormat;

                                              bloc.getValidateDay(
                                                dateFormat,
                                              );
                                            } else {
                                              bloc.getValidateDay(
                                                bloc.dateMy ?? '',
                                              );
                                            }
                                          }
                                        },
                                        child: StreamBuilder<String>(
                                            stream: bloc.dateStream,
                                            builder: (context, snapshot) {
                                              final dateInput =
                                                  snapshot.data ?? '';
                                              return Container(
                                                height: 64.h,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.5.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.getInstance()
                                                      .itemBtsColors(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.r),
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: textNormalCustom(
                                                        dateInput == ''
                                                            ? AppTheme
                                                                    .getInstance()
                                                                .whiteWithOpacityFireZero()
                                                            : null,
                                                        16,
                                                        FontWeight.w400,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 10.w,
                                                            ),
                                                            child: Image.asset(
                                                              ImageAssets
                                                                  .ic_calendar_create_book,
                                                              width: 24.w,
                                                              height: 24.h,
                                                            ),
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: dateInput == ''
                                                              ? S.current
                                                                  .select_date
                                                              : dateInput,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      spaceH4,
                                      StreamBuilder<bool>(
                                        stream: bloc.isCheckTextValidateDate,
                                        builder: (context, snapshot) {
                                          return !(snapshot.data ?? true)
                                              ? Text(
                                                  bloc.textValidateDate,
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .redColor(),
                                                    14,
                                                    null,
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                      spaceH16,
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.type ==
                                              TypeEvaluation.NEW_CREATE) {
                                            final Map<String, String>? result =
                                                await showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (_) => BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 4,
                                                  sigmaY: 4,
                                                ),
                                                child: AlertDialog(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: PickTime(
                                                    hour: bloc.hourMy,
                                                    miu: bloc.miuMy,
                                                  ),
                                                ),
                                              ),
                                            );

                                            if (result != null) {
                                              final String hour = result
                                                  .stringValueOrEmpty('hour');
                                              final String minute = result
                                                  .stringValueOrEmpty('minute');
                                              bloc.timeStream
                                                  .add('$hour:$minute');
                                              bloc.hourMy = hour;
                                              bloc.miuMy = minute;
                                              bloc.getValidate(
                                                hour,
                                                minute,
                                              );
                                            } else {
                                              bloc.getValidate(
                                                bloc.hourMy ?? '0',
                                                bloc.miuMy ?? '0',
                                              );
                                            }
                                          }
                                        },
                                        child: StreamBuilder<String>(
                                          stream: bloc.timeStream,
                                          builder: (context, snapshot) {
                                            final timeInput =
                                                snapshot.data ?? '';
                                            return Container(
                                              height: 64.h,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.5.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppTheme.getInstance()
                                                    .itemBtsColors(),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.r),
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: textNormalCustom(
                                                      timeInput == ''
                                                          ? AppTheme
                                                                  .getInstance()
                                                              .whiteWithOpacityFireZero()
                                                          : null,
                                                      16,
                                                      FontWeight.w400,
                                                    ),
                                                    children: [
                                                      WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10.w,
                                                          ),
                                                          child: Image.asset(
                                                            ImageAssets.ic_time,
                                                            width: 24.w,
                                                            height: 24.h,
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: timeInput == ''
                                                            ? S.current
                                                                .select_time
                                                            : timeInput,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      spaceH4,
                                      StreamBuilder<bool>(
                                        stream: bloc.isCheckTextValidateTime,
                                        builder: (context, snapshot) {
                                          return snapshot.data ?? false
                                              ? Text(
                                                  bloc.textValidateTime,
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .redColor(),
                                                    14,
                                                    null,
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                      spaceH32,
                                      Text(
                                        S.current.asset_accepted.toUpperCase(),
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .titleTabColor(),
                                          14,
                                          null,
                                        ),
                                      ),
                                      spaceH16,
                                      Wrap(
                                        runSpacing: 16.h,
                                        spacing: 28.w,
                                        children: List<Widget>.generate(
                                            pawn.acceptedAssetTypeList
                                                    ?.length ??
                                                0, (int index) {
                                          return TypeNFTBox(
                                            image: bloc.linkImage(
                                              pawn.acceptedAssetTypeList?[index]
                                                      .id ??
                                                  0,
                                            ),
                                            text: pawn
                                                    .acceptedAssetTypeList?[
                                                        index]
                                                    .name ??
                                                '',
                                          );
                                        }).toList(),
                                      ),
                                      spaceH32,
                                      Text(
                                        S.current.contact.toUpperCase(),
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .titleTabColor(),
                                          14,
                                          null,
                                        ),
                                      ),
                                      spaceH16,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            16,
                                            FontWeight.w400,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_mail,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: pawn.email ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH16,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            16,
                                            FontWeight.w400,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_phone,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '(${pawn.phoneCode?.code})${pawn.phone ?? ''}', //phone code
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH16,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            16,
                                            FontWeight.w400,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_global_market,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: pawn.website ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH32,
                                      Text(
                                        S.current.working_time.toUpperCase(),
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .titleTabColor(),
                                          14,
                                          null,
                                        ),
                                      ),
                                      spaceH16,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            16,
                                            FontWeight.w400,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: S.current.from,
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${0.formatHourMy(pawn.workingTimeFrom ?? 0)} ',
                                              style: textNormalCustom(
                                                null,
                                                20,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text: S.current.to,
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${0.formatHourMy(pawn.workingTimeTo ?? 0)} ',
                                              style: textNormalCustom(
                                                null,
                                                20,
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH16,
                                      Wrap(
                                        runSpacing: 16.h,
                                        spacing: 16.w,
                                        children: List<Widget>.generate(
                                            pawn.workingDays?.length ?? 0,
                                            (int index) {
                                          return ItemWorkingTime(
                                            text: bloc.textWorkingDay(
                                              pawn.workingDays?[index] ?? 0,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      spaceH32,
                                      Text(
                                        S.current.location.toUpperCase(),
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .titleTabColor(),
                                          14,
                                          null,
                                        ),
                                      ),
                                      spaceH16,
                                      RichText(
                                        text: TextSpan(
                                          style: textNormalCustom(
                                            null,
                                            16,
                                            FontWeight.w400,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.w,
                                                ),
                                                child: Image.asset(
                                                  ImageAssets.ic_location,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: pawn.address ?? '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceH16,
                                      Center(
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                20.r,
                                              ),
                                            ),
                                          ),
                                          height: 193.h,
                                          width: 343.w,
                                          child: ItemMap(
                                            bloc: bloc,
                                            obj: pawn,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 120,
                                      ),
                                    ],
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
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: AppTheme.getInstance().bgBtsColor(),
                    child: StreamBuilder<bool>(
                      stream: bloc.isCheckBtn,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            if (snapshot.data ?? false) {
                              if (widget.type == TypeEvaluation.NEW_CREATE) {
                                goTo(
                                  context,
                                  Approve(
                                    needApprove: true,
                                    hexString: 'hexString',
                                    payValue: '1',
                                    tokenAddress: '',
                                    title: S.current.book_appointment,
                                    listDetail: [
                                      DetailItemApproveModel(
                                        title: '${S.current.evaluator} :',
                                        value: pawn.name ?? '',
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.date_time} :',
                                        value:
                                            '${bloc.timeStream.value} - ${bloc.dateMy}'
                                            ', ${bloc.dateStream.value}',
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.nft} :',
                                        value: widget.typeNFT ?? '',
                                      ),
                                      DetailItemApproveModel(
                                        title: '${S.current.evaluation_fee} :',
                                        value:
                                            '${bloc.evaluationFee?.amount ?? 0} '
                                            '${bloc.evaluationFee?.symbol ?? ''}',
                                      )
                                    ],
                                    textActiveButton:
                                        S.current.request_evaluation,
                                    spender: '',
                                    typeApprove: TYPE_CONFIRM_BASE.SEND_TOKEN,
                                  ),
                                );
                              }
                            }
                            //todo event
                          },
                          child: Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 21.h,
                              ),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.getInstance()
                                      .selectDialogColor(),
                                  width: 1.w,
                                ),
                                color: AppTheme.getInstance().borderItemColor(),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                              ),
                              child: ButtonGold(
                                isEnable: snapshot.data ?? false,
                                title: S.current.book_appointment,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return WillPopScope(
            child: const Center(
              child: CupertinoLoading(),
            ),
            onWillPop: () async => false,
          );
        }
      },
    );
  }
}
