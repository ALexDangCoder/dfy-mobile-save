import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/dialog/warrning_dialog.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/ui/add_more_collateral.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_state.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/contract_info.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/ltv_tab.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/repayment_history.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/view_other_profile.dart';
import 'package:Dfy/presentation/pawn/repayment/ui/repayment_pay.dart';
import 'package:Dfy/presentation/pawn/review_borrower/ui/review_borrower.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum TypeBorrow { CRYPTO_TYPE, NFT_TYPE }
enum TypeNavigator { LENDER_TYPE, BORROW_TYPE }

class ContractDetail extends StatefulWidget {
  const ContractDetail({
    Key? key,
    required this.type,
    required this.id,
    this.typeNavigator = TypeNavigator.BORROW_TYPE,
  }) : super(key: key);
  final TypeBorrow type;
  final TypeNavigator typeNavigator;
  final int id;

  @override
  _ContractDetailState createState() => _ContractDetailState();
}

class _ContractDetailState extends State<ContractDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ContractDetailBloc bloc;
  String mes = '';

  @override
  void initState() {
    super.initState();
    bloc = ContractDetailBloc(
      widget.id,
      widget.type,
      widget.typeNavigator,
    );
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.contract_details,
      child: BlocConsumer<ContractDetailBloc, ContractDetailState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ContractDetailSuccess) {
            bloc.showContent();
            if (state.completeType == CompleteType.SUCCESS) {
              if (!(bloc.isShow.isBlank ?? false)) {
                if (PrefsService.getPleaseRate() == 'false') {
                  if (!(bloc.isRate ?? false) && (bloc.isShow ?? false)) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => ReviewBorrower(
                        objDetail: bloc.objDetail ?? ContractDetailPawn.name(),
                        type: widget.typeNavigator,
                      ),
                    );
                  }
                }
              }
              bloc.objDetail = state.obj;
            } else {
              mes = state.message ?? '';
            }
          }
        },
        builder: (context, state) {
          final obj = bloc.objDetail ?? ContractDetailPawn.name();
          return StateStreamLayout(
            stream: bloc.stateStream,
            retry: () {
              bloc.getData();
            },
            error: AppException(S.current.error, mes),
            textEmpty: mes,
            child: state is ContractDetailSuccess
                ? DefaultTabController(
                    length: 3,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 812.h,
                          child: NestedScrollView(
                            physics: const ScrollPhysics(),
                            headerSliverBuilder: (
                              BuildContext context,
                              bool innerBoxIsScrolled,
                            ) =>
                                [
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 343.w,
                                            margin: EdgeInsets.only(
                                              bottom: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .borderItemColor(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.r),
                                              ),
                                              border: Border.all(
                                                color: AppTheme.getInstance()
                                                    .divideColor(),
                                              ),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                right: 16.w,
                                                left: 16.w,
                                                top: 20.h,
                                                bottom: 20.h,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.current.lender,
                                                    style: textNormalCustom(
                                                      null,
                                                      20,
                                                      FontWeight.w700,
                                                    ),
                                                  ),
                                                  spaceH8,
                                                  RichText(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: '',
                                                      style: textNormal(
                                                        null,
                                                        16,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Text(
                                                            '${S.current.address}:',
                                                            style:
                                                                textNormalCustom(
                                                              AppTheme.getInstance()
                                                                  .pawnItemGray(),
                                                              16,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: SizedBox(
                                                            width: 4.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              launchURL(
                                                                Get.find<
                                                                            AppConstants>()
                                                                        .bscScan +
                                                                    ApiConstants
                                                                        .BSC_SCAN_ADDRESS +
                                                                    (obj.lenderWalletAddress
                                                                        .toString()),
                                                              );
                                                            },
                                                            child: Text(
                                                              checkNullAddressWallet(
                                                                obj.lenderWalletAddress
                                                                    .toString(),
                                                              ),
                                                              style:
                                                                  textNormalCustom(
                                                                AppTheme.getInstance()
                                                                    .blueMarketColors(),
                                                                16,
                                                                FontWeight.w400,
                                                              ).copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  spaceH8,
                                                  RichText(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: '',
                                                      style: textNormal(
                                                        null,
                                                        16,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Text(
                                                            '${S.current.address}:',
                                                            style:
                                                                textNormalCustom(
                                                              AppTheme.getInstance()
                                                                  .borderItemColor(),
                                                              16,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Image.asset(
                                                            ImageAssets.ic_star,
                                                            height: 20.h,
                                                            width: 20.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: SizedBox(
                                                            width: 4.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: StreamBuilder<
                                                              String>(
                                                            stream: bloc.rate,
                                                            builder: (
                                                              context,
                                                              snapshot,
                                                            ) {
                                                              return Text(
                                                                snapshot.data
                                                                    .toString(),
                                                                style:
                                                                    textNormalCustom(
                                                                  null,
                                                                  16,
                                                                  FontWeight
                                                                      .w400,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  spaceH20,
                                                  if (widget.typeNavigator !=
                                                      TypeNavigator.LENDER_TYPE)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            goTo(
                                                              context,
                                                              OtherProfile(
                                                                index: 1,
                                                                userId: obj
                                                                    .lenderUserId
                                                                    .toString(),
                                                                pageRouter:
                                                                    PageRouter
                                                                        .MARKET,
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.w,
                                                              vertical: 10.h,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  RadialGradient(
                                                                radius: 4.r,
                                                                center:
                                                                    const Alignment(
                                                                  0.5,
                                                                  -0.5,
                                                                ),
                                                                colors: AppTheme
                                                                        .getInstance()
                                                                    .gradientButtonColor(),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                  12.r,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              S.current
                                                                  .view_profile,
                                                              style:
                                                                  textNormalCustom(
                                                                null,
                                                                16,
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (!(bloc.isRate ??
                                                                false) &&
                                                            ((bloc.objDetail?.status ??
                                                                        0) ==
                                                                    ContractDetailBloc
                                                                        .DEFAULT ||
                                                                (bloc.objDetail
                                                                            ?.status ??
                                                                        0) ==
                                                                    ContractDetailBloc
                                                                        .COMPLETED))
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 25.w,
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (PrefsService
                                                                            .getCurrentWalletCore()
                                                                        .toLowerCase() !=
                                                                    (obj.borrowerWalletAddress
                                                                            ?.toLowerCase() ??
                                                                        '')) {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            WarningDialog(
                                                                      walletAddress:
                                                                          PrefsService
                                                                              .getCurrentWalletCore(),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            ReviewBorrower(
                                                                      objDetail:
                                                                          obj,
                                                                      type: widget
                                                                          .typeNavigator,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20.w,
                                                                  vertical:
                                                                      10.h,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppTheme
                                                                          .getInstance()
                                                                      .borderItemColor(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: AppTheme
                                                                            .getInstance()
                                                                        .fillColor(),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  S.current
                                                                      .review,
                                                                  style:
                                                                      textNormalCustom(
                                                                    AppTheme.getInstance()
                                                                        .fillColor(),
                                                                    16,
                                                                    FontWeight
                                                                        .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          const SizedBox
                                                              .shrink(),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 343.w,
                                            margin: EdgeInsets.only(
                                              bottom: 36.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .borderItemColor(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.r),
                                              ),
                                              border: Border.all(
                                                color: AppTheme.getInstance()
                                                    .divideColor(),
                                              ),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                right: 16.w,
                                                left: 16.w,
                                                top: 20.h,
                                                bottom: 20.h,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.current.borrower,
                                                    style: textNormalCustom(
                                                      null,
                                                      20,
                                                      FontWeight.w700,
                                                    ),
                                                  ),
                                                  spaceH8,
                                                  RichText(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: '',
                                                      style: textNormal(
                                                        null,
                                                        16,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Text(
                                                            '${S.current.address}:',
                                                            style:
                                                                textNormalCustom(
                                                              AppTheme.getInstance()
                                                                  .pawnItemGray(),
                                                              16,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: SizedBox(
                                                            width: 4.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              launchURL(
                                                                Get.find<
                                                                            AppConstants>()
                                                                        .bscScan +
                                                                    ApiConstants
                                                                        .BSC_SCAN_ADDRESS +
                                                                    (obj.borrowerWalletAddress
                                                                        .toString()),
                                                              );
                                                            },
                                                            child: Text(
                                                              checkNullAddressWallet(
                                                                obj.borrowerWalletAddress
                                                                    .toString(),
                                                              ),
                                                              style:
                                                                  textNormalCustom(
                                                                AppTheme.getInstance()
                                                                    .blueMarketColors(),
                                                                16,
                                                                FontWeight.w400,
                                                              ).copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  spaceH8,
                                                  RichText(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: '',
                                                      style: textNormal(
                                                        null,
                                                        16,
                                                      ),
                                                      children: [
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Text(
                                                            '${S.current.address}:',
                                                            style:
                                                                textNormalCustom(
                                                              AppTheme.getInstance()
                                                                  .borderItemColor(),
                                                              16,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Image.asset(
                                                            ImageAssets.ic_star,
                                                            height: 20.h,
                                                            width: 20.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: SizedBox(
                                                            width: 4.w,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: StreamBuilder<
                                                              String>(
                                                            stream: bloc.rateMy,
                                                            builder: (
                                                              context,
                                                              snapshot,
                                                            ) {
                                                              return Text(
                                                                snapshot.data
                                                                    .toString(),
                                                                style:
                                                                    textNormalCustom(
                                                                  null,
                                                                  16,
                                                                  FontWeight
                                                                      .w400,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  spaceH8,
                                                  if (widget.typeNavigator ==
                                                      TypeNavigator.LENDER_TYPE)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            goTo(
                                                              context,
                                                              OtherProfile(
                                                                index: 1,
                                                                userId: obj
                                                                    .borrowerUserId
                                                                    .toString(),
                                                                pageRouter:
                                                                    PageRouter
                                                                        .MARKET,
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.w,
                                                              vertical: 10.h,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  RadialGradient(
                                                                radius: 4.r,
                                                                center:
                                                                    const Alignment(
                                                                  0.5,
                                                                  -0.5,
                                                                ),
                                                                colors: AppTheme
                                                                        .getInstance()
                                                                    .gradientButtonColor(),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                  12.r,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              S.current
                                                                  .view_profile,
                                                              style:
                                                                  textNormalCustom(
                                                                null,
                                                                16,
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (!(bloc.isRate ??
                                                                false) &&
                                                            ((bloc.objDetail?.status ??
                                                                        0) ==
                                                                    ContractDetailBloc
                                                                        .DEFAULT ||
                                                                (bloc.objDetail
                                                                            ?.status ??
                                                                        0) ==
                                                                    ContractDetailBloc
                                                                        .COMPLETED))
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: 25.w,
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (PrefsService
                                                                            .getCurrentWalletCore()
                                                                        .toLowerCase() !=
                                                                    (obj.lenderWalletAddress
                                                                            ?.toLowerCase() ??
                                                                        '')) {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            WarningDialog(
                                                                      walletAddress:
                                                                          PrefsService
                                                                              .getCurrentWalletCore(),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            ReviewBorrower(
                                                                      objDetail:
                                                                          obj,
                                                                      type: widget
                                                                          .typeNavigator,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20.w,
                                                                  vertical:
                                                                      10.h,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppTheme
                                                                          .getInstance()
                                                                      .borderItemColor(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                      12.r,
                                                                    ),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: AppTheme
                                                                            .getInstance()
                                                                        .fillColor(),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  S.current
                                                                      .review,
                                                                  style:
                                                                      textNormalCustom(
                                                                    AppTheme.getInstance()
                                                                        .fillColor(),
                                                                    16,
                                                                    FontWeight
                                                                        .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          const SizedBox
                                                              .shrink(),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SliverPersistentHeader(
                                delegate: BaseSliverHeader(
                                  TabBar(
                                    unselectedLabelColor:
                                        const Color(0xFF9997FF),
                                    labelColor: Colors.white,
                                    indicatorColor: const Color(0xFF6F6FC5),
                                    controller: _tabController,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelStyle: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w600,
                                    ),
                                    tabs: [
                                      Tab(
                                        child: Text(
                                          S.current.contract_info,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          S.current.lte_liquidation_threshold,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          S.current.repayment_history,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //pinned: true,
                              ),
                            ],
                            body: TabBarView(
                              controller: _tabController,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: ContractInfo(
                                    bloc: bloc,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: LTVTAB(
                                    bloc: bloc,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: RepaymentHistory(
                                    bloc: bloc,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.typeNavigator == TypeNavigator.LENDER_TYPE)
                          const SizedBox.shrink()
                        else
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: widget.type == TypeBorrow.CRYPTO_TYPE
                                ? Center(
                                    child: Container(
                                      color:
                                          AppTheme.getInstance().bgBtsColor(),
                                      padding: EdgeInsets.only(
                                        bottom: 16.h,
                                      ),
                                      width: 343.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (obj.status ==
                                              ContractDetailBloc.ACTIVE)
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddMoreCollateral(
                                                        obj: obj,
                                                        totalUnpaid: bloc
                                                                .objRepayment
                                                                ?.totalUnpaid ??
                                                            0,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 64.h,
                                                width: obj.status !=
                                                        ContractDetailBloc
                                                            .ACTIVE
                                                    ? 343.w
                                                    : 159.w,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.getInstance()
                                                      .borderItemColor(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.r),
                                                  ),
                                                  border: Border.all(
                                                    color:
                                                        AppTheme.getInstance()
                                                            .fillColor(),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    S.current.add_collateral,
                                                    style: textNormalCustom(
                                                      AppTheme.getInstance()
                                                          .fillColor(),
                                                      20,
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (obj.status ==
                                              ContractDetailBloc.ACTIVE)
                                            GestureDetector(
                                              onTap: () {
                                                if (obj.lenderWalletAddress ==
                                                    PrefsService
                                                        .getCurrentWalletCore()) {
                                                  goTo(
                                                    context,
                                                    RepaymentPay(
                                                      id: obj.id.toString(),
                                                      obj: bloc.objDetail ??
                                                          ContractDetailPawn
                                                              .name(),
                                                    ),
                                                  );
                                                } else {
                                                  showAlert(
                                                    context,
                                                    PrefsService
                                                        .getCurrentWalletCore(),
                                                  );
                                                }
                                              },
                                              child: SizedBox(
                                                width: obj.status !=
                                                        ContractDetailBloc
                                                            .ACTIVE
                                                    ? 343.w
                                                    : 159.w,
                                                child: ButtonGold(
                                                  isEnable: true,
                                                  fixSize: false,
                                                  haveMargin: false,
                                                  title: S.current.repayment,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    child:
                                        obj.status == ContractDetailBloc.ACTIVE
                                            ? GestureDetector(
                                                onTap: () {
                                                  if (obj.lenderWalletAddress ==
                                                      PrefsService
                                                          .getCurrentWalletCore()) {
                                                    goTo(
                                                      context,
                                                      RepaymentPay(
                                                        obj: bloc.objDetail ??
                                                            ContractDetailPawn
                                                                .name(),
                                                        id: obj.id.toString(),
                                                      ),
                                                    );
                                                  } else {
                                                    showAlert(
                                                      context,
                                                      PrefsService
                                                          .getCurrentWalletCore(),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  color: AppTheme.getInstance()
                                                      .bgBtsColor(),
                                                  padding: EdgeInsets.only(
                                                    bottom: 38.h,
                                                  ),
                                                  child: ButtonGold(
                                                    isEnable: true,
                                                    title: S.current.repayment,
                                                  ),
                                                ),
                                              )
                                            : null,
                                  ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
