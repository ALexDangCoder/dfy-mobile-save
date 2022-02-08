import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/bloc/bloc_book_evalution.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/widget/item_pawn_shop_star.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/step_appbar.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookEvaluation extends StatefulWidget {
  final int cityId;

  const BookEvaluation({
    Key? key,
    required this.cityId,
  }) : super(key: key);

  @override
  _BookEvaluationState createState() => _BookEvaluationState();
}

class _BookEvaluationState extends State<BookEvaluation> {
  final Completer<GoogleMapController> _controller = Completer();
  late final BlocBookEvaluation _bloc;
  static const CameraPosition _kGooglePlex = CameraPosition(
    //51.50748834854622, -0.12769100104405115
    target: LatLng(51.53523402237351, -0.12769100104405115),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _bloc = BlocBookEvaluation();
    _bloc.getListPawnShopStar(cityId: widget.cityId);
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
          const StepAppBar(),
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
                      child: GoogleMap(
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ),
                  spaceH32,
                  StreamBuilder<List<EvaluatorsCityModel>>(
                    stream: _bloc.list,
                    builder: (context, snapshot) {
                      final list = snapshot.data ?? [];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${list.length} ${S.current.evaluators_near_you}',
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateBookEvaluation(
                                      idEvaluation: list[index].id ?? '',
                                      type: TypeEvaluation.NEW_CREATE,
                                      typeNFT: 'diamond', //todo type
                                    ),
                                  ),
                                );
                              },
                              child: ItemPawnShopStar(
                                starNumber: '${list[index].starCount}',
                                namePawnShop: list[index].name ?? '',
                                avatarPawnShopUrl:
                                    '${ApiConstants.BASE_URL_IMAGE}${list[index].avatarCid}',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
