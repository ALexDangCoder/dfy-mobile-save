import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
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
    nameController.text = widget.userProfile.pawnshop?.name ?? '';
    cubit.coverCid = widget.userProfile.pawnshop?.cover ?? '';
    cubit.mediaFileCid = widget.userProfile.pawnshop?.avatar ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      isImage: false,
      text: S.current.save,
      title: 'Edit pawnshop info',
      child: SingleChildScrollView(
        child: Column(
          children: [
            boxCover(),
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
                          flex: 5,
                          child: TextFormField(
                            controller: nameController,
                            maxLength: 100,
                            onChanged: (value) {

                            },
                            cursorColor: AppTheme.getInstance().whiteColor(),
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
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if(snapshot.data != ''){
                        return SizedBox(
                          child: Text(
                            snapshot.data ?? '',
                            style: textNormal(
                              Colors.red,
                              12,
                            ),
                          ),
                        );
                      }
                      else {
                        return const SizedBox();
                      }
                    },
                  ),
                  spaceH16,
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
                          flex: 5,
                          child: TextFormField(
                            controller: nameController,
                            maxLength: 100,
                            onChanged: (value) {

                            },
                            cursorColor: AppTheme.getInstance().whiteColor(),
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
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if(snapshot.data != ''){
                        return SizedBox(
                          child: Text(
                            snapshot.data ?? '',
                            style: textNormal(
                              Colors.red,
                              12,
                            ),
                          ),
                        );
                      }
                      else {
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
  }

  Widget boxCover() {
    return SizedBox(
      height: 179.h,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 145.h,
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: '',
              image: widget.userProfile.pawnshop?.cover ?? '',
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
              child: Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 68.h,
                  width: 68.w,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: '',
                    image: widget.userProfile.pawnshop?.avatar ?? '',
                    placeholderErrorBuilder: (ctx, obj, st) {
                      return const SizedBox();
                    },
                    imageErrorBuilder: (ctx, obj, st) {
                      return Container(
                        height: 145.h,
                        width: double.infinity,
                        color: borderItemColors,
                      );
                    },
                    placeholderCacheHeight: 400,
                    fit: BoxFit.cover,
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
