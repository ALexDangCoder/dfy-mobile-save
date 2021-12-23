import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/presentation/restore_account/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendToken extends StatefulWidget {
  final String walletAddress;
  final ModelToken modelToken;
  final String walletName;

  const SendToken({
    Key? key,
    required this.walletAddress,
    required this.modelToken,
    required this.walletName,
  }) : super(key: key);

  @override
  _SendTokenState createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  late SendTokenCubit tokenCubit;

  // final String fakeToAddress = '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf';
  late TextEditingController txtToAddressToken;
  late TextEditingController txtAmount;

  //todo truyen amount
  @override
  void initState() {
    super.initState();
    txtToAddressToken = TextEditingController();
    txtAmount = TextEditingController();
    tokenCubit = SendTokenCubit();
    // tokenCubit.getEstimateGas(
    //   from: fakeFromAddress,
    //   to: fakeToAddress,
    //   value: 1000,
    // );
    tokenCubit.getBalanceWallet(ofAddress: widget.walletAddress);
    tokenCubit.getGasPrice();
    // trustWalletChannel
    //     .setMethodCallHandler(tokenCubit.nativeMethodCallBackTrustWallet);
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
      child: BaseBottomSheet(
        isImage: true,
        text: ImageAssets.ic_close,
        title: '${S.current.send} ${widget.modelToken.nameShortToken}',
        onRightClick: () {
          Navigator.pop(context);
        },
        isHaveLeftIcon: false,
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
                      SizedBox(
                        height: 24.h,
                      ),
                      formShowFtAddress(
                        // hintText: snapshot.data ?? '',
                        hintText: widget.walletAddress.formatAddressWallet(),
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
                                controller: txtToAddressToken,
                              ),
                            ),
                          ).then(
                            (_) =>
                            {
                              txtToAddressToken.text =
                                  tokenCubit.handleValueFromQR(
                                      value: txtToAddressToken.text),
                              tokenCubit.checkHaveVlAddressFormToken(
                                tokenCubit.handleValueFromQR(
                                    value: txtToAddressToken.text),
                                type: typeSend.SEND_TOKEN,
                              ),
                            }
                          );
                        },
                      ),
                      txtWaringAddress(),
                      SizedBox(
                        height: 16.h,
                      ),
                      formAmountFtQuantity(
                        modelToken: widget.modelToken,
                        hintText: S.current.amount,
                        isAmount: true,
                        isQuantity: false,
                        prefixImg: ImageAssets.ic_token,
                      ),
                      txtWaringAmount(),
                      SizedBox(
                        height: 353.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<bool>(
              stream: tokenCubit.isShowCFBlockChainStream,
              builder: (context, snapshot) {
                return GestureDetector(
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: snapshot.data ?? true,
                  ),
                  onTap: () async {
                    if (snapshot.data ?? false) {
                      //show warning if appear error
                      tokenCubit.checkValidAddress(txtToAddressToken.text);
                      tokenCubit.checkValidAmount(txtAmount.text);
                      await tokenCubit.getEstimateGas(
                        from: widget.walletAddress,
                        to: txtToAddressToken.text,
                        value: double.parse(
                          txtAmount.text,
                        ),
                        token: widget.modelToken,
                        context: context,
                      );
                      //check validate before go to next screen
                      if (tokenCubit.checkAddressFtAmount()) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return ConfirmBlockchainCategory(
                                modelToken: widget.modelToken,
                                nameWallet: widget.walletName,
                                nameTokenWallet: 'BNB',
                                balanceWallet: tokenCubit.balanceWallet,
                                typeConfirm: TYPE_CONFIRM.SEND_TOKEN,
                                addressFrom: widget.walletAddress,
                                addressTo: txtToAddressToken.text,
                                imageWallet: ImageAssets.symbol,
                                amount: double.parse(txtAmount.text),
                                nameToken: widget.modelToken.nameShortToken,
                                cubitCategory: tokenCubit,
                                gasPriceFirstFetch:
                                    tokenCubit.gasPrice / 1000000000,
                                gasFeeFirstFetch:
                                    (((tokenCubit.gasPrice / 1000000000) *
                                            tokenCubit.estimateGasFee) /
                                        1000000000),
                                gasLimitFirstFetch: tokenCubit.estimateGasFee,
                              );
                            },
                          ),
                        );
                      } else {
                        //nothing
                      }
                    } else {
                      //nothing
                    }
                  },
                );
              },
            ),
            spaceH38,
          ],
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
      // width: 343.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            tokenCubit.checkHaveVlAddressFormToken(
              value,
              type: typeSend.SEND_TOKEN,
            );
          },
          controller: readOnly ? null : txtToAddressToken,
          readOnly: readOnly,
          textAlignVertical: TextAlignVertical.center,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16,
          ),
          cursorColor: AppTheme.getInstance().textThemeColor(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: readOnly
                ? textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                    FontWeight.w400,
                  )
                : textNormal(
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
            prefixIcon: GestureDetector(
              onTap: callBack,
              child: ImageIcon(
                AssetImage(prefixImg),
                color: AppTheme.getInstance().textThemeColor(),
              ),
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
    ModelToken? modelToken,
    Function()? callBack,
  }) {
    return Container(
      height: 64.h,
      // width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            tokenCubit.checkHaveVLAmountFormToken(
              value,
              amountBalance: widget.modelToken.balanceToken,
            );
          },
          controller: txtAmount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlignVertical: TextAlignVertical.center,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              AppTheme.getInstance().disableColor(),
              14,
            ),
            suffixIcon: InkWell(
              onTap: callBack,
              child: (isAmount && !isQuantity)
                  ? InkWell(
                      onTap: () {
                        txtAmount.text =
                            modelToken!.balanceToken.toStringAsFixed(4);
                        tokenCubit.checkHaveVLAmountFormToken(
                          txtAmount.text,
                          amountBalance: widget.modelToken.balanceToken,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          // top: 15.h,
                          right: 15.w,
                        ),
                        child: SizedBox(
                          width: 55.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                S.current.max,
                                style: textNormal(
                                  const Color.fromRGBO(228, 172, 26, 1),
                                  16,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                              spaceW4,
                              SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: CircleAvatar(
                                  radius: 30.0.r,
                                  backgroundImage:
                                  NetworkImage(widget.modelToken.iconToken),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 15.h, right: 20.w),
                      child: Text(
                        '${S.current.of_all} 10',
                        style: textNormal(
                          const Color.fromRGBO(255, 255, 255, 1),
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
      stream: tokenCubit.isValidAddressFormStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  initialData: '',
                  stream: tokenCubit.txtInvalidAddressFormStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormalCustom(
                        const Color.fromRGBO(255, 108, 108, 1),
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

  Widget txtWaringAmount() {
    return StreamBuilder(
      initialData: false,
      stream: tokenCubit.isValidAmountFormStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  initialData: '',
                  stream: tokenCubit.txtInvalidAmountStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormalCustom(
                        const Color.fromRGBO(255, 108, 108, 1),
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

//sau la suffix
//truoc la prefix
}
