import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/column_button/buil_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextType {
  RICH,
  NORM,
}

class CardNFT extends StatelessWidget {
  const CardNFT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => DraggableScrollableSheet(
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 9.h,
                        bottom: 23.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().divideColor(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                      ),
                      width: 109.w,
                      height: 5.h,
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(ImageAssets.card_defi),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.current.name_of_nft,
                                    style: textNormal(
                                      AppTheme.getInstance().textThemeColor(),
                                      24.sp,
                                    ).copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                _buildRow(
                                  title: '#3333535',
                                  detail: '1 trên 10',
                                  type: TextType.NORM,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildColumnButton(
                                      path: ImageAssets.receive,
                                    ),
                                    SizedBox(
                                      width: 46.w,
                                    ),
                                    buildColumnButton(
                                      path: ImageAssets.send,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                _buildRow(
                                  title: S.current.description,
                                  detail:
                                      'In fringilla orci facilisis in sed eget '
                                      'nec sollicitudin nullam',
                                  type: TextType.NORM,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                _buildRow(
                                  title: 'NFT standard',
                                  detail: 'ERC-1155',
                                  type: TextType.NORM,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                _buildRow(
                                  title: 'Link',
                                  detail: 'https://opensea.io/0c...30/7576',
                                  type: TextType.RICH,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                _buildRow(
                                  title: 'Contract',
                                  detail: '0xd07dc4262...261d2461d2430',
                                  type: TextType.RICH,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                _buildRow(
                                  title: 'Blockchain',
                                  detail: 'Binance smart chain',
                                  type: TextType.NORM,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            height: 102.h,
            width: 88.w,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/demo.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                10.sp,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }

  Row _buildRow({
    required String title,
    required String detail,
    required TextType type,
  }) =>
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SizedBox(
              width: 126.w,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          if (type == TextType.NORM)
            SizedBox(
              width: 225.w,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  detail,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ),
            )
          else
            SizedBox(
              width: 225.w,
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: detail,
                      style: textNormal(const Color(0xff46BCFF), 16.sp)
                        ..copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                    ),
                  ],
                ),
              ),
            )
        ],
      );
  Card cardTransition(String label)=> Card(
    child: Text(label),
  );
}
