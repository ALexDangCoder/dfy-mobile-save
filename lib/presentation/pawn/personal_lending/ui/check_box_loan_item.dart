import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxItemLoan extends StatelessWidget {
  const CheckBoxItemLoan({
    Key? key,
    required this.nameCkcFilter,
    required this.isSelected,
    required this.index,
    required this.bloc,
  }) : super(key: key);
  final String nameCkcFilter;
  final int index;
  final bool isSelected;
  final PersonalLendingBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.chooseFilterLoan(index: index);
      },
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: isSelected ? const Color(0xffE4AC1A) : Colors.transparent,
              border: isSelected
                  ? null
                  : Border.all(
                      color: const Color(0xffF2F2F2),
                      width: 1.w,
                    ),
            ),
            child: isSelected
                ? const ImageIcon(
                    AssetImage(ImageAssets.ic_ckc),
                    color: Colors.white,
                  )
                : Container(),
          ),
          spaceW8,
          Expanded(
            child: Text(
              nameCkcFilter,
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
