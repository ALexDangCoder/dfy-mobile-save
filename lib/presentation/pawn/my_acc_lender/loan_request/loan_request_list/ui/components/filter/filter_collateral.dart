import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/filter/ckc_item_collateral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterCollateral extends StatefulWidget {
  const FilterCollateral({
    Key? key,
    required this.list,
    required this.cubit,
  }) : super(key: key);
  final List<TokenModelPawn> list;
  final LenderLoanRequestCubit cubit;

  @override
  _FilterCollateralState createState() => _FilterCollateralState();
}

class _FilterCollateralState extends State<FilterCollateral> {
  late ScrollController _controllerScrollBar;

  @override
  void initState() {
    super.initState();
    _controllerScrollBar = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().borderItemColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          border: Border.all(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
        height: 138.w,
        child: Theme(
          data: ThemeData(
            highlightColor: AppTheme.getInstance().colorTextReset(),
          ),
          child: Scrollbar(
            thickness: 4.w,
            isAlwaysShown: true,
            controller: _controllerScrollBar,
            radius: Radius.circular(10.r),
            child: GridView.builder(
              controller: _controllerScrollBar,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 55 / 15,
              ),
              padding: EdgeInsets.only(
                top: 5.h,
                bottom: 5.h,
                left: 15.w,
                right: 15.w,
              ),
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return ItemCheckBoxCollateral(
                  index: index,
                  cubit: widget.cubit,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
