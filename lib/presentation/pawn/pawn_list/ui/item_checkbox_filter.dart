import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/pawn_list/bloc/pawn_list_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeCheckBox { LOAN, COLLATERAL }

class ItemCheckBoxFilter extends StatefulWidget {
  final int index;
  final PawnListBloc bloc;
  final TypeCheckBox typeCheckBox;

  const ItemCheckBoxFilter({
    Key? key,
    required this.index,
    required this.bloc,
    required this.typeCheckBox,
  }) : super(key: key);

  @override
  State<ItemCheckBoxFilter> createState() => _ItemCheckBoxFilterState();
}

class _ItemCheckBoxFilterState extends State<ItemCheckBoxFilter> {
  @override
  Widget build(BuildContext context) {
    late bool isCheck;
    late String name;
    if (widget.typeCheckBox == TypeCheckBox.LOAN) {
      isCheck = widget.bloc.listLoanTokenFilter[widget.index].isCheck;
      name = widget.bloc.listLoanTokenFilter[widget.index].symbol
          .toString()
          .toUpperCase();
    } else {
      isCheck = widget.bloc.listCollateralTokenFilter[widget.index].isCheck;
      name = widget.bloc.listCollateralTokenFilter[widget.index].symbol
          .toString()
          .toUpperCase();
    }
    void check() {
      late bool value;
      if (isCheck) {
        value = false;
      } else {
        value = true;
      }
      isCheck = value;
      if (widget.typeCheckBox == TypeCheckBox.LOAN) {
        widget.bloc.listLoanTokenFilter[widget.index].isCheck = value;
      } else {
        widget.bloc.listCollateralTokenFilter[widget.index].isCheck = value;
      }
      setState(() {});
    }

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
              value: isCheck,
              onChanged: (value) {
                check();
              },
            ),
          ),
        ),
        spaceW4,
        GestureDetector(
          onTap: () {
            check();
          },
          child: Image.network(
            ImageAssets.getSymbolAsset(
              name,
            ),
            width: 20.w,
            height: 20.w,
            fit: BoxFit.fill,
          ),
        ),
        spaceW4,
        GestureDetector(
          onTap: () {
            check();
          },
          child: Text(
            name,
            style: textNormalCustom(
              null,
              16,
              FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
