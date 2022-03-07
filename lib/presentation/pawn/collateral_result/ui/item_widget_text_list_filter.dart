import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_text_filter.dart';

class ItemWidgetTextFilter extends StatefulWidget {
  final List<TokenModelPawn> list;
  final CollateralResultBloc bloc;

  const ItemWidgetTextFilter({
    Key? key,
    required this.list,
    required this.bloc,
  }) : super(key: key);

  @override
  _ItemWidgetTextFilterState createState() => _ItemWidgetTextFilterState();
}

class _ItemWidgetTextFilterState extends State<ItemWidgetTextFilter> {
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
        child: GridView.builder(
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
            return ItemTextFilter(
              index: index,
              bloc: widget.bloc,
            );
          },
        ),
      ),
    );
  }
}
