import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckboxItem extends StatefulWidget {
  const CheckboxItem({
    Key? key,
    required this.nameCheckbox,
    required this.cubit,
    required this.isSelected,
    required this.typeFiler,
  }) : super(key: key);
  final String nameCheckbox;
  final HardNftMintRequestCubit cubit;
  final bool isSelected;
  final String typeFiler;

  @override
  _CheckboxItemState createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.typeFiler == S.current.asset_type_filter) {
            widget.cubit.setAsset(widget.nameCheckbox);
          } else {
            widget.cubit.setStatus(widget.nameCheckbox);
          }
        });
      },
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: widget.isSelected
                  ? const Color(0xffE4AC1A)
                  : Colors.transparent,
              border: widget.isSelected
                  ? null
                  : Border.all(
                      color: const Color(0xffF2F2F2),
                      width: 1.w,
                    ),
            ),
            child: widget.isSelected
                ? const ImageIcon(
                    AssetImage(ImageAssets.ic_ckc),
                    color: Colors.white,
                  )
                : Container(),
          ),
          spaceW8,
          Expanded(
            child: Text(
              widget.nameCheckbox,
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
