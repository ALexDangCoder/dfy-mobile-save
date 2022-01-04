import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/put_on_sale/ui/put_on_sale.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_number_of_quantity.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaleTab extends StatefulWidget {
  final PutOnMarketCubit cubit;
  final bool? canEdit;
  final int? quantity;

  const SaleTab(
      {Key? key, required this.cubit, this.canEdit = false, this.quantity = 1})
      : super(key: key);

  @override
  SaleTabState createState() => SaleTabState();
}

class SaleTabState extends State<SaleTab> {
  GlobalKey dropdownKey = GlobalKey();
  GlobalKey<InputWithSelectTypeState> inputPriceKey = GlobalKey();
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
                        S.current.set_the_fixed_price_and_sell_your_nft,
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
                      S.current.price,
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
                      S.current.set_a_sale_price_for_1_copy_of_nft,
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
                      maxLength: 25,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PutOnSale()),
              );
            },
          ),
          const SizedBox(
            height: 38,
          )
        ],
      ),
    );
  }

  void closeDropDown() {
    inputPriceKey.currentState?.closeDropDown();
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
