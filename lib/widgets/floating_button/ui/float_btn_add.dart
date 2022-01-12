import 'package:Dfy/config/resources/styles.dart';
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
  FABMarketBase({Key? key}) : super(key: key);
  final cubit = FabCubit();
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
      spaceBetweenChildren: 7,
      overlayOpacity: 0.6,
      childrenButtonSize: Size(70.w, 70.h),
      overlayColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      spacing: 7,
      children: [
        SpeedDialChild(
          onTap: () {},
          child: fabCreateCollection(
            isCancel: false,
            typeCreateFab: typeCreateFAB.COLLECTION,
          ),
        ),
        SpeedDialChild(
          onTap: () {},
          child: fabCreateCollection(
            isCancel: false,
            typeCreateFab: typeCreateFAB.NFT,
          ),
        ),
      ],
      child: StreamBuilder<bool>(
        stream: cubit.isAddingEvent,
        initialData: false,
        builder: (context, snapshot) {
          return fabAdd();
        },
      ),
    );
  }

  Widget fabCancel() {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Image.asset(ImageAssets.fabCancel),
    );
  }

  Widget fabAdd() {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color.fromRGBO(255, 219, 101, 1),
            Color.fromRGBO(228, 172, 26, 1),
          ],
        ),
      ),
      child: Icon(Icons.add),
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(255, 219, 101, 1),
                  Color.fromRGBO(228, 172, 26, 1),
                ],
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
                      fit: BoxFit.none,
                      child: Text(
                        typeCreateFab == typeCreateFAB.COLLECTION
                            ? 'Collection'
                            : 'NFT',
                        style: textNormalCustom(
                          Colors.white,
                          8,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
