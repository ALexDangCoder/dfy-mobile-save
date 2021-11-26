import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsArt extends StatelessWidget {
  final String title;
  final CollectionBloc collectionBloc;

  const IsArt({
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
            stream: collectionBloc.isArt,
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
                    collectionBloc.isArt.sink.add(true);
                    if (snapshot.data ?? false) {
                      collectionBloc.isArt.sink.add(false);
                    }
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              if (collectionBloc.isArt.value) {
                collectionBloc.isArt.sink.add(false);
              } else {
                collectionBloc.isArt.sink.add(true);
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
        ),
      ],
    );
  }
}
