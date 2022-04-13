import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/bloc/create_new_loan_package_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollateralCreateLoanPackage extends StatefulWidget {
  const ItemCollateralCreateLoanPackage({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);
  final int index;
  final CreateNewLoanPackageCubit cubit;

  @override
  _ItemCollateralCreateLoanPackageState createState() =>
      _ItemCollateralCreateLoanPackageState();
}

class _ItemCollateralCreateLoanPackageState
    extends State<ItemCollateralCreateLoanPackage> {
  late bool check;

  @override
  void initState() {
    super.initState();
    check = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checker() {
    if (check) {
      widget.cubit.listCollateralToken[widget.index].isSelect = false;
      check = false;
    } else {
      widget.cubit.listCollateralToken[widget.index].isSelect = true;
      check = true;
    }
    widget.cubit.checkIsSelectedCollateralsToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24.w,
          child: Transform.scale(
            scale: 1.34.sp,
            child: Checkbox(
              fillColor: MaterialStateProperty.all(
                AppTheme.getInstance().fillColor(),
              ),
              checkColor: AppTheme.getInstance().whiteColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              side: BorderSide(
                width: 1.w,
                color: AppTheme.getInstance().whiteColor(),
              ),
              value: check,
              onChanged: (value) {
                checker();
              },
            ),
          ),
        ),
        spaceW4,
        GestureDetector(
          onTap: () {
            checker();
          },
          child: Image.network(
            ImageAssets.getUrlToken(
                widget.cubit.listCollateralToken[widget.index].symbol ?? ''),
            width: 20.w,
            height: 20.w,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppTheme.getInstance().bgBtsColor(),
              width: 20.w,
              height: 20.w,
            ),
          ),
        ),
        spaceW4,
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () {
              checker();
            },
            child: Text(
              widget.cubit.listCollateralToken[widget.index].symbol ?? '',
              maxLines: 1,
              style: textNormalCustom(
                null,
                16,
                FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
