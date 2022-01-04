import 'dart:ffi';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/put_on_sale/ui/put_on_sale.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
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
  _SaleTabState createState() => _SaleTabState();
}

class _SaleTabState extends State<SaleTab>
    with AutomaticKeepAliveClientMixin<SaleTab> {
  GlobalKey dropdownKey = GlobalKey();
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;

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
                          RegExp(r'^\d+\.?\d{0,5}'),
                        ),
                      ],
                      maxSize: 100,
                      keyboardType: TextInputType.number,
                      typeInput: typeInput(),
                      hintText: S.current.enter_price,
                      onChangeType: (index) {},
                      onchangeText: (value) {
                        widget.cubit.changeTokenSale(
                          value: value != '' ? double.parse(value) : null,
                        );
                      },
                    ),
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
                      canEdit: true,
                      quantity: widget.quantity,
                      onchangeText: (value) {
                        widget.cubit.changeQuantitySale(
                            value: value != '' ? int.parse(value) : 0);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: StreamBuilder<bool>(
                stream: widget.cubit.canContinueSaleStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? false;
                  return ButtonGold(
                    title: S.current.continue_s,
                    isEnable: data,
                  );
                }),
            onTap: () {
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
