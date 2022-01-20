import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc_book_evaluation_request/ui/widget/dialog_cancel.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc_book_evaluation_request/ui/widget/item_pawn_shop.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc_book_evaluation_request/ui/widget/item_pawn_shop_star.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookEvaluationRequest extends StatefulWidget {
  const BookEvaluationRequest({Key? key}) : super(key: key);

  @override
  _BookEvaluationRequestState createState() => _BookEvaluationRequestState();
}

class _BookEvaluationRequestState extends State<BookEvaluationRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {
        //todo add event
      },
      title: S.current.book_evaluation_request,
      bottomBar: Container(
        padding: EdgeInsets.only(
          bottom: 38.h,
        ),
        color: AppTheme.getInstance().bgBtsColor(),
        child: ButtonGold(
          isEnable: true,
          title: S.current.book_evaluation,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spaceH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SuccessCkcCreateNft(),
                dividerSuccessCreateNFT,
                CircleStepCreateNft(
                    circleStatus: CircleStatus.IS_CREATING, stepCreate: '2'),
                dividerCreateNFT,
                CircleStepCreateNft(
                    circleStatus: CircleStatus.IS_NOT_CREATE, stepCreate: '3'),
                dividerCreateNFT,
                CircleStepCreateNft(
                    circleStatus: CircleStatus.IS_NOT_CREATE, stepCreate: '4'),
              ],
            ),
            spaceH32,
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  S.current.to_mint_hard_nft_you,
                  style: textNormalCustom(
                    AppTheme.getInstance().grayTextColor(),
                    14,
                    null,
                  ),
                ),
              ),
            ),
            spaceH32,
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: 10,
            //   // shrinkWrap: true,
            //   padding: EdgeInsets.only(
            //     bottom: 24.h,
            //   ),
            //   itemBuilder: (context, index) => GestureDetector(
            //     onTap: () {
            //       //todo add event
            //       Navigator.of(context).push(
            //         HeroDialogRoute(
            //           builder: (context) {
            //             return DialogCancel();
            //           },
            //           isNonBackground: false,
            //         ),
            //       );
            //     },
            //     child: ItemPawnSHop(
            //       statusPawnShop: S.current.your_appointment_request,
            //       namePawnShop: 'Doanh 88',
            //       isViewReason: true,
            //       avatarPawnShopUrl:
            //           'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
            //       isDeletePawnShop: true,
            //       datePawnShop: '09:15 - 14/12/2021',
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '4 ${S.current.evaluators_near_you}',
                  style: textNormalCustom(
                    AppTheme.getInstance().getPurpleColor(),
                    14,
                    null,
                  ),
                ),
              ),
            ),
            ItemPawnShopStar(
              starNumber: '5.0',
              namePawnShop: 'Tima - Online Pawnshop',
              avatarPawnShopUrl:
                  'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
