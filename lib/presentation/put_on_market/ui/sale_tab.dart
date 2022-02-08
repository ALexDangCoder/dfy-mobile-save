import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_number_of_quantity.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaleTab extends StatefulWidget {
  final PutOnMarketCubit cubit;
  final bool? canEdit;
  final int? quantity;
  final PutOnMarketModel putOnMarketModel;

  const SaleTab({
    Key? key,
    required this.cubit,
    this.canEdit = false,
    this.quantity = 1,
    required this.putOnMarketModel,
  }) : super(key: key);

  @override
  _SaleTabState createState() => _SaleTabState();
}

class _SaleTabState extends State<SaleTab>
    with AutomaticKeepAliveClientMixin<SaleTab> {
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;
  late PutOnMarketModel _putOnMarketModel;

  @override
  void initState() {
    // TODO: implement initState
    _putOnMarketModel = widget.putOnMarketModel;
    _putOnMarketModel.numberOfCopies = 1;
    super.initState();
  }

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
                    StreamBuilder<List<TokenInf>>(
                      stream: widget.cubit.listTokenStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        if (data.isNotEmpty) {
                          widget.cubit.changeTokenSale(
                            indexToken: 0,
                          );
                          _putOnMarketModel.tokenAddress =
                              widget.cubit.listToken[0].address ?? '';
                        }
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
                            widget.cubit.changeTokenSale(
                              indexToken: index,
                            );
                            _putOnMarketModel.tokenAddress =
                                widget.cubit.listToken[index].address ?? '';
                          },
                          onchangeText: (value) {
                            widget.cubit.changeTokenSale(
                              value: value != '' ? double.parse(value) : 0,
                            );
                            _putOnMarketModel.price = value;
                          },
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
                        _putOnMarketModel.numberOfCopies =
                            value != '' ? int.parse(value) : 0;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
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
                onTap: () async {
                  final navigator = Navigator.of(context);
                  if (data) {
                    final hexString = await widget.cubit.getHexStringPutOnSale(
                      _putOnMarketModel,
                      context,
                    );
                    unawaited(
                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) => Approve(
                            needApprove: true,
                            hexString: hexString,
                            payValue: _putOnMarketModel.price,
                            tokenAddress: _putOnMarketModel.tokenAddress,
                            putOnMarketModel: _putOnMarketModel,
                            onSuccessSign: (context, data) async {
                              final nav = Navigator.of(context);
                              final result = await widget.cubit.putOnSale(
                                txHash: data,
                                putOnMarketModel: _putOnMarketModel,
                              );
                              nav.pop();
                              if (result) {
                                await showLoadSuccess(context);
                                nav.popUntil((route) {
                                  return route.settings.name ==
                                      AppRouter.putOnSale;
                                });
                                nav.pop(true);
                              } else {
                                await showLoadFail(context);
                              }
                            },
                            onErrorSign: (context) async {
                              final nav = Navigator.of(context);
                              nav.pop();
                              await showLoadFail(context);
                            },
                            warning: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.ic_warning_canel,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${S.current.listing_is_free} ',
                                          style: textNormal(
                                            AppTheme.getInstance()
                                                .whiteColor()
                                                .withOpacity(0.7),
                                            14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '2.5%',
                                          style: textNormal(
                                            AppTheme.getInstance()
                                                .failTransactionColors()
                                                .withOpacity(0.7),
                                            14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: S.current.value_of_each_copy,
                                          style: textNormal(
                                            AppTheme.getInstance()
                                                .whiteColor()
                                                .withOpacity(0.7),
                                            14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: S.current.put_on_sale,
                            listDetail: [
                              DetailItemApproveModel(
                                title: '${S.current.sell_items} :',
                                value:
                                    '${widget.cubit.quantitySale} of ${widget.quantity ?? 1}',
                              ),
                              DetailItemApproveModel(
                                title: '${S.current.price_per_1} :',
                                value:
                                    '${widget.cubit.valueTokenInputSale ?? 0} ${widget.cubit.tokenSale?.symbol ?? 'DFY'}',
                                isToken: true,
                              )
                            ],
                            textActiveButton: S.current.put_on_sale,
                            typeApprove: TYPE_CONFIRM_BASE.PUT_ON_SALE,
                          ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
