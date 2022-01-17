import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_show_ft_hide_blockchain.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_success.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_sale_ft_pawn.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/information_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    required this.gasLimitFirstFetch,
    this.nameToken,
    this.amount,
    this.quantity,
    this.modelToken,
    this.nftInfo,
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
  final double gasLimitFirstFetch;
  final String imageWallet;
  final ModelToken? modelToken;
  final NftInfo? nftInfo;

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
  final FormFieldBlockchainCubit cubitFormCustomizeGasFee =
      FormFieldBlockchainCubit();
  late int nonce;
  late double balanceWallet;
  final appConstants = Get.find<AppConstants>();

  @override
  void initState() {
    //if token != bnb will not subtract else subtract, do not delete this line
    if (widget.nameToken != 'BNB') {
      balanceWallet = widget.balanceWallet;
    } else {
      balanceWallet = widget.balanceWallet - widget.amount!.toDouble();
    }
    _txtGasLimit = TextEditingController(
      text: widget.gasLimitFirstFetch.toString(),
    );
    _txtGasPrice =
        TextEditingController(text: widget.gasPriceFirstFetch.toString());
    _informationWallet = InformationWallet(
      cubit: cubitFormCustomizeGasFee,
      nameWallet: widget.nameWallet,
      fromAddress: widget.addressFrom.formatAddressWallet(),
      amount: balanceWallet,
      nameToken: widget.nameTokenWallet,
      // imgWallet: widget.imageWallet,
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
        //todo this listener
        listener: (context, state) {
          if (state is FormBlockchainSendNftSuccess) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmitSuccess(),
              ),
            ).then(
              (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(
                    index: 1,
                  ),
                ),
                (route) => route.isFirst,
              ),
            );
          } else if (state is FormBlockchainSendNftLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmit(),
              ),
            );
          } else if (state is FormBlockchainSendNftFail) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmitFail(),
              ),
            ).then(
              (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(
                    index: 1,
                  ),
                ),
                (route) => route.isFirst,
              ),
            );
          } else if (state is FormBlockchainSendTokenLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmit(),
              ),
            );
          } else if (state is FormBlockchainSendTokenSuccess) {
            //Pop loading dialog
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmitSuccess(),
              ),
            );
            //Pop success dialog
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
              //Pop confirm blockchain
              Navigator.pop(context);
              //Pop confirm SendToken
              //final txhIDToken = cubitFormCustomizeGasFee.txHashToken;
              Navigator.pop(context, true);
            });
          } else {
            //Pop loading dialog
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmitFail(),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
              //Pop confirm blockchain
              Navigator.pop(context);
              //Pop confirm SendToken
              //final txhIDToken = cubitFormCustomizeGasFee.txHashToken;
              Navigator.pop(context, true);
            });
          }
        },
        bloc: cubitFormCustomizeGasFee,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
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
                                  from: widget.addressFrom
                                      .formatAddressWalletConfirm(),
                                  to: widget.addressTo
                                      .formatAddressWalletConfirm(),
                                  amount: formatValue.format(widget.amount),
                                  nameToken: widget.nameToken,
                                )
                              ] else if (widget.typeConfirm ==
                                  TYPE_CONFIRM.SEND_NFT) ...[
                                FormAddFtAmount(
                                  typeForm: TypeIsHaveAmount.HAVE_QUANTITY,
                                  from: widget.addressFrom
                                      .formatAddressWalletConfirm(),
                                  to: widget.addressTo
                                      .formatAddressWalletConfirm(),
                                  quantity: widget.quantity,
                                )
                              ] else ...[
                                FormAddFtAmount(
                                  typeForm: TypeIsHaveAmount.NO_HAVE_AMOUNT,
                                  from: widget.addressFrom
                                      .formatAddressWalletConfirm(),
                                  to: widget.addressTo
                                      .formatAddressWalletConfirm(),
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
                                gasFeeFirstFetch: widget.gasFeeFirstFetch,
                                gasPriceFirstFetch: widget.gasPriceFirstFetch,
                                gasLimitFirstFetch: widget.gasLimitFirstFetch,
                                balanceWallet: balanceWallet,
                                txtGasLimit: _txtGasLimit,
                                txtGasPrice: _txtGasPrice,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      initialData: widget.gasFeeFirstFetch < balanceWallet,
                      stream: cubitFormCustomizeGasFee.isEnableBtnStream,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () async {
                            if (snapshot.data ??
                                (widget.gasFeeFirstFetch < balanceWallet)) {
                              switch (widget.typeConfirm) {
                                case TYPE_CONFIRM.SEND_TOKEN:
                                  final nonce = await cubitFormCustomizeGasFee
                                      .getNonceWeb3(
                                    walletAddress: widget.addressFrom,
                                  );
                                  cubitFormCustomizeGasFee.signTransactionToken(
                                    toAddress: widget.addressTo,
                                    gasPrice: widget.gasPriceFirstFetch
                                        .toInt()
                                        .toString(),
                                    nonce: nonce.toString(),
                                    gasLimit: double.parse(_txtGasLimit.text)
                                        .toInt()
                                        .toString(),
                                    amount: (widget.amount).toString(),
                                    tokenAddress:
                                        widget.modelToken!.tokenAddress,
                                    walletAddress: widget.addressFrom,
                                    chainId: appConstants.chaninId,
                                    symbol:
                                        widget.modelToken?.nameShortToken ?? '',
                                    gasFee:
                                        '${double.parse(_txtGasLimit.text) / 100000000} ${widget.nameTokenWallet}',
                                  );
                                  break;
                                case TYPE_CONFIRM.SEND_NFT:
                                  final nonce = await cubitFormCustomizeGasFee
                                      .getNonceWeb3(
                                    walletAddress: widget.addressFrom,
                                  );
                                  cubitFormCustomizeGasFee.signTransactionNFT(
                                    fromAddress: widget.addressFrom,
                                    toAddress: widget.addressTo,
                                    contractNft:
                                        widget.nftInfo?.contract ?? 'contract',
                                    nonce: nonce.toString(),
                                    gasLimit: double.parse(_txtGasLimit.text)
                                        .toInt()
                                        .toString(),
                                    gasPrice: widget.gasPriceFirstFetch
                                        .toInt()
                                        .toString(),
                                    nftID: widget.nftInfo?.id ?? 'id',
                                    chainId: appConstants.chaninId,
                                    gasFee:
                                        '${double.parse(_txtGasLimit.text) / 100000000} ${widget.nameTokenWallet}',
                                    //todo hardcode amount 1
                                    amount: widget.quantity.toString(),
                                    symbol:
                                        widget.nftInfo?.collectionSymbol ?? '',
                                  );
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
                                (widget.gasFeeFirstFetch < balanceWallet),
                          ),
                        );
                      },
                    ),
                    spaceH38,
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

}
