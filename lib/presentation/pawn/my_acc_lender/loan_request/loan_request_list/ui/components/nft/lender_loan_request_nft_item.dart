import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/nft_pawn_model.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/views/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class LenderLoanRequestNftItem extends StatelessWidget {
  const LenderLoanRequestNftItem({
    Key? key,
    required this.cubit,
    required this.nftModel,
  }) : super(key: key);
  final LoanRequestCryptoModel nftModel;
  final LenderLoanRequestCubit cubit;

  @override
  Widget build(BuildContext context) {
    final nftItem = nftModel.nftModel;
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      margin: EdgeInsets.only(bottom: 16.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().bgBtsColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageFtNameNft(
            nftModel: nftItem ?? NFTPawnModel(),
            isHardNft: (nftItem?.nftType == 1)? true : false,
          ),
          spaceH12,
          _rowItem(
            title: S.current.borrower.capitalize(),
            description: Text(
              (nftModel.collateralOwner?.walletAddress ?? '')
                  .formatAddressWalletConfirm(),
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ).copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.duration.capitalize(),
            description: Text(
              cubit.categoryOneOrMany(
                durationQty: nftModel.durationQty ?? 0,
                durationType: nftModel.durationType ?? 0,
              ),
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.asset_location.capitalize(),
            description: Text(
              'tam thoi dang trong do be chua co data',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.status.capitalize(),
            description: Text(
              cubit.getStatus(nftModel.status.toString()),
              style: textNormalCustom(
                cubit.getColor(nftModel.status.toString()),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH16,
          Container(
            height: 1.h,
            color: AppTheme.getInstance().divideColor(),
          ),
          spaceH16,
          _rowItem(
            title: S.current.expected_loan.capitalize(),
            description: Text(
              '${formatValue.format(nftModel.expectedLoanAmount)} ${nftModel.expectedLoanSymbol}',
              style: textNormalCustom(
                AppTheme.getInstance().successTransactionColors(),
                24,
                FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _imageFtNameNft({
    bool? isHardNft = false,
    required NFTPawnModel nftModel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: CustomImageNetwork(
                  image: ApiConstants.BASE_URL_IMAGE +
                      (nftModel.nftAvatarCid ?? ''),
                ),
              ),
              if (isHardNft ?? false)
                Positioned(
                  top: 0.h,
                  right: 7.w,
                  child: const Image(
                    image: AssetImage(ImageAssets.img_hard_nft),
                  ),
                )
              else
                Container()
            ],
          ),
        ),
        spaceW10,
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nftModel.nftName ?? '',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              spaceH8,
              Row(
                children: [
                  Text(
                    nftModel.collectionName ?? '',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteWithOpacitySevenZero(),
                      14,
                      FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Row _rowItem({
    required String title,
    required Widget description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        spaceW10,
        Expanded(
          flex: 6,
          child: description,
        )
      ],
    );
  }
}
