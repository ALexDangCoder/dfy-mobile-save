import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_sale_ft_pawn.dart';
import 'package:flutter/material.dart';
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
    required this.typeConfirm,
    required this.addressFrom,
    required this.addressTo,
    this.nameToken,
    this.amount,
  }) : super(key: key);

  final TYPE_CONFIRM typeConfirm;

  //this field depend on name token
  final String? nameToken;
  final String addressFrom;
  final String addressTo;
  final double? amount;

  @override
  _ConfirmBlockchainCategoryState createState() =>
      _ConfirmBlockchainCategoryState();
}

class _ConfirmBlockchainCategoryState extends State<ConfirmBlockchainCategory> {
  //2 controllers below manage text field
  late TextEditingController _txtGasLimit;
  late TextEditingController _txtGasPrice;
  late String titleBts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtGasLimit = TextEditingController();
    _txtGasPrice = TextEditingController();
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: titleBts,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.typeConfirm == TYPE_CONFIRM.SEND_TOKEN ||
                      widget.typeConfirm == TYPE_CONFIRM.SEND_NFT ||
                      widget.typeConfirm == TYPE_CONFIRM.PLACE_BID) ...[
                    FormAddFtAmount(
                      typeForm: TypeIsHaveAmount.HAVE_AMOUNT,
                      from: widget.addressFrom,
                      to: widget.addressTo,
                      amount: formatValue.format(widget.amount),
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
                    )
                  ] else if (widget.typeConfirm == TYPE_CONFIRM.SEND_OFFER) ...[
                    const FormSaleFtPawn(
                      isPawnOrSale: IS_PAWN_OR_SALE.SEND_OFFER,
                      loanToVl: 10,
                      loanAmount: 10000,
                      interestRate: 5,
                      ltvLiquidThreshold: 10,
                      duration: 24,
                      repaymentCurrent: 'DFY',
                      // recurringInterest: ,
                    )
                  ] else ...[] //will not appear
                  // else
                  //   {}
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
