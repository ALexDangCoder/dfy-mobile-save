import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsCheckBoxSelectOne extends StatelessWidget {
  final String title;
  final DetailCollectionBloc bloc;
  final int index;

  const IsCheckBoxSelectOne({
    Key? key,
    required this.title,
    required this.bloc,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.chooseViewTypeFilterAll(index);
      },
      child: Row(
        children: [
          Expanded(
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
                value: bloc.listViewTypeFilterNft[index],
                onChanged: (value) {
                  bloc.chooseViewTypeFilterAll(index);
                },
              ),
            ),
          ),
          spaceW4,
          Expanded(
            flex: 3,
            child: Wrap(
              children: [
                Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
