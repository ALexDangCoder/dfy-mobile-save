import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsSport extends StatelessWidget {
  final String title;
  final CollectionBloc collectionBloc;

  const IsSport({
    Key? key,
    required this.title,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: collectionBloc.isSports,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return Transform.scale(
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
                  value: snapshot.data ?? false,
                  onChanged: (value) {
                    collectionBloc.isSports.sink.add(true);
                    if (snapshot.data ?? false) {
                      collectionBloc.isSports.sink.add(false);
                    }
                  },
                  activeColor: AppTheme.getInstance().whiteColor(),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  if (collectionBloc.isSports.value) {
                    collectionBloc.isSports.sink.add(false);
                  } else {
                    collectionBloc.isSports.sink.add(true);
                  }
                },
                child: Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
