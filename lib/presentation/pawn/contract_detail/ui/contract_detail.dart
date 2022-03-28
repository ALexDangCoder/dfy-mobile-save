import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_state.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/contract_info.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/ltv_tab.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/tab/repayment_history.dart';
import 'package:Dfy/presentation/pawn/review_borrower/ui/review_borrower.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum TypeBorrow { CRYPTO_TYPE, NFT_TYPE }

class ContractDetail extends StatefulWidget {
  const ContractDetail({
    Key? key,
    required this.type,
    required this.id,
  }) : super(key: key);
  final TypeBorrow type;
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
                if (!(bloc.isRate ?? false) && (bloc.isShow ?? false)) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => ReviewBorrower(),
                  );
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
                        Container(
                          height: 812.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
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
                                                              checkNullAddressWallet(obj
                                                                  .lenderWalletAddress
                                                                  .toString()),
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
                                                            builder: (context,
                                                                snapshot) {
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          //todo
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
                                                      spaceW25,
                                                      GestureDetector(
                                                        onTap: () {
                                                          //todo
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                    .getInstance()
                                                                .borderItemColor(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                12.r,
                                                              ),
                                                            ),
                                                            border: Border.all(
                                                              color: AppTheme
                                                                      .getInstance()
                                                                  .fillColor(),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            S.current.review,
                                                            style:
                                                                textNormalCustom(
                                                              AppTheme.getInstance()
                                                                  .fillColor(),
                                                              16,
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                        child: SizedBox(
                                          height: 90.h,
                                          child: Text(S.current.contract_info),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          height: 90.h,
                                          child: Text(
                                            S.current.lte_liquidation_threshold,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          height: 90.h,
                                          child:
                                              Text(S.current.repayment_history),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pinned: true,
                              ),
                            ],
                            body: TabBarView(
                              controller: _tabController,
                              children: [
                                ContractInfo(
                                  bloc: bloc,
                                ),
                                LTVTAB(
                                  bloc: bloc,
                                ),
                                RepaymentHistory(
                                  bloc: bloc,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: widget.type == TypeBorrow.CRYPTO_TYPE
                              ? Center(
                                  child: Container(
                                    color: AppTheme.getInstance().bgBtsColor(),
                                    padding: EdgeInsets.only(
                                      bottom: 16.h,
                                    ),
                                    width: 343.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // );//todo
                                          },
                                          child: Container(
                                            height: 64.h,
                                            width: 159.w,
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .borderItemColor(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.r),
                                              ),
                                              border: Border.all(
                                                color: AppTheme.getInstance()
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
                                        GestureDetector(
                                          onTap: () {
                                            //todo
                                          },
                                          child: SizedBox(
                                            width: 159.w,
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
                              : GestureDetector(
                                  onTap: () {
                                    //todo
                                  },
                                  child: Container(
                                    color: AppTheme.getInstance().bgBtsColor(),
                                    padding: EdgeInsets.only(
                                      bottom: 38.h,
                                    ),
                                    child: ButtonGold(
                                      isEnable: true,
                                      title: S.current.repayment,
                                    ),
                                  ),
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
