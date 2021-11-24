import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/confirm_blockchain.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendToken extends StatefulWidget {
  const SendToken({Key? key}) : super(key: key);

  @override
  _SendTokenState createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  late SendTokenCubit tokenCubit;
  final String fakeFromAddress = '0xFE5788e2...EB7144fd0';
  late TextEditingController txtToAddressToken;
  late TextEditingController txtAmount;

  //todo truyen amount
  @override
  void initState() {
    super.initState();
    txtToAddressToken = TextEditingController();
    txtAmount = TextEditingController();
    tokenCubit = SendTokenCubit();

    trustWalletChannel.setMethodCallHandler(tokenCubit.nativeMethodCallHandler);
    tokenCubit.sendToken(
      walletAddress: tokenCubit.walletAddressToken,
      receiveAddress: tokenCubit.receiveAddressToken,
      tokenID: tokenCubit.tokenIDToken ?? 0,
      amount: tokenCubit.amountToken ?? 0,
      password: '',
      gasFee: 0,
    );
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
      child: Container(
        width: 375.w,
        height: 764.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(62, 61, 92, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          children: [
            header(nameToken: 'DFY'),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    formShowFtAddress(
                      // hintText: snapshot.data ?? '',
                      hintText: '0xFE5788e2...EB7144fd0',
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
                          (_) => tokenCubit.checkHaveVlAddressFormToken(
                            txtToAddressToken.text,
                            type: typeSend.SEND_TOKEN,
                          ),
                        );
                      },
                    ),
                    txtWaringAddress(),
                    SizedBox(
                      height: 16.h,
                    ),
                    formAmountFtQuantity(
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
            StreamBuilder<bool>(
              stream: tokenCubit.isShowCFBlockChainStream,
              builder: (context, snapshot) {
                return GestureDetector(
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: snapshot.data ?? true,
                  ),
                  onTap: () {
                    if (snapshot.data ?? false) {
                      //show warning if appear error
                      tokenCubit.checkValidAddress(txtToAddressToken.text);
                      tokenCubit.checkValidAmount(txtAmount.text);
                      //check validate before go to next screen
                      if (tokenCubit.checkAddressFtAmount()) {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => ConfirmBlockchain(
                            toAddress: txtToAddressToken.text,
                            fromAddress: fakeFromAddress,
                            amount: txtAmount.text,
                          ),
                          context: context,
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
            SizedBox(
              height: 34.h,
            ),
          ],
        ),
      ),
    );
  }

  //header
  Container header({required String nameToken}) {
    return Container(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 26.w,
        top: 16.h,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 121.w,
          ),
          Text(
            '${S.current.send} $nameToken',
            style: textNormalCustom(
              Colors.white,
              20,
              FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 94.w,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(ImageAssets.ic_close),
            ),
          )
        ],
      ),
    );
  }

  ConstrainedBox formShowFtAddress({
    required String hintText,
    bool readOnly = false,
    Function()? callBack,
    required String suffixImg,
    required String prefixImg,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 64.h,
      ),
      child: Container(
        width: 343.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: Color(0xff32324c),
        ),
        child: TextFormField(
          onChanged: (value) {
            tokenCubit.checkHaveVlAddressFormToken(
              value,
              type: typeSend.SEND_TOKEN,
            );
          },
          controller: readOnly ? null : txtToAddressToken,
          readOnly: readOnly,
          style: textNormal(
            Colors.white,
            16,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: readOnly
                ? textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w400,
                  )
                : textNormal(
                    Colors.grey,
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
                      color: Colors.white,
                    ),
            ),
            prefixIcon: GestureDetector(
              onTap: callBack,
              child: ImageIcon(
                AssetImage(prefixImg),
                color: Colors.white,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  ConstrainedBox formAmountFtQuantity({
    required String hintText,
    required bool isAmount,
    required bool isQuantity,
    required String prefixImg,
    Function()? callBack,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 64.h,
      ),
      child: Container(
        width: 343.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: Color(0xff32324c),
        ),
        child: TextFormField(
          onChanged: (value) {
            tokenCubit.checkHaveVLAmountFormToken(value);
            tokenCubit.checkHaveVlAddressFormToken(
              txtToAddressToken.text,
              type: typeSend.SEND_TOKEN,
            );
          },
          controller: txtAmount,
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          style: textNormal(
            Colors.white,
            16,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              14,
            ),
            suffixIcon: InkWell(
              onTap: callBack,
              child: (isAmount && !isQuantity)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        right: 20.w,
                      ),
                      child: Text(
                        S.current.max,
                        style: textNormal(
                                const Color.fromRGBO(228, 172, 26, 1), 16)
                            .copyWith(fontWeight: FontWeight.w600),
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
              color: Colors.white,
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
