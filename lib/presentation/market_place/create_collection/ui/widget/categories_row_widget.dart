import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryRow extends StatelessWidget {
  final CreateCollectionBloc bloc;

  const CategoryRow({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().backgroundBTSColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          sizedSvgImage(
            w: 20,
            h: 20,
            image: ImageAssets.ic_folder_svg,
          ),
          Expanded(
            child: StreamBuilder<List<DropdownMenuItem<String>>>(
              stream: bloc.listCategorySubject,
              builder: (context, snapshot) {
                final List<DropdownMenuItem<String>> menuItems =
                    snapshot.data ?? [];
                return DropdownButtonFormField<String>(
                  icon: sizedSvgImage(
                    w: 10,
                    h: 10,
                    image: ImageAssets.ic_expand_white_svg,
                  ),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    hintText: S.current.categories,
                    hintStyle: textNormal(
                      Colors.white.withOpacity(0.5),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                  dropdownColor: Colors.transparent,
                  onChanged: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    bloc.setCategory(value ?? '');
                    bloc.validateCase(
                      hintText: S.current.categories,
                      value: value ?? '',
                      inputCase: 'category',
                    );
                  },
                  items: menuItems,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
