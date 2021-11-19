import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsGame extends StatelessWidget {
  final String title;
  final CollectionBloc collectionBloc;

  const IsGame({
    Key? key,
    required this.title,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 24.h,
      margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
      child: Row(

        children: [
          StreamBuilder(
            stream: collectionBloc.isGame,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return Checkbox(
                fillColor: MaterialStateProperty.all(
                  AppTheme.getInstance().fillColor(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                value: snapshot.data ?? false,
                onChanged: (value) {
                  collectionBloc.isGame.sink.add(true);
                  if (snapshot.data ?? false) {
                    collectionBloc.isGame.sink.add(false);
                  }
                },
                activeColor: AppTheme.getInstance().whiteColor(),
              );
            },
          ),

          Text(
            title,
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              16,
            ),
          ),
        ],
      ),
    );
  }
}
