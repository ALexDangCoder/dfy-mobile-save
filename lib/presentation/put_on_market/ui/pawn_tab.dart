import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
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
  GlobalKey dropdownKey = GlobalKey();
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
                  S.current
                      .set_the_loan_amount_you_expected_to_have_for_the_nft,
                  style: textNormalCustom(
                    AppTheme.getInstance()
                        .textThemeColor()
                        .withOpacity(0.7),
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
                    }),
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
                  S.current
                      .Set_a_duration_for_the_desired_loan_term,
                  style: textNormalCustom(
                    AppTheme.getInstance()
                        .textThemeColor()
                        .withOpacity(0.7),
                    14,
                    FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                InputWithSelectType(
                  maxSize: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
                    AppTheme.getInstance()
                        .textThemeColor()
                        .withOpacity(0.7),
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
                    if (data) Navigator.pop(context);
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
