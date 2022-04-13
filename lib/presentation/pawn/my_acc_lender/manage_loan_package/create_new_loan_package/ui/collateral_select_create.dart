import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/bloc/create_new_loan_package_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/ui/item_collateral_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollateralSelectCreate extends StatefulWidget {
  const CollateralSelectCreate({
    Key? key,
    required this.cubit,
    required this.listToken,
  }) : super(key: key);
  final CreateNewLoanPackageCubit cubit;
  final List<TokenInf> listToken;

  @override
  _CollateralSelectCreateState createState() => _CollateralSelectCreateState();
}

class _CollateralSelectCreateState extends State<CollateralSelectCreate> {
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
              itemCount: widget.listToken.length,
              itemBuilder: (context, index) {
                return ItemCollateralCreateLoanPackage(
                  cubit: widget.cubit,
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
