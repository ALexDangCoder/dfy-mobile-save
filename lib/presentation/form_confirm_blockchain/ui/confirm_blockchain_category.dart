import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_show_ft_hide_blockchain.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_sale_ft_pawn.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/information_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    required this.tokenAddress,
    required this.addressFrom,
    required this.addressTo,
    required this.imageWallet,
    required this.cubitCategory,
    required this.gasPriceFirstFetch,
    required this.gasFeeFirstFetch,
    required this.gasLimitFirstFetch,
    this.nameToken,
    this.amount,
    this.quantity,
    this.modelToken,
  }) : super(key: key);

  final TYPE_CONFIRM typeConfirm;

  //this field depend on name token
  final String? nameToken;
  final String addressFrom;
  final String tokenAddress;
  final String addressTo;
  final double? amount;
  final String nameWallet;
  final int? quantity;
  final String nameTokenWallet;
  final double balanceWallet;
  final double gasPriceFirstFetch;
  final double gasFeeFirstFetch;
  final double gasLimitFirstFetch;
  final String imageWallet;
  final dynamic cubitCategory;
  final ModelToken? modelToken;

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
  final FormFieldBlockchainCubit cubitFormCustomizeGasFee =
      FormFieldBlockchainCubit();
  late int nonce;
  late double balanceWallet;

  @override
  void initState() {
    _txtGasLimit = TextEditingController(
      text: widget.gasLimitFirstFetch.toString(),
    );
    _txtGasPrice =
        TextEditingController(text: widget.gasPriceFirstFetch.toString());
    //if token != bnb will not subtract else subtract, do not delete this line
    if(widget.nameToken != 'BNB') {
      balanceWallet = widget.balanceWallet;
    } else {
      balanceWallet = widget.balanceWallet - widget.amount!.toDouble();
    }
    _informationWallet = InformationWallet(
      nameWallet: widget.nameWallet,
      fromAddress: widget.addressFrom.formatAddressWallet(),
      amount: balanceWallet,
      nameToken: widget.nameTokenWallet,
      imgWallet: widget.imageWallet,
    );
    trustWalletChannel.setMethodCallHandler(
        cubitFormCustomizeGasFee.nativeMethodCallBackTrustWallet);

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
      child: BlocConsumer<FormFieldBlockchainCubit, FormFieldBlockchainState>(
        listener: (context, state) {
          if (state is FormBlockchainSendTokenSuccess) {
            Navigator.pop(context);
            Navigator.pop(context, true);
          } else {
            _showDialog(alert: S.current.failed);
          }
        },
        bloc: cubitFormCustomizeGasFee,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                              if (widget.typeConfirm ==
                                      TYPE_CONFIRM.SEND_TOKEN ||
                                  widget.typeConfirm ==
                                      TYPE_CONFIRM.PLACE_BID) ...[
                                FormAddFtAmount(
                                  typeForm: TypeIsHaveAmount.HAVE_AMOUNT,
                                  from:
                                      widget.addressFrom.formatAddressWallet(),
                                  to: widget.addressTo.formatAddressWallet(),
                                  amount: formatValue.format(widget.amount),
                                )
                              ] else if (widget.typeConfirm ==
                                  TYPE_CONFIRM.SEND_NFT) ...[
                                FormAddFtAmount(
                                  typeForm: TypeIsHaveAmount.HAVE_QUANTITY,
                                  from:
                                      widget.addressFrom.formatAddressWallet(),
                                  to: widget.addressTo.formatAddressWallet(),
                                  quantity: widget.quantity,
                                )
                              ] else ...[
                                FormAddFtAmount(
                                  typeForm: TypeIsHaveAmount.NO_HAVE_AMOUNT,
                                  from:
                                      widget.addressFrom.formatAddressWallet(),
                                  to: widget.addressTo.formatAddressWallet(),
                                ),
                              ],
                              const Divider(
                                thickness: 1,
                                color: Color.fromRGBO(255, 255, 255, 0.1),
                              ),
                              if (widget.typeConfirm ==
                                  TYPE_CONFIRM.BUY_NFT) ...[
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
                                cubit: cubitFormCustomizeGasFee,
                                gasFeeFirstFetch: (widget.gasLimitFirstFetch *
                                        widget.gasPriceFirstFetch) /
                                    1000000000,
                                gasPriceFirstFetch: widget.gasPriceFirstFetch,
                                gasLimitFirstFetch: widget.gasLimitFirstFetch,
                                balanceWallet: widget.balanceWallet -
                                    widget.amount!.toDouble(),
                                txtGasLimit: _txtGasLimit,
                                txtGasPrice: _txtGasPrice,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                        initialData: ((widget.gasLimitFirstFetch *
                                    widget.gasPriceFirstFetch) /
                                1000000000) <
                            widget.balanceWallet,
                        stream: cubitFormCustomizeGasFee.isEnableBtnStream,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: () async {
                              if (snapshot.data ??
                                  (((widget.gasLimitFirstFetch *
                                              widget.gasPriceFirstFetch) /
                                          1000000000) <
                                      widget.balanceWallet)) {
                                switch (widget.typeConfirm) {
                                  case TYPE_CONFIRM.SEND_TOKEN:
                                    final nonce = await cubitFormCustomizeGasFee
                                        .getNonceWeb3(
                                      walletAddress: widget.addressFrom,
                                    );
                                    await cubitFormCustomizeGasFee
                                        .signTransactionToken(
                                      toAddress: widget.addressTo,
                                      gasPrice: (widget.gasPriceFirstFetch *
                                              1000000000)
                                          .toString(),
                                      nonce: nonce.toString(),
                                      gasLimit: double.parse(_txtGasLimit.text)
                                          .toString(),
                                      amount: ((widget.amount ?? 0) *
                                              1000000000000000000)
                                          .toString(),
                                      // 1000000000000000000 -> 1 dfy
                                      tokenAddress: widget.tokenAddress,
                                      walletAddress: widget.addressFrom,
                                      chainId: '97',
                                    );
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
                              } else {
                                //btn disable will not do anything
                              }
                            },
                            child: ButtonGold(
                              title: S.current.approve,
                              isEnable: snapshot.data ??
                                  (widget.gasFeeFirstFetch <
                                      widget.balanceWallet),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //fake to demo
  void _showDialog({String? alert, String? text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                36.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  alert ?? S.current.password_is_not_correct,
                  style: textNormalCustom(
                    Colors.white,
                    20.sp,
                    FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              spaceH16,
              Text(
                text ?? S.current.please_try_again,
                style: textNormalCustom(
                  Colors.white,
                  12.sp,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            Center(
              child: TextButton(
                child: Text(
                  S.current.ok,
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
