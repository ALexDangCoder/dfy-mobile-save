import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/add_property_button.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/categories_dropdown_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/properties_row.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/upload_widget.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late TextEditingController nameCollectionController;
  late TextEditingController descriptionCollectionController;
  late TextEditingController royaltyCollectionController;

  @override
  void initState() {
    nameCollectionController = TextEditingController();
    descriptionCollectionController = TextEditingController();
    royaltyCollectionController = TextEditingController();
    widget.cubit.getListCollection();
    super.initState();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    nameCollectionController.dispose();
    descriptionCollectionController.dispose();
    royaltyCollectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BaseBottomSheet(
        resizeBottomInset: true,
        title: S.current.create_collection,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    uploadWidget(widget.cubit),
                    spaceH16,
                    CategoriesDropDown(
                      cubit: widget.cubit,
                    ),
                    fillInformationWidget(),
                    spaceH16,
                    Text(
                      'Properties (add more trait for your NFT)',
                      style: textCustom(
                        weight: FontWeight.w600,
                      ),
                    ),
                    spaceH16,
                    propertyRow(),
                    spaceH16,
                  ],
                ),
              ),
              addPropertyButton(),
              SizedBox(
                height: 28.h,
              ),
              StreamBuilder<bool>(
                stream: null,
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
                      } else {}
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fillInformationWidget() {
    return Column(
      children: [
        InputRow(
          hint: 'Name of NFT',
          leadImg: ImageAssets.ic_edit_square_svg,
          textController: nameCollectionController,
          onChange: (value) {},
        ),
        InputRow(
          hint: S.current.description,
          leadImg: ImageAssets.ic_edit_square_svg,
          textController: nameCollectionController,
          onChange: (value) {},
        ),
        InputRow(
          textController: royaltyCollectionController,
          suffixes: '%',
          onChange: (value) {},
          leadImg: ImageAssets.ic_round_percent_svg,
          hint: S.current.royalties,
          img2: ImageAssets.ic_round_i,
          inputType: TextInputType.number,
          onImageTap: () {},
        ),
      ],
    );
  }
}
