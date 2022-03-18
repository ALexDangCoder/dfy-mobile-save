import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/validate_input.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/style_utils.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';

Widget inputInformationWidget({
  required CreateNftCubit cubit,
  required Function onChange,
  required BuildContext context,
}) {
  return Column(
    children: [
      spaceH16,
      TextFieldValidator(
        hint: S.current.name_of_nft,
        prefixIcon: sizedSvgImage(
          w: 20,
          h: 20,
          image: ImageAssets.ic_edit_square_svg,
        ),
        onChange: (vl) {
          onChange();
        },
        validator: (vl) {
          return cubit.validateCollectionName(vl ?? '');
        },
      ),
      spaceH16,
      TextFieldValidator(
        hint: S.current.description,
        prefixIcon: sizedSvgImage(
          w: 20,
          h: 20,
          image: ImageAssets.ic_edit_square_svg,
        ),
        onChange: (vl) {
          onChange();
        },
        validator: (vl) {
          return cubit.validateDescription(vl ?? '');
        },
      ),
      spaceH16,
    ],
  );
}
