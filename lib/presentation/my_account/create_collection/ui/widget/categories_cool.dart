import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesCool extends StatelessWidget {
  final CreateCollectionCubit bloc;

  const CategoriesCool({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<List<Map<String, String>>>(
          stream: bloc.listCategorySubject,
          builder: (context, snapshot) {
            final List<Map<String, String>> dropdownItemList =
                snapshot.data ?? [];
            return CoolDropdown(
              gap: 8.h,
              isTriangle: false,
              dropdownItemHeight: 54.h,
              dropdownHeight: dropdownItemList.length < 4
                  ? (54 * dropdownItemList.length).h
                  : 232.h,
              dropdownWidth: 343.w,
              resultWidth: 343.w,
              resultHeight: 64.h,
              dropdownBD: BoxDecoration(
                color: AppTheme.getInstance().selectDialogColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              resultBD: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              resultTS: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              selectedItemTS: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              unselectedItemTS: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              selectedItemBD: BoxDecoration(
                color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
              ),
              dropdownList: dropdownItemList,
              onChange: (selected) {
                bloc.validateCategory(selected['value']);
                bloc.validateCreate();
              },
              resultIcon: const SizedBox.shrink(),
              placeholder: S.current.categories,
              placeholderTS: textNormal(
                Colors.white.withOpacity(0.5),
                16,
              ),
              dropdownItemBottomGap: 0,
              dropdownItemTopGap: 0,
              resultPadding: EdgeInsets.only(left: 52.w),
            );
          },
        ),
        Positioned(
          right: 19.w,
          child: SizedBox(
            height: 64.h,
            child: sizedSvgImage(
              w: 13,
              h: 13,
              image: ImageAssets.ic_expand_white_svg,
            ),
          ),
        ),
        Positioned(
          left: 14.w,
          child: SizedBox(
            height: 64.h,
            child:
                sizedSvgImage(w: 20, h: 20, image: ImageAssets.ic_folder_svg),
          ),
        ),
      ],
    );
  }
}
