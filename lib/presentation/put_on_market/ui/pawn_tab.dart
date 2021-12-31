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
  PawnTabState createState() => PawnTabState();
}

class PawnTabState extends State<PawnTab> {
  @override
  GlobalKey dropdownKey = GlobalKey();
  GlobalKey<InputWithSelectTypeState> inputPriceKey = GlobalKey();
  GlobalKey<InputWithSelectTypeState> inputDurationKey = GlobalKey();
  late double width, height, xPosition, yPosition;
  late OverlayEntry floatingDropdown;
  int chooseIndex = 0;
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                              RegExp(r'^\d+\.?\d{0,5}')),
                        ],
                        maxSize: 100,
                        key: inputPriceKey,
                        keyboardType: TextInputType.number,
                        typeInput: typeInput(),
                        hintText: S.current.enter_price,
                        onChangeType: (index) {},
                        onchangeText: (value) {
                          print(value);
                        }),
                    const SizedBox(
                      height: 16,
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
                        maxSize: 4,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        key: inputDurationKey,
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
                        hintText: S.current.enter_price,
                        onChangeType: (index) {},
                        onchangeText: (value) {
                          print(value);
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      S.current.sale_quantity,
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
                      S.current.set_the_nft_quantity_you_want_to_sell,
                      style: textNormalCustom(
                        AppTheme.getInstance()
                            .textThemeColor()
                            .withOpacity(0.7),
                        14,
                        FontWeight.w400,
                      ),
                    ),
                    InputNumberOfQuantity(
                      maxLength: 5,
                      canEdit: widget.canEdit,
                      quantity: widget.quantity,
                      onchangeText: (value) {
                        print(value);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: ButtonGold(
              title: S.current.continue_s,
              isEnable: true,
            ),
            onTap: () {
              if (isDropdownOpened) {
                floatingDropdown.remove();
                isDropdownOpened = false;
              }
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 38,
          )
        ],
      ),
    );
  }

  void closeAllDropDown() {
    inputPriceKey.currentState?.closeDropDown();
    inputDurationKey.currentState?.closeDropDown();
  }

  List<Widget> typeInput() {
    return [
      Container(
        height: 40,
        width: 70,
        color: Colors.red,
      ),
      Container(
        height: 40,
        width: 70,
        color: Colors.blue,
      ),
      Container(
        height: 40,
        width: 70,
        color: Colors.red,
      ),
      Container(
        height: 40,
        width: 70,
        color: Colors.blue,
      ),
      Container(
        height: 40,
        width: 70,
        color: Colors.red,
      ),
      Container(
        height: 40,
        width: 70,
        color: Colors.blue,
      ),
    ];
  }
}
