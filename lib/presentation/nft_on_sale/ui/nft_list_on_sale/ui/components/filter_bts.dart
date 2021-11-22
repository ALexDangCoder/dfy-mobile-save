import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/ckc_filter.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBts extends StatefulWidget {
  const FilterBts({Key? key}) : super(key: key);

  @override
  _FilterBtsState createState() => _FilterBtsState();
}

class _FilterBtsState extends State<FilterBts> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        height: 497.h,
        width: 375.w,
        padding: EdgeInsets.only(
          top: 9.h,
          left: 16.w,
          // right: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 109.w,
                height: 5.h,
                decoration: const BoxDecoration(
                  color: Color(0xff585782),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ),
            spaceH20,
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txtTitleFilter(title: S.current.nft_type),
                          spaceH12,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.hard_NFT,
                            typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          ),
                          spaceH16,
                          txtTitleFilter(title: S.current.status),
                          spaceH12,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.on_sale,
                            typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          ),
                          spaceH16,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.on_auction,
                            typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          ),
                          spaceH16,
                          txtTitleFilter(title: S.current.collection),
                          spaceH10,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.animals,
                            typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
                          ),
                          spaceH16,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.painting,
                            typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
                          ),
                          spaceH16,
                          CheckBoxFilter(
                            nameCkcFilter: S.current.art_work,
                            typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckBoxFilter(
                            nameCkcFilter: S.current.soft_nft,
                            typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            const ButtonGold(
              title: 'Apply',
              isEnable: true,
            )
          ],
        ),
      ),
    );
  }

  Text txtTitleFilter({required String title}) {
    return Text(
      title,
      style: textNormalCustom(
        Colors.white,
        20,
        FontWeight.w600,
      ),
    );
  }

  Row filterNft() {
    return Row(
      children: [
        CheckBoxFilter(
          nameCkcFilter: S.current.hard_NFT,
          typeCkc: TYPE_CKC_FILTER.NON_IMG,
        ),
        SizedBox(
          width: 55.w,
        ),
        CheckBoxFilter(
          nameCkcFilter: S.current.soft_nft,
          typeCkc: TYPE_CKC_FILTER.NON_IMG,
        ),
      ],
    );
  }

  Column filterStatus() {
    return Column(
      children: [
        Row(
          children: [
            CheckBoxFilter(
              nameCkcFilter: S.current.on_sale,
              typeCkc: TYPE_CKC_FILTER.NON_IMG,
            ),
            SizedBox(
              width: 55.w,
            ),
            CheckBoxFilter(
              nameCkcFilter: S.current.on_pawn,
              typeCkc: TYPE_CKC_FILTER.NON_IMG,
            ),
          ],
        ),
        spaceH16,
        Row(
          children: [
            const CheckBoxFilter(
              nameCkcFilter: 'On sale',
              typeCkc: TYPE_CKC_FILTER.NON_IMG,
            ),
            SizedBox(
              width: 55.w,
            ),
            const CheckBoxFilter(
              nameCkcFilter: 'On pawn',
              typeCkc: TYPE_CKC_FILTER.NON_IMG,
            ),
          ],
        ),
      ],
    );
  }
}
