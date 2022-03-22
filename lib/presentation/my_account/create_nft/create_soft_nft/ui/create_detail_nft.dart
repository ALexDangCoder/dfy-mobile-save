import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/call_api.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/pick_file_extension.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/properties_control.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/upload_ipfs_extension.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/validate_input.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/add_property_button.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/categories_dropdown_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/create_nft_progress_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/input_information_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/upload_widget_create_nft.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/widget/validator_property_row.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CreateDetailNFT extends StatefulWidget {
  final CreateNftCubit cubit;
  final int nftType;

  const CreateDetailNFT({Key? key, required this.cubit, required this.nftType})
      : super(key: key);

  @override
  State<CreateDetailNFT> createState() => _CreateDetailNFTState();
}

class _CreateDetailNFTState extends State<CreateDetailNFT> {
  final GlobalKey<FormGroupState> _key = GlobalKey<FormGroupState>();
  late final TextEditingController textRoyalties;

  @override
  void initState() {
    super.initState();
    widget.cubit.getListCollection();
    widget.cubit.getBalanceToken(
      ofAddress: PrefsService.getCurrentBEWallet(),
      tokenAddress: Get.find<AppConstants>().contract_defy,
    );
    textRoyalties = TextEditingController();
    widget.cubit.textRoyalties.listen((value) {
      final List<String> valueRoyalties = value.split('.');
      textRoyalties.text = valueRoyalties.first;
    });
    textRoyalties.addListener(() {
      widget.cubit.validateRoyalty(textRoyalties.text);
      widget.cubit.validateInput(
        value: _key.currentState?.checkValidator() ?? false,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BaseDesignScreen(
        resizeBottomInset: true,
        text: ImageAssets.ic_close,
        isImage: true,
        onRightClick: () {
          Navigator.of(context)
            ..pop()
            ..pop();
        },
        title: S.current.create_nft,
        child: FormGroup(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      uploadWidgetCreateNft(widget.cubit),
                      spaceH16,
                      CategoriesDropDown(
                        cubit: widget.cubit,
                      ),
                      inputInformationWidget(
                        cubit: widget.cubit,
                        onChange: () {
                          widget.cubit.validateInput(
                            value: _key.currentState?.checkValidator() ?? false,
                          );
                        },
                        context: context,
                      ),
                      TextFieldValidator(
                        controller: textRoyalties,
                        hint: S.current.royalties,
                        textInputType: TextInputType.number,
                        maxInputChar: 2,
                        prefixIcon: sizedSvgImage(
                          w: 20,
                          h: 20,
                          image: ImageAssets.ic_round_percent_svg,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => InfoPopup(
                                name: S.current.royalties,
                                content: S.current.collect_a_fee_mess,
                              ),
                            );
                          },
                          child: sizedSvgImage(
                            w: 20,
                            h: 20,
                            image: ImageAssets.ic_round_i,
                          ),
                        ),
                      ),
                      spaceH4,
                      StreamBuilder<String>(
                        stream: widget.cubit.validateRoyalties,
                        builder: (context, snapshot) {
                          return snapshot.data?.isNotEmpty ?? false
                              ? Text(
                                  snapshot.data ?? '',
                                  style: textNormalCustom(
                                    AppTheme.getInstance().redColor(),
                                    14,
                                    null,
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      spaceH16,
                      Text(
                        S.current.add_more_trait_to_properties,
                        style: textCustom(
                          weight: FontWeight.w600,
                        ),
                      ),
                      spaceH16,
                      StreamBuilder<List<Map<String, String>>>(
                        stream: widget.cubit.listPropertySubject,
                        builder: (context, snapshot) {
                          final list = snapshot.data ?? [];
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return PropertyRowWidget(
                                property: list[index],
                                cubit: widget.cubit,
                                index: index,
                                onTap: () {
                                  widget.cubit.removeProperty(index);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                  stream: widget.cubit.showAddPropertySubject,
                  initialData: true,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? true,
                      child: addPropertyButton(widget.cubit),
                    );
                  },
                ),
                SizedBox(
                  height: 28.h,
                ),
                StreamBuilder<bool>(
                  stream: widget.cubit.createNftButtonSubject,
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
                          if (widget.cubit.balanceCheck >= 10) {
                            widget.cubit.uploadFileToIFPS(context);
                            widget.cubit.controlAudio(needStop: true);
                            showDialog(
                              context: context,
                              builder: (context) => CreateNftUploadProgress(
                                cubit: widget.cubit,
                              ),
                            );
                          } else {
                            showErrDialog(
                              content: S.current.you_must_have_ten,
                              title: S.current.warning,
                              context: context,
                            );
                          }
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
}
