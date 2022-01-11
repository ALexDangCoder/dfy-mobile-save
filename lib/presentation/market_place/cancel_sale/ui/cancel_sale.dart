import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/market_place/cancel_sale/bloc/cancel_sale_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelSale extends StatefulWidget {
  final NFTDetailBloc bloc;
  final String walletAddress;
  final String dataString;
  final double gasLimit;

  const CancelSale({
    Key? key,
    required this.bloc,
    required this.walletAddress,
    required this.dataString,
    required this.gasLimit,
  }) : super(key: key);

  @override
  State<CancelSale> createState() => _CancelSaleState();
}

class _CancelSaleState extends State<CancelSale> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // widget.bloc.signTransactionWithData(
  // gasLimit: gasLimit.toString(),
  // gasPrice: gasPr.toString(),
  // walletAddress: widget.walletAddress,
  // withData: widget.bloc.dataString,
  // );

  @override
  Widget build(BuildContext context) {
    return Approve(
      listDetail: widget.bloc.initListApprove(),
      title: S.current.cancel_sale,
      header: Container(
        padding: EdgeInsets.only(
          top: 16.h,
          bottom: 20.h,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          S.current.cancel_sale_info,
          style: textNormal(
            AppTheme.getInstance().whiteColor(),
            16.sp,
          ).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      warning: Row(
        children: [
          sizedSvgImage(
              w: 16.67.w, h: 16.67.h, image: ImageAssets.ic_warning_canel),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Text(
              S.current.customer_cannot,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textNormal(
                AppTheme.getInstance().currencyDetailTokenColor(),
                14.sp,
              ),
            ),
          ),
        ],
      ),
      textActiveButton: S.current.cancel_sale,
      gasLimitInit: widget.gasLimit, typeApprove: TYPE_CONFIRM_BASE.CANCEL_SALE,
    );
  }
}
