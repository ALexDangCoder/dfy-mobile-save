import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../item_repayment.dart';

class RepaymentHistory extends StatefulWidget {
  const RepaymentHistory({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ContractDetailBloc bloc;

  @override
  _RepaymentHistoryState createState() => _RepaymentHistoryState();
}

class _RepaymentHistoryState extends State<RepaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          spaceH20,
          SizedBox(
            height: 121.h,
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                width: 151.w,
                height: 121.h,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: 12.w,
                  bottom: 15.h,
                ),
                margin: EdgeInsets.only(
                  right: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.r),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.w,
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageAssets.imgMoneyPawn,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total loan',
                      style: textNormalCustom(
                        null,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$100,009,990.99',
                      maxLines: 1,
                      style: textNormalCustom(
                        null,
                        18,
                        FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          spaceH32,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => ItemRepayment(),
          ),
          spaceH152,
        ],
      ),
    );
  }
}
