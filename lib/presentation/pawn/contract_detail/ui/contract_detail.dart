import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum TypeBorrow { CRYPTO_TYPE, NFT_TYPE }

class ContractDetail extends StatefulWidget {
  const ContractDetail({
    Key? key,
    required this.type,
  }) : super(key: key);
  final TypeBorrow type;

  @override
  _ContractDetailState createState() => _ContractDetailState();
}

class _ContractDetailState extends State<ContractDetail> {
  late ContractDetailBloc bloc;
  String mes = '';

  @override
  void initState() {
    super.initState();
    bloc = ContractDetailBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.contract_details,//todo
      child: BlocConsumer<ContractDetailBloc, ContractDetailState>(
        bloc: bloc,
        listener: (context, state) {
          // if (state is CollateralDetailMyAccSuccess) {
          //   bloc.showContent();
          //   if (state.completeType == CompleteType.SUCCESS) {
          //     obj = state.obj ?? obj;
          //   } else {
          //     mes = state.message ?? '';
          //   }
          // }
        },
        builder: (context, state) {
          return StateStreamLayout(
            stream: bloc.stateStream,
            retry: () {
              // bloc.getDetailCollateralMyAcc(
              //   collateralId: widget.id,
              // );
            },
            error: AppException(S.current.error, mes),
            textEmpty: mes,
            child: !(state is ContractDetailSuccess)
                ? Stack(
                    children: [
                      Container(
                        height: 812.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 343.w,
                                  margin: EdgeInsets.only(
                                    bottom: 20.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.getInstance()
                                        .borderItemColor(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                    border: Border.all(
                                      color:
                                      AppTheme.getInstance().divideColor(),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: 16.w,
                                      left: 16.w,
                                      top: 20.h,
                                      bottom: 20.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.current.lender,
                                          style: textNormalCustom(
                                            null,
                                            20,
                                            FontWeight.w700,
                                          ),
                                        ),
                                        spaceH8,
                                        RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                                child: Text(
                                                  '${S.current.address}:',
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .pawnItemGray(),
                                                    16,
                                                    FontWeight.w400,
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
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launchURL(
                                                      Get.find<
                                                          AppConstants>()
                                                          .bscScan +
                                                          ApiConstants
                                                              .BSC_SCAN_ADDRESS +
                                                          (''),//todo
                                                    );
                                                  },
                                                  child: Text(
                                                    // checkNullAddressWallet(
                                                    //   obj.walletAddress ?? '',
                                                    // ),
                                                    'adđress',
                                                    style: textNormalCustom(
                                                      AppTheme.getInstance()
                                                          .blueMarketColors(),
                                                      16,
                                                      FontWeight.w400,
                                                    ).copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceH8,
                                        RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                                child: Text(
                                                  '${S.current.address}:',
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .borderItemColor(),
                                                    16,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                PlaceholderAlignment.middle,
                                                child: Image.asset(
                                                  ImageAssets.ic_star,
                                                  height: 20.h,
                                                  width: 20.w,
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
                                                child: StreamBuilder<String>(
                                                //  stream: bloc.rate,//todo
                                                  builder: (context, snapshot) {
                                                    return Text(
                                                      snapshot.data.toString(),
                                                      style: textNormalCustom(
                                                        null,
                                                        16,
                                                        FontWeight.w400,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceH20,
                                        Row(
                                          children: [

                                            GestureDetector(
                                              onTap: () {
                                                //todo
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.getInstance()
                                                      .borderItemColor(),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.r),
                                                  ),
                                                  border: Border.all(
                                                    color: AppTheme.getInstance()
                                                        .fillColor(),
                                                  ),
                                                ),
                                                child: Text(
                                                  S.current.review,
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .fillColor(),
                                                    16,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: widget.type == TypeBorrow.CRYPTO_TYPE
                            ? GestureDetector(
                                onTap: () {
                                  //todo
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
                            : GestureDetector(
                          onTap: () {
                            //todo
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
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
