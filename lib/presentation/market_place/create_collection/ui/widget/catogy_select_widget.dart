import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCategory extends StatefulWidget {
  final CreateCollectionBloc bloc;

  const SelectCategory({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _SelectCategory createState() => _SelectCategory();
}

class _SelectCategory extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().selectDialogColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          StreamBuilder<List<Category>>(
            stream: widget.bloc.listCategorySubject,
            builder: (context, snapshot) {
              final categories = snapshot.data ?? [];
              if(categories.isNotEmpty){
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: categories.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 24.w),
                          height: 44.h,
                          width: 343.w,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              categories[index].name ?? '',
                              style: textNormal(
                                AppTheme.getInstance().textThemeColor(),
                                16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else {
                return const SizedBox.shrink();
              }
            }
          )
        ],
      ),
    );
  }
}
