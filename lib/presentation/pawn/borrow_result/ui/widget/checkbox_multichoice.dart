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

class CheckBoxMultiChoice extends StatelessWidget {
  const CheckBoxMultiChoice({
    Key? key,
    required this.nameCkcFilter,
    required this.typeCkc,
    this.urlCover,
    required this.filterType,
    required this.cubit,
    this.isSelected,
  }) : super(key: key);
  final String nameCkcFilter;
  final TYPE_CKC_FILTER typeCkc;
  final String? urlCover;
  final bool? isSelected;
  final String filterType;
  final BorrowResultCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (filterType == S.current.interest_range) {
          cubit.setInterest(nameCkcFilter);
        } else if (filterType == S.current.loan_to_value) {
          cubit.setLoanToValue(nameCkcFilter);
        } else if (filterType == S.current.collateral_accepted) {
          cubit.selectCollateral(nameCkcFilter);
        } else if (filterType == S.current.loan_token) {
          cubit.selectLoanToken(nameCkcFilter);
        } else if (filterType == S.current.loan_type) {
          cubit.selectLoanType(nameCkcFilter);
        } else if (filterType == S.current.duration) {
          cubit.selectDuration(nameCkcFilter);
        } else {
          cubit.selectNetwork(nameCkcFilter);
        }
      },
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: (isSelected ?? false)
                  ? const Color(0xffE4AC1A)
                  : Colors.transparent,
              border: (isSelected ?? false)
                  ? null
                  : Border.all(
                      color: const Color(0xffF2F2F2),
                      width: 1.w,
                    ),
            ),
            child: (isSelected ?? false)
                ? const ImageIcon(
                    AssetImage(ImageAssets.ic_ckc),
                    color: Colors.white,
                  )
                : Container(),
          ),
          spaceW8,
          buildImg(typeCkc),
          Expanded(
            child: Text(
              nameCkcFilter,
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
            urlCover ?? '',
            height: 20.h,
            width: 20.w,
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
