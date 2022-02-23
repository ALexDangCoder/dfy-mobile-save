import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/bloc/bloc_list_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/item_pawn_shop.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/step_appbar.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PageRouterHardNFT { CREATE_HARD_NFT, LIST_HARD }

class ListBookEvaluation extends StatefulWidget {
  final String assetId;
  final PageRouterHardNFT pageRouter;

  const ListBookEvaluation({
    Key? key,
    required this.assetId,
    this.pageRouter = PageRouterHardNFT.CREATE_HARD_NFT,
  }) : super(key: key);

  @override
  _ListBookEvaluationState createState() => _ListBookEvaluationState();
}

class _ListBookEvaluationState extends State<ListBookEvaluation> {
  late final BlocListBookEvaluation _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocListBookEvaluation();
    _bloc.assetId = widget.assetId;
    _bloc.getListPawnShop(assetId: widget.assetId);
    _bloc.reloadAPI();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.closeReload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BaseDesignScreen(
            isCustomLeftClick: true,
            onLeftClick: () {
              //todo
              Navigator.pop(context);
            },
            isImage: true,
            text: ImageAssets.ic_close,
            onRightClick: () {
              if (widget.pageRouter == PageRouterHardNFT.CREATE_HARD_NFT) {
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == AppRouter.create_nft,
                );
              } else {
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == AppRouter.hard_nft_mint,
                );
              }
            },
            title: S.current.book_evaluation_request,
            child: RefreshIndicator(
              onRefresh: () async {
                await _bloc.getListPawnShop(
                  assetId: _bloc.assetId ?? '',
                );
              },
              child: Column(
                children: [
                  spaceH24,
                  StreamBuilder<bool>(
                    stream: _bloc.isSuccess,
                    builder: (context, snapshot) => StepAppBar(
                      assetId: widget.assetId,
                      isSuccess: snapshot.data ?? false,
                    ),
                  ),
                  spaceH16,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          spaceH16,
                          StreamBuilder<List<AppointmentModel>>(
                            stream: _bloc.listPawnShop,
                            builder: (context, snapshot) {
                              final _list = snapshot.data ?? [];
                              if (snapshot.hasData) {
                                if (snapshot.data?.isNotEmpty ?? false) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: Text(
                                            S.current.to_mint_hard_nft_you,
                                            style: textNormalCustom(
                                              AppTheme.getInstance()
                                                  .grayTextColor(),
                                              14,
                                              null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      spaceH32,
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _list.length,
                                        padding: EdgeInsets.only(
                                          bottom: 24.h,
                                        ),
                                        itemBuilder: (context, index) {
                                          _bloc.getIdEva(_list[index]);
                                          return ItemPawnShop(
                                            bloc: _bloc,
                                            appointment: _list[index],
                                            isLoading: _bloc.checkIsLoading(
                                              _list[index].status ?? 0,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 120,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Image.asset(ImageAssets.img_search_empty),
                                      SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: Text(
                                            S.current.no_meeting_with_evaluator,
                                            style: textNormalCustom(
                                              AppTheme.getInstance()
                                                  .grayTextColor(),
                                              20,
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (_bloc.checkStatusList()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookEvaluation(
                        isSuccess: _bloc.isSuccess.value,
                        appointmentList: _bloc.appointmentList,
                        assetId: _bloc.assetId ?? '',
                      ),
                      settings: const RouteSettings(
                        name: AppRouter.step2Book,
                      ),
                    ),
                  ).then(
                    (value) {
                      _bloc.appointmentList.clear();
                    },
                  ).whenComplete(() {
                    _bloc.getListPawnShop(
                      assetId: widget.assetId,
                    );
                  });
                }
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
          ),
        ],
      ),
    );
  }
}
