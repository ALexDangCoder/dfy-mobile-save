import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_state.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/ui/item_send_to.dart';
import 'package:Dfy/presentation/pawn/loan_package_detail/ui/loan_package_detail.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../add_collateral_list/ui/add_collateral.dart';
import 'confirm_withdraw_collateral.dart';
import 'item_offes_received.dart';
import 'item_wiget_collateral_myacc.dart';

class CollateralDetailMyAccScreen extends StatefulWidget {
  const CollateralDetailMyAccScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _CollateralDetailMyAccScreenState createState() =>
      _CollateralDetailMyAccScreenState();
}

class _CollateralDetailMyAccScreenState
    extends State<CollateralDetailMyAccScreen> {
  late CollateralDetailMyAccBloc bloc;
  CollateralDetailMyAcc obj = CollateralDetailMyAcc();
  String mes = '';

  @override
  void initState() {
    super.initState();
    bloc = CollateralDetailMyAccBloc();
    bloc.getDetailCollateralMyAcc(
      collateralId: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.collateral_detail,
      child:
          BlocConsumer<CollateralDetailMyAccBloc, CollateralDetailMyAccState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CollateralDetailMyAccSuccess) {
            bloc.showContent();
            if (state.completeType == CompleteType.SUCCESS) {
              obj = state.obj ?? obj;
            } else {
              mes = state.message ?? '';
            }
          }
        },
        builder: (context, state) {
          return StateStreamLayout(
            stream: bloc.stateStream,
            retry: () {
              bloc.getDetailCollateralMyAcc(
                collateralId: widget.id,
              );
            },
            error: AppException(S.current.error, mes),
            textEmpty: mes,
            child: state is CollateralDetailMyAccSuccess
                ? RefreshIndicator(
                  onRefresh: () async {
                    await bloc.getDetailCollateralMyAcc(
                    collateralId: widget.id,
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 812.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                spaceH20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.status}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        bloc.getStatus(
                                          obj.status ?? 0,
                                        ),
                                        style: textNormalCustom(
                                          bloc.getColor(
                                            obj.status ?? 0,
                                          ),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.collateral_id}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        obj.id.toString(),
                                        style: textNormalCustom(
                                          null,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.message}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        obj.description.toString(),
                                        style: textNormalCustom(
                                          null,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.collateral}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: textNormal(
                                            null,
                                            16,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Image.network(
                                                ImageAssets.getSymbolAsset(
                                                  obj.collateralSymbol.toString(),
                                                ),
                                                width: 16.sp,
                                                height: 16.sp,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) =>
                                                    Container(
                                                  color: AppTheme.getInstance()
                                                      .bgBtsColor(),
                                                  width: 16.sp,
                                                  height: 16.sp,
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: SizedBox(
                                                width: 4.w,
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Text(
                                                '${formatPrice.format(
                                                  obj.collateralAmount ?? 0,
                                                )}'
                                                ' ${obj.collateralSymbol.toString().toUpperCase()}',
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: SizedBox(
                                                width: 16.w,
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddCollateral(
                                                        estimate:
                                                            formatPrice.format(
                                                          obj.estimatePrice ?? 0,
                                                        ),
                                                        id: widget.id,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  '${S.current.view_all}➞',
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .fillColor(),
                                                    16,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.total_estimate}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        '\$${formatPrice.format(
                                          obj.estimatePrice ?? 0,
                                        )}',
                                        style: textNormalCustom(
                                          null,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.loan_token}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: textNormal(
                                            null,
                                            16,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Image.network(
                                                ImageAssets.getSymbolAsset(
                                                  obj.loanSymbol.toString(),
                                                ),
                                                width: 16.sp,
                                                height: 16.sp,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) =>
                                                    Container(
                                                  color: AppTheme.getInstance()
                                                      .bgBtsColor(),
                                                  width: 16.sp,
                                                  height: 16.sp,
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: SizedBox(
                                                width: 4.w,
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Text(
                                                obj.loanSymbol
                                                    .toString()
                                                    .toUpperCase(),
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${S.current.duration_pawn}:',
                                        style: textNormalCustom(
                                          AppTheme.getInstance().pawnItemGray(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    spaceW4,
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        '${obj.durationQty} ${obj.durationType == WEEK ? S.current.weeks_pawn : S.current.months_pawn}',
                                        style: textNormalCustom(
                                          null,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceH36,
                                StreamBuilder<bool>(
                                  stream: bloc.isAdd,
                                  builder: (context, snapshot) {
                                    return ItemWidgetCollateralMyAcc(
                                      title: [
                                        Text(
                                          '${bloc.listOffersReceived.length} '
                                          '${S.current.offer_received.toUpperCase()}',
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .titleTabColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                      isBoolAdd: bloc.isAdd,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: bloc.listOffersReceived.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          top: 16.h,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OfferDetailMyAccScreen(
                                                    id: bloc
                                                        .listOffersReceived[index]
                                                        .id
                                                        .toString(),
                                                  ),
                                                  settings: const RouteSettings(
                                                    name: AppRouter
                                                        .send_nft_confirm_blockchain,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ItemOfferReceived(
                                              obj: bloc.listOffersReceived[index],
                                              bloc: bloc,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                spaceH32,
                                StreamBuilder<bool>(
                                  stream: bloc.isAddSend,
                                  builder: (context, snapshot) {
                                    return ItemWidgetCollateralMyAcc(
                                      title: [
                                        Text(
                                          '${S.current.send_to.toUpperCase()} '
                                          '${bloc.listSendToLoanPackageModel.length} '
                                          '${S.current.loan_package.toUpperCase()}',
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .titleTabColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                      isBoolAdd: bloc.isAddSend,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: bloc
                                            .listSendToLoanPackageModel.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          top: 16.h,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (bloc.checkPackage(
                                                bloc
                                                        .listSendToLoanPackageModel[
                                                            index]
                                                        .status ??
                                                    0,
                                              )) {
                                                goTo(
                                                  context,
                                                  LoanPackageDetail(
                                                    packageId: bloc
                                                        .listSendToLoanPackageModel[
                                                            index]
                                                        .id
                                                        .toString(),
                                                    packageType: bloc
                                                            .listSendToLoanPackageModel[
                                                                index]
                                                            .type ??
                                                        0,
                                                  ),
                                                );
                                              } else {
                                                showErrDialog(
                                                  context: context,
                                                  title: S.current.error,
                                                  content: 'NOT FOUNT 404',
                                                );
                                              }
                                            },
                                            child: ItemSendTo(
                                              obj:
                                                  bloc.listSendToLoanPackageModel[
                                                      index],
                                              bloc: bloc,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                spaceH152,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: bloc.checkBtn(obj.status ?? 0)
                              ? GestureDetector(
                                  onTap: () {
                                    if (PrefsService.getCurrentWalletCore()
                                            .toLowerCase() ==
                                        obj.walletAddress) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmWithDrawCollateral(
                                            bloc: bloc,
                                            obj: obj,
                                          ),
                                        ),
                                      ).whenComplete(
                                        () => bloc.getDetailCollateralMyAcc(
                                          collateralId: widget.id,
                                        ),
                                      );
                                    } else {
                                      showAlert(
                                        context,
                                        obj.walletAddress.toString(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: AppTheme.getInstance().bgBtsColor(),
                                    padding: EdgeInsets.only(
                                      bottom: 38.h,
                                    ),
                                    child: ButtonGold(
                                      isEnable: true,
                                      title: S.current.withdraw,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
