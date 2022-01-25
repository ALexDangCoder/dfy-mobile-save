import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/bloc/bloc_list_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/item_pawn_shop.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/step_appbar.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListBookEvaluation extends StatefulWidget {
  const ListBookEvaluation({Key? key}) : super(key: key);

  @override
  _ListBookEvaluationState createState() => _ListBookEvaluationState();
}

class _ListBookEvaluationState extends State<ListBookEvaluation> {
  late final BlocListBookEvaluation _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocListBookEvaluation();
    _bloc.getListPawnShop();
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
      bottomBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookEvaluation(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            bottom: 38.h,
          ),
          color: AppTheme.getInstance().bgBtsColor(),
          child: ButtonGold(
            isEnable: true,
            title: S.current.book_evaluation,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spaceH24,
            const StepAppBar(),
            spaceH32,
            StreamBuilder<List<PawnShopModel>>(
              stream: _bloc.listPawnSHop,
              builder: (context, snapshot) {
                final _list = snapshot.data ?? [];
                if (_list.isEmpty) {
                  return Column(
                    children: [
                      Image.asset(ImageAssets.img_search_empty),
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            S.current.no_meeting_with_evaluator,
                            style: textNormalCustom(
                              AppTheme.getInstance().grayTextColor(),
                              20,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _list.length,
                        padding: EdgeInsets.only(
                          bottom: 24.h,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            //todo add event
                          },
                          child: ItemPawnShop(
                            statusPawnShop: S.current.your_appointment_request,
                            namePawnShop: _list[index].namePawnShop ?? '',
                            isViewReason: true,
                            avatarPawnShopUrl: _list[index].avatar ?? '',
                            isDeletePawnShop: true,
                            datePawnShop: _list[index].date ?? '',
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
