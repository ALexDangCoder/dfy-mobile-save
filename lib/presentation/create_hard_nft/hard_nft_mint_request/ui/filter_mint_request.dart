import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/ui/widget/checkbox_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterMintRequest extends StatefulWidget {
  const FilterMintRequest({Key? key, required this.cubit}) : super(key: key);

  final HardNftMintRequestCubit cubit;

  @override
  _FilterMintRequestState createState() => _FilterMintRequestState();
}

class _FilterMintRequestState extends State<FilterMintRequest> {
  @override
  void initState() {
    super.initState();
    widget.cubit.listCheckStatus = widget.cubit.cachedStatus;
    widget.cubit.listCheckAssetType = widget.cubit.cachedAssetType;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        height: 550.h,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 9.h,
              ),
              SizedBox(
                height: 5.h,
                child: Center(
                  child: Image.asset(
                    ImageAssets.imgRectangle,
                  ),
                ),
              ),
              spaceH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    child: Text(
                      S.current.reset,
                      style: textNormalCustom(
                        AppTheme.getInstance().bgBtsColor(),
                        14,
                        null,
                      ),
                    ),
                  ),
                  Text(
                    S.current.filter,
                    style: textNormalCustom(
                      null,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.cubit.resetFilter();
                    },
                    child: Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().colorTextReset(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        S.current.reset,
                        style: textNormalCustom(
                          null,
                          14,
                          null,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              spaceH24,
              Text(
                S.current.asset_type_filter,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w600,
                ),
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkAssetTypeStream,
                builder: (context, snapshot) {
                  return CheckboxItem(
                    cubit: widget.cubit,
                    nameCheckbox: S.current.all,
                    isSelected: widget.cubit.checkAssetType(S.current.all),
                    typeFiler: S.current.asset_type_filter,
                  );
                },
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkAssetTypeStream,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.jewelry,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.jewelry),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.art_work,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.art_work),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                    ],
                  );
                },
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkAssetTypeStream,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.car,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.car),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.watch,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.watch),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                    ],
                  );
                },
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkAssetTypeStream,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.house,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.house),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.others,
                          isSelected:
                              widget.cubit.checkAssetType(S.current.others),
                          typeFiler: S.current.asset_type_filter,
                        ),
                      ),
                    ],
                  );
                },
              ),
              spaceH16,
              Text(
                S.current.status,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w600,
                ),
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkStatusStream,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.all,
                          isSelected: widget.cubit.checkStatus(S.current.all),
                          typeFiler: S.current.status,
                        ),
                      ),
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.evaluated,
                          isSelected:
                              widget.cubit.checkStatus(S.current.evaluated),
                          typeFiler: S.current.status,
                        ),
                      ),
                    ],
                  );
                },
              ),
              spaceH16,
              StreamBuilder<bool>(
                stream: widget.cubit.checkStatusStream,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.un_evaluated,
                          isSelected:
                              widget.cubit.checkStatus(S.current.un_evaluated),
                          typeFiler: S.current.status,
                        ),
                      ),
                      Expanded(
                        child: CheckboxItem(
                          cubit: widget.cubit,
                          nameCheckbox: S.current.nft_created,
                          isSelected:
                              widget.cubit.checkStatus(S.current.nft_created),
                          typeFiler: S.current.status,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 80.h,
              ),
              GestureDetector(
                onTap: () {
                  widget.cubit.filter();
                  widget.cubit.apply = false;
                  Navigator.pop(context);
                },
                child: ButtonGold(
                  isEnable: true,
                  title: S.current.apply,
                  height: 48.h,
                  textSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
