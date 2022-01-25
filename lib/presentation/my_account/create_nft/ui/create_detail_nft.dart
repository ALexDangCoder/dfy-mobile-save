import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/call_api.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/validate_input.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/add_property_button.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/categories_dropdown_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/create_nft_progress_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/input_information_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/properties_row.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/upload_widget_create_nft.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
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
  final GlobalKey<FormGroupState> _key = GlobalKey<FormGroupState>();

  @override
  void initState() {
    widget.cubit.getListCollection();
    super.initState();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BaseBottomSheet(
        resizeBottomInset: true,
        title: S.current.create_collection,
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
                              return propertyRow(
                                property: list[index],
                                cubit: widget.cubit,
                                index: index,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                addPropertyButton(widget.cubit),
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
                          showDialog(
                            context: context,
                            builder: (context) => CreateNftUploadProgress(
                              cubit: widget.cubit,
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
}
