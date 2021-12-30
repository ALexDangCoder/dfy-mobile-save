import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsSortNft extends StatelessWidget {
  final String title;
  final DetailCollectionBloc collectionBloc;

  const IsSortNft({
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
            stream: collectionBloc.isSoftNft,
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
                    collectionBloc.isSoftNft.sink.add(true);
                    if (snapshot.data ?? false) {
                      collectionBloc.isSoftNft.sink.add(false);
                    }
                  },
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
                  if (collectionBloc.isSoftNft.value) {
                    collectionBloc.isSoftNft.sink.add(false);
                  } else {
                    collectionBloc.isSoftNft.sink.add(true);
                  }
                },
                child: Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
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
