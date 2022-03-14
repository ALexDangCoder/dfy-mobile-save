import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/collateral_nft_result/bloc/collateral_result_nft_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemTextFilter extends StatefulWidget {
  final int index;
  final CollateralResultNFTBloc bloc;

  const ItemTextFilter({
    Key? key,
    required this.index,
    required this.bloc,
  }) : super(key: key);

  @override
  State<ItemTextFilter> createState() => _ItemTextFilterState();
}

class _ItemTextFilterState extends State<ItemTextFilter> {
  @override
  Widget build(BuildContext context) {
    late bool isCheck;
    late String name;
    isCheck = widget.bloc.listAssetFilter[widget.index].isCheck;
    name = widget.bloc.listAssetFilter[widget.index].symbol.toString();
    void check() {
      late bool value;
      if (isCheck) {
        value = false;
      } else {
        value = true;
      }
      isCheck = value;
      widget.bloc.listAssetFilter[widget.index].isCheck = value;
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
          child: SizedBox(
            width: 100.w,
            child: Text(
              name,
              maxLines: 1,
              style: textNormalCustom(
                null,
                16,
                FontWeight.w400,
              ).copyWith(overflow: TextOverflow.ellipsis),
            ),
          ),
        )
      ],
    );
  }
}
