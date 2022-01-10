import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/cancel_sale/bloc/cancel_sale_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelSale extends StatelessWidget {
  final CancelSaleCubit cubit;

  const CancelSale({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Approve(
      listDetail: cubit.initListApprove(),
      action: () {},
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
      approve: () {},
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
    );
  }
}
