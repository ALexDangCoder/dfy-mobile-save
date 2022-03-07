import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckboxItemTab extends StatefulWidget {
  const CheckboxItemTab({
    Key? key,
    required this.nameCheckbox,
    required this.isSelected,
  }) : super(key: key);
  final String nameCheckbox;
  final bool isSelected;

  @override
  _CheckboxItemState createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItemTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
