import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/manage_loan_package/pawnshop_package_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/manage_loan_package_list/loan_package_detail/bloc/loan_package_detail_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanPackageDetail extends StatefulWidget {
  const LoanPackageDetail({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  _LoanPackageDetailState createState() => _LoanPackageDetailState();
}

class _LoanPackageDetailState extends State<LoanPackageDetail> {
  late LoanPackageDetailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = LoanPackageDetailCubit();
    cubit.getDetailPawnShopPackage(widget.id.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoanPackageDetailCubit, LoanPackageDetailState>(
      listener: (context, state) {
        if (state is LoanPackageDetailLoadApi) {
          if (state.completeType == CompleteType.SUCCESS) {
            cubit.showContent();
          } else {
            cubit.showError();
          }
          cubit.collateralsReceived = state.listCollateral ?? [];
          cubit.pawnShopPackage = state.pawnShopPackage ?? PawnshopPackage();
        }
      },
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {},
          textEmpty: 'Some thing went wrong',
          error: AppException('Error', 'Some thing went wrong'),
          stream: cubit.stateStream,
          child: _content(),
        );
      },
    );
  }

  BaseDesignScreen _content() {
    return BaseDesignScreen(
      title: 'Loan package detail',
      bottomBar: SizedBox(),
      // Container(
      //   color: AppTheme.getInstance().bgBtsColor(),
      //   padding: EdgeInsets.only(
      //     bottom: 38.h,
      //     left: 16.w,
      //     right: 16.w,
      //   ),
      //   child: Container(
      //     decoration: BoxDecoration(
      //
      //     ),
      //     child: Text(
      //       'Cancel package',
      //       style: textNormalCustom(
      //         AppTheme.getInstance().fillColor(),
      //         16,
      //         FontWeight.w600,
      //       ),
      //     ),
      //   ),
      // ),
      child: ((cubit.pawnShopPackage.name ?? '').isNotEmpty)
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH24,
                    _rowItemNormal(
                      title: 'Status',
                      description: Text(
                        cubit.getStatusLoanPackage(
                            cubit.pawnShopPackage.status ?? 0),
                        style: textNormalCustom(
                          cubit.getColorLoanPackage(
                              cubit.pawnShopPackage.status ?? 0),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Type',
                      description: typeLoan(),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Loan package ID',
                      description: Text(
                        cubit.pawnShopPackage.id.toString(),
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Message',
                      description: Text(
                        cubit.pawnShopPackage.name ?? '',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Loan amount',
                      description: Row(
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.network(
                              ImageAssets.getUrlToken(
                                  (cubit.pawnShopPackage.loanToken ?? [])[0]
                                          .symbol ??
                                      ''),
                            ),
                          ),
                          spaceW3,
                          Text(
                            '${cubit.pawnShopPackage.allowedLoanMin}-${cubit.pawnShopPackage.allowedLoanMax} ${(cubit.pawnShopPackage.loanToken ?? [])[0].symbol ?? ''}',
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              16,
                              FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Interest rate (%APR)',
                      description: Text(
                        '${cubit.pawnShopPackage.interestMin ?? 0}-${cubit.pawnShopPackage.interestMax ?? 0}%',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Collateral accepted',
                      description: SizedBox(
                        height: 30.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if ((cubit
                                            .pawnShopPackage
                                            .acceptableAssetsAsCollateral
                                            ?.length ??
                                        0) <
                                    5)
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubit
                                            .pawnShopPackage
                                            .acceptableAssetsAsCollateral
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, int index) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: 16.w,
                                            height: 16.h,
                                            child: Image.network(
                                              ImageAssets.getUrlToken(
                                                cubit
                                                        .pawnShopPackage
                                                        .acceptableAssetsAsCollateral?[
                                                            index]
                                                        .symbol ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                          spaceW8,
                                        ],
                                      );
                                    },
                                  )
                                else
                                  ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: 16.w,
                                            height: 16.h,
                                            child: Image.network(
                                              ImageAssets.getUrlToken(
                                                cubit
                                                        .pawnShopPackage
                                                        .acceptableAssetsAsCollateral?[
                                                            index]
                                                        .symbol ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                          spaceW8,
                                        ],
                                      );
                                    },
                                  ),
                                if ((cubit
                                            .pawnShopPackage
                                            .acceptableAssetsAsCollateral
                                            ?.length ??
                                        0) >
                                    5)
                                  Text(
                                    '& ${cubit.pawnShopPackage.acceptableAssetsAsCollateral!.length - 5} more',
                                    style: textNormalCustom(
                                      Colors.white,
                                      14,
                                      FontWeight.w400,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Duration',
                      description: Text(
                        '${cubit.pawnShopPackage.durationQtyTypeMin}-${cubit.pawnShopPackage.durationQtyTypeMax} ${cubit.weekOrMonth(durationQtyType: cubit.pawnShopPackage.durationQtyType ?? 0)}',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH16,
                    _rowItemNormal(
                      title: 'Offer sent',
                      description: Text(
                        '${cubit.pawnShopPackage.totalSentOffer ?? 0}',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    spaceH32,
                    Text(
                      '${cubit.collateralsReceived.length} COLLATERALS RECEIVED',
                      style: textNormalCustom(
                        AppTheme.getInstance().unselectedTabLabelColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH20,
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.collateralsReceived.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _collateralItem(
                            collateralModel: cubit.collateralsReceived[index]);
                      },
                    )
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _collateralItem({required CollateralResultModel collateralModel}) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        bottom: 20.h,
        right: 16.w,
      ),
      margin: EdgeInsets.only(
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().borderItemColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowItem(
            title: S.current.message.capitalize().withColon(),
            description: collateralModel.description ?? '',
          ),
          SizedBox(
            height: 16.h,
          ),
          _rowItem(
            title: S.current.collateral.capitalize().withColon(),
            isLoanAmount: true,
            urlToken: collateralModel.collateralSymbol ?? '',
            description: formatPrice.format(collateralModel.collateralAmount),
            // description: cryptoModel.loanSymbol ?? DFY,
          ),
          SizedBox(
            height: 16.h,
          ),
          _rowItemNormal(
            title: 'Loan currency',
            description: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Image.network(
                    ImageAssets.getUrlToken(collateralModel.loanSymbol ?? ''),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          _rowItem(
              title: S.current.duration,
              description: cubit.categoryOneOrMany(
                  durationQty: collateralModel.durationQty ?? 0,
                  durationType: collateralModel.durationType ?? 0)),
          SizedBox(
            height: 16.h,
          ),
          _rowItemNormal(
            title: 'Status',
            description: Text(
              cubit.getStatusCollateral(collateralModel.status ?? 0),
              style: textNormalCustom(
                cubit.getColorCollateral(
                  collateralModel.status ?? 0,
                ),
                16,
                FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _rowItem({
    String? urlToken,
    required String title,
    bool isLoanAmount = false,
    bool isStatus = false,
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        if (isLoanAmount)
          Expanded(
            flex: 5,
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child:
                      Image.network(ImageAssets.getUrlToken(urlToken ?? DFY)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '$description $urlToken',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        else
          Expanded(
            flex: 5,
            child: Text(
              description,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }

  Row _rowItemNormal({
    required String title,
    required Widget description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title.capitalize().withColon(),
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: description,
        )
      ],
    );
  }

  Widget typeLoan() {
    switch (cubit.pawnShopPackage.type) {
      case 0:
        return Text(
          'Auto',
          style: textNormalCustom(
            blueMarketColor,
            16,
            FontWeight.w600,
          ),
        );
      case 1:
        return Text(
          'Semi-auto',
          style: textNormalCustom(
            orangeColor,
            16,
            FontWeight.w600,
          ),
        );
      case 2:
        return Text(
          'Negotiation',
          style: textNormalCustom(
            redMarketColor,
            16,
            FontWeight.w600,
          ),
        );
      default:
        return Text(
          'P2P',
          style: textNormalCustom(
            deliveredColor,
            16,
            FontWeight.w600,
          ),
        );
    }
  }
}
