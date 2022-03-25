import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.userProfile}) : super(key: key);
  final UserProfile userProfile;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late EditProfileCubit cubit;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = EditProfileCubit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    nameController.text = widget.userProfile.pawnshop?.name ?? '';
    phoneController.text = widget.userProfile.pawnshop?.phoneNumber ?? '';
    addressController.text = widget.userProfile.pawnshop?.address ?? '';
    descriptionController.text = widget.userProfile.pawnshop?.description ?? '';
    cubit.coverCid = widget.userProfile.pawnshop?.cover ?? '';
    cubit.mediaFileCid = widget.userProfile.pawnshop?.avatar ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      bloc: cubit,
      builder: (context, state) {
        return BaseDesignScreen(
          isImage: false,
          text: S.current.save,
          onRightClick: () async {
            if (nameController.text != '' &&
                phoneController.text != '' &&
                addressController.text != '' &&
                descriptionController.text != '' &&
                (cubit.selectImage.value == StatusPickFile.START ||
                    cubit.selectImage.value == StatusPickFile.PICK_SUCCESS) &&
                (cubit.selectCover.value == StatusPickFile.START ||
                    cubit.selectCover.value == StatusPickFile.PICK_SUCCESS)) {
              unawaited(showLoadingDialog(context, showLoading: true));
              await cubit.saveInfoToBE(
                name: nameController.text,
                address: addressController.text,
                email: widget.userProfile.pawnshop?.email ?? '',
                phoneNum: phoneController.text,
                description: descriptionController.text,
                avatar: cubit.mediaFileCid,
                cover: cubit.coverCid,
              );
              await showLoadSuccess(context, onlySuccess: true).then(
                (value) => Navigator.of(context)
                  ..pop()
                  ..pop(true),
              );
            } else if (cubit.selectImage.value != StatusPickFile.START ||
                cubit.selectImage.value != StatusPickFile.PICK_SUCCESS ||
                cubit.selectCover.value != StatusPickFile.START ||
                cubit.selectCover.value != StatusPickFile.PICK_SUCCESS) {
              showDialogSuccess(
                context,
                alert: 'Waiting...',
                text: 'Waiting some minutes to upload image to server.',
                onlyPop: true,
              );
            } else {
              cubit.checkEmpty(
                name: nameController.text,
                phoneNumber: phoneController.text,
                address: addressController.text,
                description: descriptionController.text,
              );
            }
          },
          title: 'Edit pawnshop info',
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceH12,
                boxCover(context),
                spaceH12,
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.userProfile.pawnshop?.name ?? '',
                        style: textNormalCustom(
                          Colors.white,
                          20,
                          FontWeight.w600,
                        ),
                      ),
                      spaceH8,
                      Text(
                        'Joined in ${cubit.date(
                          widget.userProfile.pawnshop?.createAt ?? 0,
                        )}',
                        style: textNormalCustom(
                          textPawnGray,
                          16,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      if (widget.userProfile.kyc != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: ImageAssets.ic_verify_svg,
                            ),
                            spaceW5,
                            Text(
                              'Identity verified',
                              style: textNormalCustom(
                                textPawnGray,
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                      spaceH4,
                      Container(
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: nameController,
                                maxLength: 100,
                                onChanged: (value) {
                                  if (value == '') {
                                    cubit.errorName.add('Name is not null');
                                  } else {
                                    cubit.errorName.add('');
                                  }
                                },
                                cursorColor:
                                    AppTheme.getInstance().whiteColor(),
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isCollapsed: true,
                                  counterText: '',
                                  hintText: S.current.enter_name,
                                  hintStyle: textNormal(
                                    Colors.white.withOpacity(0.5),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: cubit.errorName,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<String> snapshot,
                        ) {
                          if (snapshot.data != '') {
                            return SizedBox(
                              child: Text(
                                snapshot.data ?? '',
                                style: textNormal(
                                  Colors.red,
                                  12,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH16,
                      Text(
                        'Email',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                      spaceH4,
                      Container(
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.userProfile.pawnshop?.email ?? '',
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH16,
                      Text(
                        'Phone number',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                      spaceH4,
                      Container(
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d{0,20}'),
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                controller: phoneController,
                                maxLength: 50,
                                onChanged: (value) {
                                  if (value == '') {
                                    cubit.errorPhone
                                        .add('Phone number is not null');
                                  } else {
                                    cubit.errorPhone.add('');
                                  }
                                },
                                cursorColor:
                                    AppTheme.getInstance().whiteColor(),
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isCollapsed: true,
                                  counterText: '',
                                  hintText: S.current.enter_phone_num,
                                  hintStyle: textNormal(
                                    Colors.white.withOpacity(0.5),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: cubit.errorPhone,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<String> snapshot,
                        ) {
                          if (snapshot.data != '') {
                            return SizedBox(
                              child: Text(
                                snapshot.data ?? '',
                                style: textNormal(
                                  Colors.red,
                                  12,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH16,
                      Text(
                        'Address',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                      spaceH4,
                      Container(
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: addressController,
                                maxLength: 100,
                                onChanged: (value) {
                                  if (value == '') {
                                    cubit.errorAddress
                                        .add('Address is not null');
                                  } else {
                                    cubit.errorAddress.add('');
                                  }
                                },
                                cursorColor:
                                    AppTheme.getInstance().whiteColor(),
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isCollapsed: true,
                                  counterText: '',
                                  hintText: S.current.enter_add,
                                  hintStyle: textNormal(
                                    Colors.white.withOpacity(0.5),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: cubit.errorAddress,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<String> snapshot,
                        ) {
                          if (snapshot.data != '') {
                            return SizedBox(
                              child: Text(
                                snapshot.data ?? '',
                                style: textNormal(
                                  Colors.red,
                                  12,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH16,
                      Text(
                        'Description',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                      spaceH4,
                      Container(
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().backgroundBTSColor(),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: descriptionController,
                                maxLength: 200,
                                onChanged: (value) {
                                  if (value == '') {
                                    cubit.errorDescription
                                        .add('Description is not null');
                                  } else {
                                    cubit.errorDescription.add('');
                                  }
                                },
                                cursorColor:
                                    AppTheme.getInstance().whiteColor(),
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isCollapsed: true,
                                  counterText: '',
                                  hintText: 'Enter description',
                                  hintStyle: textNormal(
                                    Colors.white.withOpacity(0.5),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: cubit.errorDescription,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<String> snapshot,
                        ) {
                          if (snapshot.data != '') {
                            return SizedBox(
                              child: Text(
                                snapshot.data ?? '',
                                style: textNormal(
                                  Colors.red,
                                  12,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH16,
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget boxCover(BuildContext context) {
    return SizedBox(
      height: 179.h,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 145.h,
            width: double.infinity,
            child: StreamBuilder<StatusPickFile>(
              stream: cubit.selectCover,
              builder: (context, AsyncSnapshot<StatusPickFile> snapshot) {
                if (snapshot.data == StatusPickFile.START ||
                    snapshot.data == StatusPickFile.PICK_SUCCESS) {
                  return FadeInImage.assetNetwork(
                    placeholder: ImageAssets.image_loading,
                    image: cubit.coverCid,
                    placeholderErrorBuilder: (ctx, obj, st) {
                      return Container(
                        height: 145.h,
                        width: double.infinity,
                        color: borderItemColors,
                      );
                    },
                    imageErrorBuilder: (ctx, obj, st) {
                      return Container(
                        height: 145.h,
                        width: double.infinity,
                        color: borderItemColors,
                      );
                    },
                    placeholderCacheHeight: 400,
                    fit: BoxFit.fill,
                  );
                } else if (snapshot.data == StatusPickFile.PICK_ERROR) {
                  return Center(
                    child: Text(
                      S.current.maximum_size,
                      style: textNormalCustom(
                        Colors.red,
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  return Image.asset(ImageAssets.image_loading);
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 68.h,
                      width: 68.w,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: StreamBuilder<StatusPickFile>(
                        stream: cubit.selectImage,
                        builder:
                            (context, AsyncSnapshot<StatusPickFile> snapshot) {
                          if (snapshot.data == StatusPickFile.START ||
                              snapshot.data == StatusPickFile.PICK_SUCCESS) {
                            return FadeInImage.assetNetwork(
                              placeholder: ImageAssets.img_loading_transparent,
                              image: cubit.mediaFileCid,
                              placeholderErrorBuilder: (ctx, obj, st) {
                                return Container(
                                  height: 145.h,
                                  width: double.infinity,
                                  color: borderItemColors,
                                );
                              },
                              imageErrorBuilder: (ctx, obj, st) {
                                return Container(
                                  height: 145.h,
                                  width: double.infinity,
                                  color: borderItemColors,
                                );
                              },
                              placeholderCacheHeight: 400,
                              fit: BoxFit.fill,
                            );
                          } else if (snapshot.data ==
                              StatusPickFile.PICK_ERROR) {
                            return Center(
                              child: Text(
                                S.current.maximum_size,
                                style: textNormalCustom(
                                  Colors.red,
                                  10,
                                  FontWeight.w600,
                                ),
                              ),
                            );
                          } else {
                            return Image.asset(
                                ImageAssets.img_loading_transparent);
                          }
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await cubit.pickImage(isMainMedia: true);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 2.w,
                        bottom: 6.h,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: sizedSvgImage(
                          w: 28,
                          h: 28,
                          image: ImageAssets.ic_camera_svg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 12.w,
              top: 8.h,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  await cubit.pickImage();
                },
                child: sizedSvgImage(
                  w: 28,
                  h: 28,
                  image: ImageAssets.ic_camera_svg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
