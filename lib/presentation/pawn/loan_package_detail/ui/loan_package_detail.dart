import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/loan_package_detail/cubit/loan_package_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanPackageDetail extends StatefulWidget {
  const LoanPackageDetail({
    Key? key,
    required this.packageId,
    required this.packageType,
  }) : super(key: key);

  final String packageId;
  final int packageType;

  @override
  _LoanPackageDetailState createState() => _LoanPackageDetailState();
}

class _LoanPackageDetailState extends State<LoanPackageDetail> {
  late LoanPackageCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = LoanPackageCubit();
    cubit.getDetailPawnshop(widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoanPackageCubit, LoanPackageState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is LoanPackageSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            cubit.pawnshopPackage = state.pawnshopPackage ?? PawnshopPackage();
            cubit.showContent();
          } else {
            cubit.message = state.message ?? '';
            cubit.showError();
          }
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          retry: () {
            cubit.getDetailPawnshop(widget.packageId);
          },
          textEmpty: 'Pawnshop not found',
          error: AppException(S.current.error, cubit.message),
          child: BaseDesignScreen(
            title: 'Loan package detail',
            bottomBar: Container(
              height: 91.h,
              color: AppTheme.getInstance().bgBtsColor(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                child: ButtonGradient(
                  onPressed: () {},
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    widget.packageType == 0
                        ? 'Sign loan contract'
                        : 'Send collateral',
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            child: (state is LoanPackageSuccess)
                ? SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 24.h,
                    ),
                    child: Column(
                      children: [
                        boxProfile(cubit.pawnshopPackage),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            typeLoan(cubit.pawnshopPackage),
                            Text(
                              '${cubit.pawnshopPackage.signContracts} '
                              'signed contracts',
                              style: textNormalCustom(
                                grey3,
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        spaceH12,
                        divider,
                        spaceH16,
                        rowItem(
                          'Available:',
                          '${cubit.pawnshopPackage.available} ${cubit.pawnshopPackage.loanToken?[0].symbol}',
                          color: deliveredColor,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loan limit:',
                              style: textNormalCustom(
                                grey3,
                                14,
                                FontWeight.w400,
                              ),
                            ),
                            spaceW8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowItem(
                                  'Min',
                                  '${cubit.pawnshopPackage.allowedLoanMin} ${cubit.pawnshopPackage.loanToken?[0].symbol}',
                                  color: deliveredColor,
                                ),
                                rowItem(
                                  'Max',
                                  '${cubit.pawnshopPackage.allowedLoanMax} ${cubit.pawnshopPackage.loanToken?[0].symbol}',
                                  color: redMarketColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        spaceH14,
                        rowItem(
                            'Duration',
                            '${cubit.pawnshopPackage.durationQtyTypeMin}-${cubit.pawnshopPackage.durationQtyTypeMax} '
                                '${cubit.pawnshopPackage.durationQtyType == 0 ? S.current.week : S.current.month}'),
                        spaceH14,
                        rowItem(
                          'LTV:',
                          '${cubit.pawnshopPackage.loanToValue}%',
                        ),
                        spaceH14,
                        Row(
                          children: [
                            Text(
                              'Collateral accepted:',
                              style: textNormalCustom(
                                grey3,
                                14,
                                FontWeight.w400,
                              ),
                            ),
                            spaceW5,
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if ((cubit
                                                  .pawnshopPackage
                                                  .acceptableAssetsAsCollateral
                                                  ?.length ??
                                              0) <
                                          8)
                                        ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: cubit
                                                  .pawnshopPackage
                                                  .acceptableAssetsAsCollateral
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, int index) {
                                            return Row(
                                              children: [
                                                SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image.network(
                                                    ImageAssets.getUrlToken(
                                                      cubit
                                                              .pawnshopPackage
                                                              .acceptableAssetsAsCollateral?[
                                                                  index]
                                                              .symbol ??
                                                          '',
                                                    ),
                                                  ),
                                                ),
                                                spaceW4,
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
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image.network(
                                                    ImageAssets.getUrlToken(
                                                      cubit
                                                              .pawnshopPackage
                                                              .acceptableAssetsAsCollateral?[
                                                                  index]
                                                              .symbol ??
                                                          '',
                                                    ),
                                                  ),
                                                ),
                                                spaceW4,
                                              ],
                                            );
                                          },
                                        ),
                                      if ((cubit
                                                  .pawnshopPackage
                                                  .acceptableAssetsAsCollateral
                                                  ?.length ??
                                              0) >
                                          7)
                                        Text(
                                          '& ${cubit.pawnshopPackage.acceptableAssetsAsCollateral!.length - 5} more',
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
                          ],
                        ),
                        spaceH14,
                        Row(
                          children: [
                            Text(
                              'Repayment token:',
                              style: textNormalCustom(
                                grey3,
                                14,
                                FontWeight.w400,
                              ),
                            ),
                            spaceW25,
                            SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: Image.network(
                                ImageAssets.getUrlToken(
                                  cubit.pawnshopPackage.repaymentToken?[0]
                                          .symbol ??
                                      '',
                                ),
                              ),
                            ),
                            spaceW4,
                            Text(
                              cubit.pawnshopPackage.repaymentToken?[0].symbol ??
                                  '',
                              style: textNormalCustom(
                                Colors.white,
                                14,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        spaceH14,
                        rowItem(
                          'Recurring interest:',
                          cubit.pawnshopPackage.recurringInterest == 0
                              ? 'weekly'
                              : 'monthly',
                        ),
                        spaceH14,
                        rowItem(
                          'Interest rate:',
                          '${cubit.pawnshopPackage.interest}% APR',
                        ),
                        spaceH14,
                        rowItem(
                          'Liquidation threshold:',
                          '${cubit.pawnshopPackage.interest}% APR',
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }

  Widget boxProfile(PawnshopPackage pawnshopPackage) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 12.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pawnshopPackage.name ?? '',
            style: textNormalCustom(
              Colors.white,
              20,
              FontWeight.w700,
            ),
          ),
          spaceH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pawnshopPackage.pawnshop?.name ?? '',
                style: textNormalCustom(
                  Colors.white,
                  16,
                  FontWeight.w600,
                ),
              ),
              spaceW6,
              if (pawnshopPackage.pawnshop?.isKYC ?? false) ...[
                sizedSvgImage(w: 16, h: 16, image: ImageAssets.ic_verify_svg)
              ]
            ],
          ),
          spaceH10,
          Row(
            children: [
              Image.asset(ImageAssets.img_star),
              spaceW6,
              Text(
                pawnshopPackage.pawnshop?.reputation.toString() ?? '',
                style: textNormalCustom(
                  Colors.white,
                  14,
                  FontWeight.w400,
                ),
              ),
              spaceW18,
              if (pawnshopPackage.pawnshop?.isKYC ?? false) ...[
                Image.asset(
                  ImageAssets.ic_identity,
                  height: 16.h,
                  width: 16.w,
                ),
                Text(
                  'Verified identity',
                  style: textNormalCustom(
                    grey3,
                    14,
                    FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
          spaceH20,
          Center(
            child: InkWell(
              onTap: () {
                /// TODO push profile
              },
              child: Container(
                height: 40.h,
                width: 122.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  border: Border.all(
                    color: fillYellowColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    'View profile',
                    style: textNormalCustom(
                      fillYellowColor,
                      16,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeLoan(PawnshopPackage pawnshopPackage) {
    switch (pawnshopPackage.type) {
      case 0:
        return Text(
          'Auto loan package',
          style: textNormalCustom(
            blueMarketColor,
            16,
            FontWeight.w600,
          ),
        );
      case 1:
        return Text(
          'Semi-auto loan package',
          style: textNormalCustom(
            orangeColor,
            16,
            FontWeight.w600,
          ),
        );
      case 2:
        return Text(
          'Negotiation loan package',
          style: textNormalCustom(
            redMarketColor,
            16,
            FontWeight.w600,
          ),
        );
      default:
        return Text(
          'P2P loan package',
          style: textNormalCustom(
            deliveredColor,
            16,
            FontWeight.w600,
          ),
        );
    }
  }

  Widget rowItem(String title, String value, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: textNormalCustom(
            grey3,
            16,
            FontWeight.w400,
          ),
        ),
        spaceW8,
        Text(
          value,
          style: textNormalCustom(
            color ?? Colors.white,
            16,
            FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
