import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_check_box_filter.dart';

class ItemWidgetFilter extends StatefulWidget {
  final List<TokenModelPawn> list;
  final CollateralResultBloc bloc;
  final TypeCheckBox type;

  const ItemWidgetFilter({
    Key? key,
    required this.list,
    required this.bloc,
    required this.type,
  }) : super(key: key);

  @override
  _ItemWidgetFilterState createState() => _ItemWidgetFilterState();
}

class _ItemWidgetFilterState extends State<ItemWidgetFilter> {
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
                return ItemCheckBoxFilter(
                  index: index,
                  typeCheckBox: widget.type,
                  bloc: widget.bloc,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
