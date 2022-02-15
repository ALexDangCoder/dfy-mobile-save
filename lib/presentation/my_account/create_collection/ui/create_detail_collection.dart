import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/ipfs_gen_url.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/validate_input.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/categories_cool.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/upload_progess_widget.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/upload_widget_create_cl.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: BaseDesignScreen(
        resizeBottomInset: true,
        title: S.current.create_collection,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UploadCreateCollection(cubit: widget.bloc),
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
          onImageTap: () {
            showDialog(
              context: context,
              builder: (_) => InfoPopup(
                name: S.current.custom_url,
                content: S.current.custom_url_info,
              ),
            );
          },
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
          onImageTap: () {
            showDialog(
              context: context,
              builder: (_) => InfoPopup(
                name: S.current.royalties,
                content: S.current.royalties_info,
              ),
            );
          },
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
}
