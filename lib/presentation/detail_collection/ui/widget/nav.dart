
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavCollection extends StatelessWidget {
  final String items;
  final String owners;
  final String volumeTraded;

  const NavCollection({
    Key? key,
    required this.items,
    required this.owners,
    required this.volumeTraded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  items,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w600,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              spaceW4,
              Expanded(
                child: Text(
                  owners.toLowerCase(),
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w600,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              spaceW4,
              Expanded(
                child: Text(
                  volumeTraded,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w600,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          spaceH2,
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.items,
                  style: textNormalCustom(
                    null,
                    12,
                    null,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              spaceW4,
              Expanded(
                child: Text(
                  S.current.owners,
                  style: textNormalCustom(
                    null,
                    12,
                    null,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              spaceW4,
              Expanded(
                child: Text(
                  S.current.volume_traded,
                  style: textNormalCustom(
                    null,
                    12,
                    null,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
