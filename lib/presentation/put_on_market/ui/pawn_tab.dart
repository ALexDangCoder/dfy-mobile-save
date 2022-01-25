import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_number_of_quantity.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PawnTab extends StatefulWidget {
  final bool? canEdit;
  final int? quantity;

  final PutOnMarketCubit cubit;

  const PawnTab(
      {Key? key, required this.cubit, this.canEdit = false, this.quantity = 1})
      : super(key: key);

  @override
  _PawnTabState createState() => _PawnTabState();
}

class _PawnTabState extends State<PawnTab>
    with AutomaticKeepAliveClientMixin<PawnTab> {
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;

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
              StreamBuilder<List<TokenInf>>(
                  stream: widget.cubit.listTokenStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return InputWithSelectType(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,5}'),
                        ),
                      ],
                      maxSize: 100,
                      keyboardType: TextInputType.number,
                      typeInput: data
                          .map(
                            (e) => SizedBox(
                          height: 64,
                          width: 70,
                          child: Row(
                            children: [
                              Flexible(
                                child: Image.network(
                                  e.iconUrl ?? '',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  e.symbol ?? '',
                                  style: textValueNFT.copyWith(
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          .toList(),
                      hintText: S.current.enter_price,
                      onChangeType: (index) {
                        // widget.cubit.changeTokenSale(
                        //   indexToken: index,
                        // );
                        // _putOnMarketModel.tokenAddress =
                        // '0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14';
                      },
                      onchangeText: (value) {
                        // widget.cubit.changeTokenSale(
                        //   value: value != '' ? double.parse(value) : null,
                        // );
                        // _putOnMarketModel.price = value;
                      },
                    );
                  },),
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
              InputWithSelectType(
                maxSize: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                typeInput: [
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: Center(
                      child: Text(
                        S.current.week,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ).copyWith(decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: Center(
                      child: Text(
                        S.current.month,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ).copyWith(decoration: TextDecoration.none),
                      ),
                    ),
                  )
                ],
                hintText: S.current.enter_duration,
                onChangeType: (index) {},
                onchangeText: (value) {
                  widget.cubit.changeDurationPawn(
                    value: value != '' ? int.parse(value) : null,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.current.quantity_of_collateral,
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
                S.current.set_the_nft_quantity_as_collateral,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputNumberOfQuantity(
                maxLength: 5,
                canEdit: widget.canEdit,
                quantity: widget.quantity,
                onchangeText: (value) {
                  widget.cubit.changeQuantityPawn(
                    value: value != '' ? int.parse(value) : 0,
                  );
                },
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
                              DetailItemApproveModel(
                                title: '${S.current.price_per_1} :',
                                value:
                                    '${widget.cubit.quantityPawn} of ${widget.quantity ?? 1}',
                              )
                            ],
                            textActiveButton: S.current.put_on_sale,
                            typeApprove: TYPE_CONFIRM_BASE.BUY_NFT,
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


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
