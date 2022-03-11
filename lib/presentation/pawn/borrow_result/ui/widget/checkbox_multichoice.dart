import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_CKC_FILTER {
  HAVE_IMG,
  NON_IMG,
}

class CheckBoxMultiChoice extends StatefulWidget {
  const CheckBoxMultiChoice({
    Key? key,
    required this.nameCkcFilter,
    required this.typeCkc,
    this.urlCover,
    required this.filterType,
    this.cubit,
    this.symbol,
  }) : super(key: key);
  final String nameCkcFilter;
  final TYPE_CKC_FILTER typeCkc;
  final String? urlCover;
  final String? symbol;
  final String filterType;
  final BorrowResultCubit? cubit;

  @override
  _CheckBoxMultiChoiceState createState() => _CheckBoxMultiChoiceState();
}

class _CheckBoxMultiChoiceState extends State<CheckBoxMultiChoice> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    // _isSelected = widget.cubit?.checkFilter(widget.nameCkcFilter) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {

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

  void checkKey(String type, bool isSellect) {
    // if (type == S.current.collection) {
    //   if (isSellect) {
    //     widget.cubit!.selectParamCollection(widget.nameCkcFilter);
    //   } else {
    //     widget.cubit!.moveParamCollection(widget.nameCkcFilter);
    //   }
    // } else if (type == S.current.status) {
    //   if (isSellect) {
    //     widget.cubit!.selectParamStatus(widget.nameCkcFilter);
    //   } else {
    //     widget.cubit!.moveParamStatus(widget.nameCkcFilter);
    //   }
    // } else {
    //   if (isSellect) {
    //     widget.cubit!.selectParamTypeNft(widget.nameCkcFilter);
    //   } else {
    //     widget.cubit!.moveParamTypeNft(widget.nameCkcFilter);
    //   }
    // }
  }
}
