import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
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

  const SaleTab({
    Key? key,
    required this.cubit,
    this.canEdit = false,
    this.quantity = 1,
  }) : super(key: key);

  @override
  _SaleTabState createState() => _SaleTabState();
}

class _SaleTabState extends State<SaleTab>
    with AutomaticKeepAliveClientMixin<SaleTab> {
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
                      onChangeType: (index) {
                        //print (index);
                      },
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
                    const SizedBox(
                      height: 4,
                    ),
                    InputNumberOfQuantity(
                      maxLength: 25,
                      canEdit: widget.canEdit,
                      quantity: widget.quantity,
                      onchangeText: (value) {
                        widget.cubit.changeQuantitySale(
                          value: value != '' ? int.parse(value) : 0,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: widget.cubit.canContinueSaleStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? false;
              return GestureDetector(
                onTap: () {
                  if (data) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Approve(
                          showPopUp: true,
                          warning: RichText(
                            text: TextSpan(
                              text:
                                  'Listing is free. The the time of the sale, ',
                              style: textNormal(
                                AppTheme.getInstance()
                                    .whiteColor()
                                    .withOpacity(0.7),
                                14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '2.5%',
                                  style: textNormal(
                                    AppTheme.getInstance()
                                        .failTransactionColors()
                                        .withOpacity(0.7),
                                    14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: ' value of each copy will be deducted',
                                  style: textNormal(
                                    AppTheme.getInstance()
                                        .whiteColor()
                                        .withOpacity(0.7),
                                    14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: S.current.put_on_sale,
                          listDetail: [
                            DetailItemApproveModel(
                              title: '${S.current.sale_items} :',
                              value:
                                  '${widget.cubit.quantitySale} of ${widget.quantity ?? 1}',
                            ),
                            DetailItemApproveModel(
                              title: '${S.current.price_per_1} :',
                              value:
                                  '${widget.cubit.valueTokenInputSale ?? 0} DFY',
                              isToken: true,
                            )
                          ],
                          textActiveButton: S.current.put_on_sale,
                          action: (gasLimit,gasPrice )  async {
                            await Future.delayed(const Duration(seconds: 3));
                          },
                          approve: () async {
                            await Future.delayed(const Duration(seconds: 3));
                            print ("approve");
                            return true;
                          },
                          gasLimitFirst: 100,
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
