import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_CKC_FILTER {
  HAVE_IMG,
  NON_IMG,
}

class CheckBoxFilterWidget extends StatefulWidget {
  const CheckBoxFilterWidget({
    Key? key,
    required this.nameCkcFilter,
    required this.typeCkc,
    required this.callBack,
    this.urlCover,
  }) : super(key: key);
  final String nameCkcFilter;
  final TYPE_CKC_FILTER typeCkc;
  final String? urlCover;
  final Function() callBack;

  @override
  _CheckBoxFilterWidgetState createState() => _CheckBoxFilterWidgetState();
}

class _CheckBoxFilterWidgetState extends State<CheckBoxFilterWidget> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.callBack();
        });
      },
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: _isSelected ? const Color(0xffE4AC1A) : Colors.transparent,
              border: _isSelected
                  ? null
                  : Border.all(
                color: const Color(0xffF2F2F2),
                width: 1.w,
              ),
            ),
            child: _isSelected
                ? const ImageIcon(
              AssetImage(ImageAssets.ic_ckc),
              color: Colors.white,
            )
                : Container(),
          ),
          spaceW8,
          buildImg(widget.typeCkc),
          Expanded(
            child: Text(
              widget.nameCkcFilter,
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

  Widget buildImg(TYPE_CKC_FILTER type) {
    if (type == TYPE_CKC_FILTER.HAVE_IMG) {
      return Row(
        children: [
          SizedBox(
            width: 4.w,
          ),
          circularImage(
            widget.urlCover ?? '',
            height: 28.h,
            width: 28.w,
          ),
          SizedBox(
            width: 8.w,
          ),
        ],
      );
    } else {
      return Container();
    }
  }


}
