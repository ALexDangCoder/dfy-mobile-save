import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/categories_cool.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/upload_progess_widget.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CreateDetailCollection extends StatefulWidget {
  final CreateCollectionCubit bloc;
  final int collectionStandard;
  final int collectionType;

  const CreateDetailCollection({
    Key? key,
    required this.bloc,
    required this.collectionStandard,
    required this.collectionType,
  }) : super(key: key);

  @override
  State<CreateDetailCollection> createState() => _CreateDetailCollectionState();
}

class _CreateDetailCollectionState extends State<CreateDetailCollection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController customURLController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController royaltyController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.getListCategory();
    widget.bloc.collectionStandard = widget.collectionStandard;
    widget.bloc.collectionType = widget.collectionType;
    trustWalletChannel.setMethodCallHandler(
      widget.bloc.nativeMethodCallBackTrustWallet,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    customURLController.dispose();
    descriptionController.dispose();
    royaltyController.dispose();
    facebookController.dispose();
    twitterController.dispose();
    instagramController.dispose();
    telegramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BaseBottomSheet(
        resizeBottomInset: true,
        title: S.current.create_collection,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                uploadWidget(),
                SizedBox(height: 32.h),
                informationWidget(),
                SizedBox(height: 32.h),
                socialLinkWidget(),
                SizedBox(height: 32.h),
                StreamBuilder<bool>(
                  stream: widget.bloc.enableCreateStream,
                  initialData: false,
                  builder: (context, snapshot) {
                    final statusButton = snapshot.data ?? false;
                    return ButtonLuxury(
                      marginHorizontal: 16.w,
                      title: S.current.create,
                      isEnable: statusButton,
                      buttonHeight: 64,
                      fontSize: 20,
                      onTap: () {
                        if (statusButton) {
                          widget.bloc.createSocialMap();
                          widget.bloc.getListWallets();
                          showDialog(
                            context: context,
                            builder: (context) => UploadProgress(
                              bloc: widget.bloc,
                            ),
                          );
                        } else {}
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceH22,
        Text(
          S.current.upload_cover_photo,
          style: uploadText,
        ),
        spaceH22,
        StreamBuilder<File>(
          stream: widget.bloc.coverPhotoSubject,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final imageFile = snapshot.data!;
              return Container(
                clipBehavior: Clip.hardEdge,
                height: 133.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: GestureDetector(
                        onTap: () async {
                          await pickImage(
                            imageType: 'cover_photo',
                            tittle: S.current.cover_photo,
                          );
                        },
                        child: sizedSvgImage(
                          w: 28,
                          h: 28,
                          image: ImageAssets.ic_camera_svg,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  await pickImage(
                    imageType: 'cover_photo',
                    tittle: S.current.cover_photo,
                  );
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  color: AppTheme.getInstance().whiteColor().withOpacity(0.5),
                  strokeWidth: 1.5,
                  dashPattern: const [5],
                  child: SizedBox(
                    height: 133.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sizedSvgImage(
                            w: 44,
                            h: 44,
                            image: ImageAssets.icon_add_image_svg,
                          ),
                          spaceH16,
                          Text(
                            S.current.format_image,
                            style: normalText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        StreamBuilder<String>(
          stream: widget.bloc.coverPhotoMessSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        SizedBox(height: 32.h),
        Text(
          S.current.upload_avatar,
          style: uploadText,
        ),
        spaceH22,
        StreamBuilder<File>(
          stream: widget.bloc.avatarSubject,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final imageFile = snapshot.data!;
              return Center(
                child: SizedBox(
                  height: 100.h,
                  width: 100.h,
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 100.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await pickImage(
                              imageType: 'avatar',
                              tittle: S.current.upload_avatar,
                            );
                          },
                          child: sizedSvgImage(
                            w: 28,
                            h: 28,
                            image: ImageAssets.ic_camera_svg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await pickImage(
                        imageType: 'avatar',
                        tittle: S.current.upload_avatar,
                      );
                    },
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      color:
                          AppTheme.getInstance().whiteColor().withOpacity(0.5),
                      strokeWidth: 1.5,
                      dashPattern: const [5],
                      child: SizedBox(
                        height: 100.h,
                        child: Center(
                          child: sizedSvgImage(
                            w: 44,
                            h: 44,
                            image: ImageAssets.icon_add_image_svg,
                          ),
                        ),
                      ),
                    ),
                  ),
                  spaceH12,
                  Center(
                    child: Text(
                      S.current.format_image,
                      style: normalText,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        StreamBuilder<String>(
          stream: widget.bloc.avatarMessSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        SizedBox(height: 32.h),
        Text(
          S.current.upload_featured_photo,
          style: uploadText,
        ),
        spaceH22,
        GestureDetector(
          onTap: () async {
            await pickImage(
              imageType: 'feature_photo',
              tittle: S.current.upload_featured_photo,
            );
          },
          child: StreamBuilder<File>(
            stream: widget.bloc.featurePhotoSubject,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                final imageFile = snapshot.data!;
                return Container(
                  clipBehavior: Clip.hardEdge,
                  height: 172.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              } else {
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  color: AppTheme.getInstance().whiteColor().withOpacity(0.5),
                  strokeWidth: 1.5,
                  dashPattern: const [5],
                  child: SizedBox(
                    height: 172.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sizedSvgImage(
                            w: 44,
                            h: 44,
                            image: ImageAssets.icon_add_image_svg,
                          ),
                          spaceH16,
                          Text(
                            S.current.format_image,
                            style: normalText,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        StreamBuilder<String>(
          stream: widget.bloc.featurePhotoMessSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
      ],
    );
  }

  Widget informationWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.information.toUpperCase(),
          style: uploadText,
        ),
        InputRow(
          textController: nameController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'name',
              hintText: S.current.collection_name,
              value: value,
            );
          },
          leadImg: ImageAssets.ic_folder_svg,
          hint: S.current.collection_name,
        ),
        StreamBuilder<String>(
          stream: widget.bloc.nameCollectionSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: customURLController,
          onChange: (value) {
            widget.bloc.validateCustomURL(value);
          },
          leadImg: ImageAssets.ic_link_svg,
          hint: 'app.defiforyou/uk/marketplace/....',
          img2: ImageAssets.ic_round_i,
          onImageTap: () {},
        ),
        StreamBuilder<String>(
          stream: widget.bloc.customURLSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: descriptionController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'des',
              hintText: S.current.description,
              value: value,
            );
          },
          leadImg: ImageAssets.ic_edit_square_svg,
          hint: S.current.description,
        ),
        StreamBuilder<String>(
          stream: widget.bloc.descriptionSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        spaceH16,
        CategoriesCool(
          bloc: widget.bloc,
        ),
        StreamBuilder<String>(
          stream: widget.bloc.categoriesSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: royaltyController,
          suffixes: '%',
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'royalty',
              hintText: S.current.royalties,
              value: value,
            );
          },
          leadImg: ImageAssets.ic_round_percent_svg,
          hint: S.current.royalties,
          img2: ImageAssets.ic_round_i,
          inputType: TextInputType.number,
          onImageTap: () {},
        ),
        StreamBuilder<String>(
          stream: widget.bloc.royaltySubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
      ],
    );
  }

  Widget socialLinkWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.social_links.toUpperCase(),
          style: uploadText,
        ),
        InputRow(
          textController: facebookController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'facebook',
              hintText: 'Facebook',
              value: value,
            );
          },
          leadImg: ImageAssets.ic_facebook_svg,
          hint: 'Facebook',
        ),
        StreamBuilder<String>(
          stream: widget.bloc.facebookSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: twitterController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'twitter',
              hintText: 'Twitter',
              value: value,
            );
          },
          leadImg: ImageAssets.ic_twitter_svg,
          hint: 'Twitter',
        ),
        StreamBuilder<String>(
          stream: widget.bloc.twitterSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: instagramController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'instagram',
              hintText: 'Instagram',
              value: value,
            );
          },
          leadImg: ImageAssets.ic_instagram_svg,
          hint: 'Instagram',
        ),
        StreamBuilder<String>(
          stream: widget.bloc.instagramSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        InputRow(
          textController: telegramController,
          onChange: (value) {
            widget.bloc.validateCase(
              inputCase: 'telegram',
              hintText: 'Telegram',
              value: value,
            );
          },
          leadImg: ImageAssets.ic_telegram_svg,
          hint: 'Telegram',
        ),
        StreamBuilder<String>(
          stream: widget.bloc.telegramSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
      ],
    );
  }

  Future<void> pickImage({
    required String imageType,
    required String tittle,
  }) async {
    final filePath = await pickImageFunc(imageType: imageType, tittle: tittle);
      if (filePath.isNotEmpty) {
        final imageTemp = File(filePath);
        final imageSizeInMB =
            imageTemp.readAsBytesSync().lengthInBytes / 1048576;
        widget.bloc.loadImage(
          type: imageType,
          imageSizeInMB: imageSizeInMB,
          imagePath: imageTemp.path,
          image: imageTemp,
        );
      }
    }
}
