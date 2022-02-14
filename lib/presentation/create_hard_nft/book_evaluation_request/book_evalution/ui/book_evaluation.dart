import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/bloc/bloc_book_evalution.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/widget/item_list_map.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/widget/item_pawn_shop_star.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/step_appbar.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookEvaluation extends StatefulWidget {
  final List<AppointmentModel> appointmentList;
  final bool isSuccess;
  final String assetId;

  const BookEvaluation({
    Key? key,
    required this.appointmentList,
    required this.isSuccess,
    required this.assetId,
  }) : super(key: key);

  @override
  _BookEvaluationState createState() => _BookEvaluationState();
}

class _BookEvaluationState extends State<BookEvaluation> {
  late final BlocBookEvaluation bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocBookEvaluation();
    bloc.assetId=widget.assetId;
    bloc.getDetailAssetHardNFT(assetId: widget.assetId);
    bloc.appointmentList = widget.appointmentList;
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
      child: Column(
        children: [
          spaceH24,
          StepAppBar(
            assetId: widget.assetId,
            isSuccess: widget.isSuccess,
          ),
          spaceH16,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spaceH16,
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
                  StreamBuilder<List<EvaluatorsCityModel>>(
                    stream: bloc.list,
                    builder: (context, snapshot) {
                      final list = snapshot.data ?? [];
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.r,
                                  ),
                                ),
                              ),
                              height: 193.h,
                              width: 343.w,
                              child: ItemListMap(
                                bloc: bloc,
                                list: list,
                              ),
                            ),
                          ),
                          spaceH32,
                          Container(
                            padding: EdgeInsets.all(16.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${list.length} '
                                '${S.current.evaluators_near_you}',
                                style: textNormalCustom(
                                  AppTheme.getInstance().getPurpleColor(),
                                  14,
                                  null,
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                bloc.checkTypeCreate(
                                  list[index].id ?? '',
                                );
                                if (bloc.type == TypeEvaluation.CREATE) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreateBookEvaluation(
                                        date: bloc.getDate(
                                          list[index].id ?? '',
                                        ),
                                        idEvaluation: list[index].id ?? '',
                                        type: TypeEvaluation.CREATE,
                                        assetId: bloc.assetId ?? '',
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreateBookEvaluation(
                                        assetId: bloc.assetId ?? '',
                                        idEvaluation: list[index].id ?? '',
                                        type: TypeEvaluation.NEW_CREATE,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: ItemPawnShopStar(
                                starNumber: '${list[index].starCount}',
                                namePawnShop: list[index].name ?? '',
                                avatarPawnShopUrl:
                                    '${ApiConstants.BASE_URL_IMAGE}'
                                    '${list[index].avatarCid}',
                                function: () {},
                              ),
                            ),
                            itemCount: list.length,
                            shrinkWrap: true,
                          ),
                        ],
                      );
                    },
                  ),
                  spaceH32,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
