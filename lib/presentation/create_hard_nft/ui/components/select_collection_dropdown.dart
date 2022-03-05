import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDropDown extends StatelessWidget {
  final ProvideHardNftCubit cubit;

  const CategoriesDropDown({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<List<Map<String, dynamic>>>(
          stream:  cubit.collectionsBHVSJ,
          builder: (context, snapshot) {
            final List<Map<String, dynamic>> dropdownItemList =
                snapshot.data ?? [];
            return CoolDropdown(
              dropdownItemMainAxis: MainAxisAlignment.start,
              resultMainAxis: MainAxisAlignment.start,
              dropdownList: dropdownItemList,
              gap: 8.h,
              dropdownItemReverse: true,
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
              selectedItemBD: BoxDecoration(
                color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
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
              onChange: (selected) {
                selected as Map<String, dynamic>;
                cubit.dataStep1.collection = selected.getStringValue('label');
                cubit.dataStep1.addressCollection =
                    selected.getStringValue('value');
                cubit.dataStep1.collectionID = selected.getStringValue('id');
                cubit.mapValidate['collection'] = true;
                cubit.validateAll();
              },
              resultIcon: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: sizedSvgImage(
                  w: 13,
                  h: 13,
                  image: ImageAssets.ic_expand_white_svg,
                ),
              ),
              placeholder: S.current.collection_name,
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
