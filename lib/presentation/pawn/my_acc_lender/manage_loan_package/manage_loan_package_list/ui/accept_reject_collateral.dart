import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/manage_loan_package_list/loan_package_detail/bloc/loan_package_detail_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AcceptRejectCollateral extends StatelessWidget {
  const AcceptRejectCollateral({
    Key? key,
    required this.cubit,
    required this.collateralModel,
  }) : super(key: key);
  final LoanPackageDetailCubit cubit;
  final CollateralResultModel collateralModel;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: _buildBtn(context),
      title: 'Collateral detail',
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              spaceH24,
              _rowItemNormal(
                title: 'Status:',
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
              SizedBox(
                height: 16.h,
              ),
              _rowItem(
                title: 'Message:',
                description: collateralModel.description ?? '',
              ),
              SizedBox(
                height: 16.h,
              ),
              _rowItem(
                title: 'Collateral:',
                isLoanAmount: true,
                urlToken: collateralModel.collateralSymbol ?? '',
                description:
                    formatPrice.format(collateralModel.collateralAmount),
                // description: cryptoModel.loanSymbol ?? DFY,
              ),
              SizedBox(
                height: 16.h,
              ),
              _rowItemNormal(
                title: 'Loan currency:',
                description: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.network(
                        ImageAssets.getUrlToken(
                            collateralModel.loanSymbol ?? ''),
                      ),
                    ),
                    spaceW6,
                    Text(
                      collateralModel.loanSymbol ?? '',
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildBtn(BuildContext context) {
    return ((collateralModel.status ?? 0) == 1)
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 38.h),
            color: AppTheme.getInstance().bgBtsColor(),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final hexString = await Web3Utils().getAcceptPackageData(
                        collateralId: collateralModel.bcCollateralId.toString(),
                        packageId: cubit.pawnShopPackage.bcPackageId.toString(),
                      );
                      //todo nhớ check balance
                      goTo(
                        context,
                        Approve(
                          title: 'Confirm accept collateral',
                          textActiveButton: 'Accept',
                          hexString: hexString,
                          needApprove: true,
                          payValue: cubit.pawnShopPackage.allowedLoanMax.toString(),
                          tokenAddress: ImageAssets.getAddressToken((cubit.pawnShopPackage.loanToken ?? [])[0]
                              .symbol ??
                              ''),
                          onErrorSign: (context) async {
                            await showLoadFail(context);
                          },
                          onSuccessSign: (context, data) async {
                            //Be
                            await cubit.postAcceptCollateralAfterCFBC(
                              loanRequestId: collateralModel.id.toString(),
                            );
                            unawaited(
                              showLoadSuccess(context).then((value) {
                                Navigator.of(context).popUntil((route) {
                                  return route.settings.name ==
                                      AppRouter.manage_loan_package;
                                });
                              }),
                            );
                          },
                          spender:
                              Get.find<AppConstants>().crypto_pawn_contract,
                        ),
                      );
                    },
                    child: Container(
                      height: 64.h,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 4.r,
                          center: const Alignment(
                            0.5,
                            -0.5,
                          ),
                          colors: AppTheme.getInstance().gradientButtonColor(),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            22.r,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Accept',
                          style: textNormalCustom(
                            null,
                            20,
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                spaceW20,
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final hexString = await Web3Utils().getRejectPackageData(
                        collateralId: collateralModel.bcCollateralId.toString(),
                        packageId: cubit.pawnShopPackage.bcPackageId.toString(),
                      );
                      goTo(
                        context,
                        Approve(
                          title: 'Cancel loan package',
                          textActiveButton: 'Cancel loan package',
                          hexString: hexString,
                          onErrorSign: (context) async {
                            await showLoadFail(context);
                          },
                          onSuccessSign: (context, data) async {
                            //Be
                            await cubit.postRejectCollateralAfterCFBC(
                              loanRequestId: collateralModel.id.toString(),
                            );
                            unawaited(
                              showLoadSuccess(context).then((value) {
                                Navigator.of(context).popUntil((route) {
                                  return route.settings.name ==
                                      AppRouter.manage_loan_package;
                                });
                              }),
                            );
                          },
                          spender:
                              Get.find<AppConstants>().crypto_pawn_contract,
                        ),
                      );
                    },
                    child: Container(
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().borderItemColor(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            22.r,
                          ),
                        ),
                        border: Border.all(
                          color: AppTheme.getInstance().fillColor(),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                          style: textNormalCustom(
                            AppTheme.getInstance().fillColor(),
                            20,
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : null;
    // return ((collateralModel.status ?? 0) == 1)
    //     ?
    // Container(
    //         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 38.h),
    //         color: AppTheme.getInstance().bgBtsColor(),
    //         child: Row(
    //           // mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 height: 64.h,
    //                 decoration: BoxDecoration(
    //                   gradient: RadialGradient(
    //                     radius: 4.r,
    //                     center: const Alignment(
    //                       0.5,
    //                       -0.5,
    //                     ),
    //                     colors: AppTheme.getInstance().gradientButtonColor(),
    //                   ),
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(
    //                       22.r,
    //                     ),
    //                   ),
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     'Accept',
    //                     style: textNormalCustom(
    //                       null,
    //                       20,
    //                       FontWeight.w700,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             spaceW20,
    //             Expanded(
    //               child: Container(
    //                 height: 64.h,
    //                 decoration: BoxDecoration(
    //                   color: AppTheme.getInstance().borderItemColor(),
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(
    //                       22.r,
    //                     ),
    //                   ),
    //                   border: Border.all(
    //                     color: AppTheme.getInstance().fillColor(),
    //                   ),
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     'Reject',
    //                     style: textNormalCustom(
    //                       AppTheme.getInstance().fillColor(),
    //                       20,
    //                       FontWeight.w700,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     : null;
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
            title,
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
}
