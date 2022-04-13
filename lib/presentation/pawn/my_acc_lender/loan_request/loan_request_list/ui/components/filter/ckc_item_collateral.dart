import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCheckBoxCollateral extends StatefulWidget {
  const ItemCheckBoxCollateral({
    Key? key,
    required this.index,
    required this.cubit,
  }) : super(key: key);
  final int index;
  final LenderLoanRequestCubit cubit;

  @override
  _ItemCheckBoxCollateralState createState() => _ItemCheckBoxCollateralState();
}

class _ItemCheckBoxCollateralState extends State<ItemCheckBoxCollateral> {
  late bool check;

  @override
  void initState() {
    super.initState();
    check = widget.cubit.listTokenFilter[widget.index].isCheck;
  }

  void checker() {
    widget.cubit.appendFilterCollateral(
        widget.cubit.listTokenFilter[widget.index].symbol ?? '');
    if (check) {
      widget.cubit.listTokenFilter[widget.index].isCheck = false;
      check = false;
    } else {
      widget.cubit.listTokenFilter[widget.index].isCheck = true;
      check = true;
    }
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
            widget.cubit.listTokenFilter[widget.index].url ?? '',
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
              widget.cubit.listTokenFilter[widget.index].symbol ?? '',
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
