import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/presentation/restore_account/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';

class SendNft extends StatefulWidget {
  const SendNft({
    Key? key,
    required this.nameWallet,
    required this.nftInfo,
    required this.addressFrom,
    required this.imageWallet,
    this.pageRouter,
  }) : super(key: key);
  final String addressFrom;
  final NftInfo nftInfo;
  final String nameWallet;
  final String imageWallet;
  final PageRouter? pageRouter;

  @override
  _SendNftState createState() => _SendNftState();
}

class _SendNftState extends State<SendNft> {
  late TextEditingController txtToAddressNft;
  late TextEditingController txtQuantity;
  late SendTokenCubit sendNftCubit;
  late double balanceWallet;
  late double gasPrice;
  late double estimateGasFee;

  // int maxQuantityFirstFetch = 10;

  @override
  void initState() {
    super.initState();
    sendNftCubit = SendTokenCubit();
    sendNftCubit.getGasPrice();
    sendNftCubit.getBalanceWallet(ofAddress: widget.addressFrom);
    sendNftCubit.getGasPrice();
    txtToAddressNft = TextEditingController();
    txtQuantity = TextEditingController();
    txtQuantity.text = '1';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: BlocConsumer<SendTokenCubit, SendTokenState>(
            listener: (context, state) {
              if (state is LoadingBeforeConfirm) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => const AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: TransactionSubmit(
                      justLoading: true,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      //handle todo fix gaslimit
                      return ConfirmBlockchainCategory(
                        nameWallet: 'Account',
                        nameTokenWallet: 'BNB',
                        balanceWallet: sendNftCubit.balanceWallet,
                        typeConfirm: TYPE_CONFIRM.SEND_NFT,
                        addressFrom: widget.addressFrom,
                        addressTo: txtToAddressNft.text,
                        imageWallet: ImageAssets.symbol,
                        quantity: int.parse(txtQuantity.text),
                        nameToken: 'BNB',
                        cubitCategory: sendNftCubit,
                        gasPriceFirstFetch: sendNftCubit.gasPrice / 1000000000,
                        gasFeeFirstFetch:
                            ((sendNftCubit.gasPrice / 1000000000) *
                                    sendNftCubit.gasLimitNft) /
                                1000000000,
                        gasLimitFirstFetch: sendNftCubit.gasLimitNft,
                        amount: 0,
                        nftInfo: widget.nftInfo,
                      );
                    },
                    settings: const RouteSettings(
                      name: AppRouter.send_nft_confirm_blockchain,
                    ),
                  ),
                ).then(
                  (value) => Navigator.of(context).pop(
                  ),
                );
              }
            },
            bloc: sendNftCubit,
            builder: (context, state) {
              return BaseDesignScreen(
                text: ImageAssets.ic_close,
                isImage: true,
                isHaveLeftIcon: false,
                title: S.current.send_nft,
                onRightClick: () {
                  Navigator.pop(context);
                },
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
                              spaceH24,
                              formShowFtAddress(
                                hintText:
                                    widget.addressFrom.formatAddressWallet(),
                                readOnly: true,
                                prefixImg: ImageAssets.ic_from,
                                suffixImg: '',
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              formShowFtAddress(
                                hintText: S.current.to_address,
                                suffixImg: ImageAssets.ic_qr_code,
                                prefixImg: ImageAssets.ic_to,
                                callBack: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => QRViewExample(
                                        controller: txtToAddressNft,
                                      ),
                                    ),
                                  ).then(
                                    (_) => {
                                      txtToAddressNft.text =
                                          sendNftCubit.handleValueFromQR(
                                        value: txtToAddressNft.text,
                                      ),
                                      sendNftCubit.checkValidateAddress(
                                        value: sendNftCubit.handleValueFromQR(
                                          value: txtToAddressNft.text,
                                        ),
                                      ),
                                      sendNftCubit.checkValidateQuantity(
                                        value: txtQuantity.text,
                                        quantityCopy: '1',
                                      ),
                                    },
                                  );
                                },
                              ),
                              txtWaringAddress(),
                              SizedBox(
                                height: 16.h,
                              ),
                              formAmountFtQuantity(
                                hintText: S.current.quantity,
                                isAmount: true,
                                isQuantity: true,
                                prefixImg: ImageAssets.ic_quantity,
                              ),
                              txtWaringQuantity(),
                              SizedBox(
                                height: 353.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: sendNftCubit.isShowCFBlockChainStream,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          child: ButtonGold(
                            title: S.current.continue_s,
                            isEnable: snapshot.data ?? true,
                          ),
                          onTap: () async {
                            if (snapshot.data ?? false) {
                              if (widget.pageRouter == PageRouter.MY_ACC) {
                                final hexString =
                                    await sendNftCubit.getHexStringSendNft(
                                  widget.nftInfo.contract ?? '',
                                  widget.addressFrom,
                                  txtToAddressNft.text,
                                  widget.nftInfo.id ?? '',
                                );
                                goTo(
                                  context,
                                  Approve(
                                    hexString: hexString,
                                    onSuccessSign: (context, data) async {
                                      await sendNftCubit.pushSendNftToBE(
                                        bcTxnHash: hexString,
                                        nftId: widget.nftInfo.nftId ?? '',
                                        walletReceived: txtToAddressNft.text,
                                      );
                                      showLoadSuccess(context).then(
                                        (value) {
                                          Navigator.of(context)
                                              .pop();
                                          Navigator.of(context)
                                              .pop();
                                          Navigator.of(context)
                                              .pop(txtToAddressNft.text);
                                        }
                                      );
                                    },
                                    onErrorSign: (context) {
                                      showLoadFail(context);
                                    },
                                    listDetail: [
                                      DetailItemApproveModel(
                                        title: S.current.to,
                                        value: txtToAddressNft.text
                                            .formatAddressWalletConfirm(),
                                      ),
                                      DetailItemApproveModel(
                                        title: S.current.quantity,
                                        value: '${txtQuantity.text} of 1',
                                      ),
                                    ],
                                    title: S.current.transfer,
                                    textActiveButton: S.current.transfer,
                                    spender: widget.nftInfo.contract ?? '',
                                  ),
                                );
                              } else {
                                await sendNftCubit.getGasLimitNft(
                                  fromAddress: widget.addressFrom,
                                  toAddress: txtToAddressNft.text,
                                  contract:
                                      widget.nftInfo.contract ?? 'contract',
                                  symbol: widget.nftInfo.collectionSymbol ??
                                      'symbol',
                                  id: widget.nftInfo.id ?? 'id',
                                  context: context,
                                );
                              }
                            } else {
                              //nothing
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Container formShowFtAddress({
    required String hintText,
    bool readOnly = false,
    Function()? callBack,
    required String suffixImg,
    required String prefixImg,
  }) {
    return Container(
      height: 64.h,
      // padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: TextFormField(
          controller: readOnly ? null : txtToAddressNft,
          onChanged: (value) {
            sendNftCubit.checkValidateAddress(
              value: value,
            );
            sendNftCubit.checkValidateQuantity(
                value: txtQuantity.text, quantityCopy: '1');
          },
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16,
          ),
          cursorColor: AppTheme.getInstance().textThemeColor(),
          textAlignVertical: TextAlignVertical.center,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              AppTheme.getInstance().disableColor(),
              14,
            ),
            suffixIcon: InkWell(
              onTap: callBack,
              child: suffixImg == ''
                  ? const SizedBox(
                      width: 0,
                    )
                  : ImageIcon(
                      AssetImage(suffixImg),
                      color: AppTheme.getInstance().textThemeColor(),
                    ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(prefixImg),
              color: AppTheme.getInstance().textThemeColor(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container formAmountFtQuantity({
    required String hintText,
    required bool isAmount,
    required bool isQuantity,
    required String prefixImg,
    Function()? callBack,
  }) {
    return Container(
      height: 64.h,
      // width: 323.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            sendNftCubit.checkValidateQuantity(value: value, quantityCopy: '1');
            sendNftCubit.checkValidateAddress(
              value: txtToAddressNft.text,
            );
          },
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          controller: txtQuantity,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16,
          ),
          cursorColor: AppTheme.getInstance().textThemeColor(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              AppTheme.getInstance().disableColor(),
              14,
            ),
            suffixIcon: InkWell(
              onTap: callBack,
              child: (isAmount && !isQuantity)
                  ? Center(
                      child: Text(
                        S.current.max,
                        style: textNormal(
                          const Color.fromRGBO(228, 172, 26, 1),
                          16,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(right: 20.w, top: 16.h),
                      child: Text(
                        '${S.current.of_all} 1',
                        style: textNormal(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                        ).copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(prefixImg),
              color: AppTheme.getInstance().textThemeColor(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget txtWaringAddress() {
    return StreamBuilder(
      initialData: false,
      stream: sendNftCubit.isValidAddressFormStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  initialData: '',
                  stream: sendNftCubit.txtInvalidAddressFormStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().failTransactionColors(),
                        12,
                        FontWeight.w400,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget txtWaringQuantity() {
    return StreamBuilder(
      initialData: false,
      stream: sendNftCubit.isValidQuantityFormStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  initialData: '',
                  stream: sendNftCubit.txtInvalidQuantityFormStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().failTransactionColors(),
                        12,
                        FontWeight.w400,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
