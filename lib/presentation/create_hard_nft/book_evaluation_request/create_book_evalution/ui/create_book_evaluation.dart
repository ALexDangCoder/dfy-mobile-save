import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/bloc/bloc_create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/widget/item_working_time.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/widget/type_nft.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/custom_calandar.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/pick_time.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateBookEvaluation extends StatefulWidget {
  const CreateBookEvaluation({Key? key}) : super(key: key);

  @override
  _CreateBookEvaluationState createState() => _CreateBookEvaluationState();
}

class _CreateBookEvaluationState extends State<CreateBookEvaluation> {
  late final BlocCreateBookEvaluation _bloc;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.547441679107266, 105.90781651516276),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _bloc = BlocCreateBookEvaluation();
  }

  @override
  Widget build(BuildContext context) {
    final pawn = _bloc.pawnShopDetail.value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        color: AppTheme.getInstance().bgBtsColor(),
        child: GestureDetector(
          onTap: () {
            //todo event
          },
          child: Container(
            color: AppTheme.getInstance().bgBtsColor(),
            child: Container(
              padding: EdgeInsets.only(
                bottom: 20.h,
                top: 20.h,
              ),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.getInstance().selectDialogColor(),
                  width: 1.w,
                ),
                color: AppTheme.getInstance().borderItemColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: ButtonGold(
                isEnable: true,
                title: S.current.book_appointment,
              ),
            ),
          ),
        ),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 660.h,
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
                  image: pawn.urlCover ?? '',
                  title: pawn.title ?? '',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    pawn.urlAvatar ?? '',
                                    height: 68.h,
                                    width: 68.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                spaceW16,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pawn.title ?? '',
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
                                                PlaceholderAlignment.middle,
                                            child: Image.asset(
                                              ImageAssets.img_star,
                                              width: 14.w,
                                              height: 14.w,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' ${pawn.rate} | ${pawn.date}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceH5,
                                    Text(
                                      pawn.address
                                              ?.formatAddressWalletConfirm() ??
                                          '',
                                      style: textNormalCustom(
                                        null,
                                        14,
                                        FontWeight.w600,
                                      ).copyWith(
                                        decoration: TextDecoration.underline,
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
                                    alignment: PlaceholderAlignment.middle,
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
                                    text: pawn.location ?? '',
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
                                    alignment: PlaceholderAlignment.middle,
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
                                AppTheme.getInstance().titleTabColor(),
                                14,
                                null,
                              ),
                            ),
                            spaceH16,
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration.zero,
                                    opaque: false,
                                    pageBuilder: (_, __, ___) {
                                      return const CustomCalendar();
                                    },
                                  ),
                                );
                                if (result != null) {
                                  final date =
                                      DateFormat('dd/MM/yyyy').format(result);
                                  _bloc.dateStream.add(date);
                                }
                              },
                              child: StreamBuilder<String>(
                                  stream: _bloc.dateStream,
                                  builder: (context, snapshot) {
                                    final dateInput = snapshot.data ?? '';
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
                                              dateInput == ''
                                                  ? AppTheme.getInstance()
                                                      .whiteWithOpacityFireZero()
                                                  : null,
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
                                                    ImageAssets
                                                        .ic_calendar_create_book,
                                                    width: 24.w,
                                                    height: 24.h,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text: dateInput == ''
                                                    ? S.current.select_date
                                                    : dateInput,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            spaceH16,
                            GestureDetector(
                              onTap: () async {
                                final Map<String, String>? result =
                                    await showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (_) => BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                    child: const AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      content: PickTime(),
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  final String hour =
                                      result.stringValueOrEmpty('hour');
                                  final String minute =
                                      result.stringValueOrEmpty('minute');
                                  _bloc.timeStream.add('$hour:$minute');
                                }
                              },
                              child: StreamBuilder<String>(
                                stream: _bloc.timeStream,
                                builder: (context, snapshot) {
                                  final timeInput = snapshot.data ?? '';
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
                                                ? AppTheme.getInstance()
                                                    .whiteWithOpacityFireZero()
                                                : null,
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
                                                  ImageAssets.ic_time,
                                                  width: 24.w,
                                                  height: 24.h,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: timeInput == ''
                                                  ? S.current.select_time
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
                            spaceH32,
                            Text(
                              S.current.asset_accepted.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
                                14,
                                null,
                              ),
                            ),
                            spaceH16,
                            Wrap(
                              runSpacing: 16.h,
                              spacing: 28.w,
                              children: List<Widget>.generate(
                                  _bloc.listTypeNft.length, (int index) {
                                return TypeNFTBox(
                                  image: _bloc.listTypeNft[index].image ?? '',
                                  text: _bloc.listTypeNft[index].type ?? '',
                                );
                              }).toList(),
                            ),
                            spaceH32,
                            Text(
                              S.current.contact.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
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
                                    alignment: PlaceholderAlignment.middle,
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
                                    alignment: PlaceholderAlignment.middle,
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
                                    text: pawn.numberPhone ?? '',
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
                                    alignment: PlaceholderAlignment.middle,
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
                                    text: pawn.linkWeb ?? '',
                                  ),
                                ],
                              ),
                            ),
                            spaceH32,
                            Text(
                              S.current.working_time.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
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
                                    text: ' ${pawn.workingTime ?? ''} ',
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
                                    text: ' ${pawn.workingTime ?? ''} ',
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
                                  _bloc.listTimeWork.length, (int index) {
                                return ItemWorkingTime(
                                  text: _bloc.listTimeWork[index],
                                );
                              }).toList(),
                            ),
                            spaceH32,
                            Text(
                              S.current.location.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
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
                                    alignment: PlaceholderAlignment.middle,
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
                                    text: pawn.location ?? '',
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
                                child: GoogleMap(
                                  // zoomGesturesEnabled: false,
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: _kGooglePlex,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),
                              ),
                            ),
                            spaceH32,
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
    );
  }
}
