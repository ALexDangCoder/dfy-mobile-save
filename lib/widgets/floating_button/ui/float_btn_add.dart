import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/floating_button/bloc/fab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

enum typeCreateFAB {
  COLLECTION,
  NFT,
}

class FABMarketBase extends StatelessWidget {
  FABMarketBase({
    Key? key,
    required this.collectionCallBack,
    required this.nftCallBack,
  }) : super(key: key);
  final Function() nftCallBack;
  final Function() collectionCallBack;
  static final cubit = FabCubit();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      onOpen: () {
        if (!value) {
          value = true;
          cubit.addToCancelOrReverse(value: true);
        } else {
          value = false;
          cubit.addToCancelOrReverse(value: false);
        }
      },
      onClose: () {
        if (!value) {
          value = true;
          cubit.addToCancelOrReverse(value: true);
        } else {
          value = false;
          cubit.addToCancelOrReverse(value: false);
        }
      },
      elevation: 0,
      buttonSize: Size(50.w, 50.h),
      spaceBetweenChildren: 7,
      overlayOpacity: 0.6,
      childrenButtonSize: Size(75.w, 75.h),
      overlayColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      spacing: 7,
      children: [
        SpeedDialChild(
          onTap: collectionCallBack,
          child: fabCreateCollection(
            isCancel: false,
            typeCreateFab: typeCreateFAB.COLLECTION,
          ),
        ),
        SpeedDialChild(
          onTap: nftCallBack,
          child: fabCreateCollection(
            isCancel: false,
            typeCreateFab: typeCreateFAB.NFT,
          ),
        ),
      ],
      child: fabAddFtFabCancel(),
    );
  }

  Widget fabAddFtFabCancel() {
    return StreamBuilder<bool>(
      stream: cubit.isAddingEvent,
      initialData: false,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Visibility(visible: !snapshot.data!, child: fabAdd()),
            Visibility(visible: snapshot.data!, child: fabCancel()),
          ],
        );
      },
    );
  }

  Widget fabCancel() {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: Image.asset(ImageAssets.fabCancel),
    );
  }

  Widget fabAdd() {
    return Container(
      width: 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: AppTheme.getInstance().colorFab()),
      ),
      child: Icon(Icons.add, size: 32.sp),
    );
  }

  Widget fabCreateCollection({
    required bool isCancel,
    required typeCreateFAB typeCreateFab,
  }) {
    return isCancel
        ? SizedBox(
            height: 41.26.h,
            width: 41.25.w,
            child: Image.asset(
              ImageAssets.fabCancel,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: AppTheme.getInstance().colorFab(),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  top: 10.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 23.3.h,
                      width: 23.3.w,
                      child: typeCreateFab == typeCreateFAB.COLLECTION
                          ? Image.asset(ImageAssets.folderFAB)
                          : Image.asset(ImageAssets.nftFAB),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 36,
                  bottom: 11.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                          typeCreateFab == typeCreateFAB.COLLECTION
                              ? 'Collection'
                              : 'NFT',
                          style: textNormalCustom(
                            Colors.white,
                            8,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}
