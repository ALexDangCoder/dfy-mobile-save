import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/pick_time.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class AuctionTab extends StatefulWidget {
  final PutOnMarketCubit cubit;

  const AuctionTab({Key? key, required this.cubit}) : super(key: key);

  @override
  _AuctionTabState createState() => _AuctionTabState();
}

class _AuctionTabState extends State<AuctionTab>
    with AutomaticKeepAliveClientMixin<AuctionTab> {
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;
  bool outPrice = false;
  bool priceStep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  S.current.get_a_loan_by_nft_on_pawn_marketplace,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                S.current.expected_loan,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.set_the_loan_amount_you_expected_to_have_for_the_nft,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputWithSelectType(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,5}'),
                  ),
                ],
                maxSize: 100,
                keyboardType: TextInputType.number,
                typeInput: typeInput(),
                hintText: S.current.enter_price,
                onChangeType: (index) {},
                onchangeText: (value) {
                  widget.cubit.changeTokenPawn(
                    value: value != '' ? double.parse(value) : null,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.current.duration,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.Set_a_duration_for_the_desired_loan_term,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              datetimePickerCustom(
                date: S.current.start_date,
                time: S.current.start_time,
              ),
              const SizedBox(
                height: 16,
              ),
              datetimePickerCustom(
                date: S.current.end_date,
                time: S.current.end_time,
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.quantity_of_collateral,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    onChanged: (value) {
                      setState(() {
                        outPrice = value;
                      });
                    },
                    activeColor: AppTheme.getInstance().fillColor(),
                    value: outPrice,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.set_the_nft_quantity_as_collateral,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.quantity_of_collateral,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    onChanged: (value) {
                      setState(() {
                        priceStep = value;
                      });
                    },
                    activeColor: AppTheme.getInstance().fillColor(),
                    value: priceStep,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.set_the_nft_quantity_as_collateral,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: widget.cubit.canContinuePawnStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? false;
                return GestureDetector(
                  onTap: () {
                    if (data) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Approve(
                            isShowTwoButton: true,
                            title: S.current.put_on_sale,
                            listDetail: [
                              DetailItemApproveModel(
                                title: '${S.current.expected_loan} :',
                                value:
                                    '${widget.cubit.valueTokenInputPawn ?? 0} DFY',
                                isToken: true,
                              ),
                              DetailItemApproveModel(
                                title: '${S.current.duration} :',
                                value:
                                    '${widget.cubit.valueDuration ?? 0} ${widget.cubit.typeDuration == DurationType.WEEK ? S.current.week : S.current.month}',
                              ),
                            ],
                            textActiveButton: S.current.put_on_sale,
                            action: (gasLimit, gasPrice) async {
                              await Future.delayed(const Duration(seconds: 3));
                            },
                            approve: () async {
                              await Future.delayed(const Duration(seconds: 3));
                              return true;
                            },
                            gasLimitFirst: 100.0,
                          ),
                        ),
                      );
                    }
                  },
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: data,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }

  Widget datetimePickerCustom({required String date, required String time}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: AppTheme.getInstance().backgroundBTSColor(),
      ),
      height: 116,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      ImageAssets.ic_clock_white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (_) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child:  AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              content: PickTime(
                                onChange: (){
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      child: TextField(
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: time,
                          hintStyle: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 1,
              color: AppTheme.getInstance().divideColor(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      ImageAssets.ic_calendar,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // showDialog(
                        //   barrierDismissible: true,
                        //   context: context,
                        //   builder: (_) => BackdropFilter(
                        //     filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        //     child:  AlertDialog(
                        //       elevation: 0,
                        //       backgroundColor: Colors.transparent,
                        //       content: PickTime(
                        //         onChange: (){
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                      child: TextField(
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: date,
                          hintStyle: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> typeInput() {
    return [
      SizedBox(
        height: 64,
        width: 70,
        child: Row(
          children: [
            Flexible(
              child: Image.network(
                'https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/DFY.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'DFY',
                style: textValueNFT.copyWith(decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 64,
        width: 70,
        child: Row(
          children: [
            Flexible(
              child: Image.network(
                'https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BTC.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'BTC',
                style: textValueNFT.copyWith(decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 64,
        width: 70,
        child: Row(
          children: [
            Flexible(
              child: Image.network(
                'https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BNB.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'BNB',
                style: textValueNFT.copyWith(decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 64,
        width: 70,
        child: Row(
          children: [
            Flexible(
              child: Image.network(
                'https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ETH.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'ETH',
                style: textValueNFT.copyWith(decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
    ];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
