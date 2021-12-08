import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_show_ft_hide_blockchain.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_sale_ft_pawn.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/information_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum TYPE_CONFIRM {
  SEND_NFT,
  SEND_TOKEN,
  BUY_NFT,
  SEND_OFFER,
  PLACE_BID,
}

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class ConfirmBlockchainCategory extends StatefulWidget {
  const ConfirmBlockchainCategory({
    Key? key,
    required this.nameWallet,
    required this.nameTokenWallet,
    required this.balanceWallet,
    required this.typeConfirm,
    required this.addressFrom,
    required this.addressTo,
    required this.imageWallet,
    required this.cubitCategory,
    required this.gasPriceFirstFetch,
    required this.gasFeeFirstFetch,
    this.nameToken,
    this.amount,
    this.quantity,
  }) : super(key: key);

  final TYPE_CONFIRM typeConfirm;

  //this field depend on name token
  final String? nameToken;
  final String addressFrom;
  final String addressTo;
  final double? amount;
  final String nameWallet;
  final int? quantity;
  final String nameTokenWallet;
  final double balanceWallet;
  final double gasPriceFirstFetch;
  final double gasFeeFirstFetch;
  final String imageWallet;
  final dynamic cubitCategory;

  @override
  _ConfirmBlockchainCategoryState createState() =>
      _ConfirmBlockchainCategoryState();
}

class _ConfirmBlockchainCategoryState extends State<ConfirmBlockchainCategory> {
  //2 controllers below manage text field
  late TextEditingController _txtGasLimit;
  late TextEditingController _txtGasPrice;
  late String titleBts;
  late InformationWallet _informationWallet;
  late FormFieldBlockchainCubit _cubitFormCustomizeGasFee;

  @override
  void initState() {
    _cubitFormCustomizeGasFee = FormFieldBlockchainCubit();

    _txtGasLimit =
        TextEditingController(text: widget.gasFeeFirstFetch.toString());
    _txtGasPrice =
        TextEditingController(text: widget.gasPriceFirstFetch.toString());
    _informationWallet = InformationWallet(
      nameWallet: widget.nameWallet,
      fromAddress: widget.addressFrom,
      amount: widget.balanceWallet,
      nameToken: widget.nameTokenWallet,
      imgWallet: widget.imageWallet,
    );
    if (widget.typeConfirm == TYPE_CONFIRM.SEND_TOKEN) {
      final cubit = widget.cubitCategory as SendTokenCubit;
      trustWalletChannel
          .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    }
    switch (widget.typeConfirm) {
      case TYPE_CONFIRM.SEND_NFT:
        titleBts = S.current.send_nft;
        break;
      case TYPE_CONFIRM.SEND_TOKEN:
        titleBts = '${S.current.send} ${widget.nameToken}';
        break;
      case TYPE_CONFIRM.BUY_NFT:
        titleBts = S.current.buy_nft;
        break;
      case TYPE_CONFIRM.SEND_OFFER:
        titleBts = S.current.send_offer;
        break;
      default:
        titleBts = S.current.place_a_bid;
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: BaseBottomSheet(
            title: titleBts,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          if (widget.typeConfirm == TYPE_CONFIRM.SEND_TOKEN ||
                              widget.typeConfirm == TYPE_CONFIRM.PLACE_BID) ...[
                            FormAddFtAmount(
                              typeForm: TypeIsHaveAmount.HAVE_AMOUNT,
                              from: widget.addressFrom,
                              to: widget.addressTo,
                              amount: formatValue.format(widget.amount),
                            )
                          ] else if (widget.typeConfirm ==
                              TYPE_CONFIRM.SEND_NFT) ...[
                            FormAddFtAmount(
                              typeForm: TypeIsHaveAmount.HAVE_QUANTITY,
                              from: widget.addressFrom,
                              to: widget.addressTo,
                              quantity: widget.quantity,
                            )
                          ] else ...[
                            FormAddFtAmount(
                              typeForm: TypeIsHaveAmount.NO_HAVE_AMOUNT,
                              from: widget.addressFrom,
                              to: widget.addressTo,
                            ),
                          ],
                          const Divider(
                            thickness: 1,
                            color: Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          if (widget.typeConfirm == TYPE_CONFIRM.BUY_NFT) ...[
                            const FormSaleFtPawn(
                              isPawnOrSale: IS_PAWN_OR_SALE.BUY,
                              quantity: 5,
                              pricePerOne: 10000,
                              totalPayment: 50000,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.1),
                            ),
                          ] else if (widget.typeConfirm ==
                              TYPE_CONFIRM.SEND_OFFER) ...[
                            const FormSaleFtPawn(
                              isPawnOrSale: IS_PAWN_OR_SALE.SEND_OFFER,
                              loanToVl: 10,
                              loanAmount: 10000,
                              interestRate: 5,
                              ltvLiquidThreshold: 10,
                              duration: 24,
                              repaymentCurrent: 'DFY',
                              recurringInterest: 'months',
                              // recurringInterest: ,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.1),
                            ),
                          ] else
                            ...[],
                          _informationWallet, //will not appear
                          spaceH16,
                          FormShowFtHideCfBlockchain(
                            nameToken: widget.nameTokenWallet,
                            cubit: _cubitFormCustomizeGasFee,
                            gasFeeFirstFetch: widget.gasFeeFirstFetch,
                            gasPriceFirstFetch: widget.gasPriceFirstFetch,
                            gasLimitFirstFetch: widget.gasFeeFirstFetch,
                            balanceWallet: widget.balanceWallet,
                            txtGasLimit: _txtGasLimit,
                            txtGasPrice: _txtGasPrice,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    switch (widget.typeConfirm) {
                      case TYPE_CONFIRM.SEND_TOKEN:
                        final cubit = widget.cubitCategory as SendTokenCubit;
                        cubit.signTransaction(
                          fromAddress: widget.addressFrom,
                          toAddress: widget.addressTo,
                          chainId: widget.nameToken ?? '',
                          gasPrice: widget.gasPriceFirstFetch,
                          price: double.parse(_txtGasLimit.text),
                          maxGas: widget.gasFeeFirstFetch,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context,true);
                        break;
                      case TYPE_CONFIRM.SEND_NFT:
                        break;
                      case TYPE_CONFIRM.SEND_OFFER:
                        break;
                      case TYPE_CONFIRM.BUY_NFT:
                        break;
                      case TYPE_CONFIRM.PLACE_BID:
                        break;
                      default:
                        break;
                    }
                  },
                  child: ButtonGold(
                    title: S.current.approve,
                    isEnable: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
