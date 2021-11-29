import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendNft extends StatefulWidget {
  const SendNft({Key? key}) : super(key: key);

  @override
  _SendNftState createState() => _SendNftState();
}

class _SendNftState extends State<SendNft> {
  late TextEditingController txtToAddressNft;
  late TextEditingController txtQuantity;
  late SendTokenCubit sendNftCubit;
  final String fakeFromAddress = '0xFE5788e2...EB7144fd0';
  int maxQuantityFirstFetch = 10;

  @override
  void initState() {
    super.initState();
    sendNftCubit = SendTokenCubit();
    txtToAddressNft = TextEditingController();
    txtQuantity = TextEditingController();
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
        text: ImageAssets.ic_close,
        isImage: true,
        isHaveLeftIcon: false,
        title: S.current.send_nft,
        callback: () {
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
                        hintText: '0xf94138c9...43FE932eA',
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
                            (_) => sendNftCubit.checkHaveVlAddressFormToken(
                              txtToAddressNft.text,
                              type: typeSend.SEND_NFT,
                            ),
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
                  onTap: () {
                    if (snapshot.data ?? false) {
                      sendNftCubit.checkValidAddress(txtToAddressNft.text);
                      sendNftCubit.checkValidQuantity(txtQuantity.text,
                          quantityFirstFetch: maxQuantityFirstFetch);
                      if (sendNftCubit.checkAddressFtQuantity()) {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => const ConfirmBlockchainCategory(
                            nameWallet: 'TestWallet',
                            nameTokenWallet: 'BNB',
                            balanceWallet: 0.64,
                            typeConfirm: TYPE_CONFIRM.SEND_NFT,
                            addressFrom: '0xfff',
                            addressTo: '0xfff',
                            imageWallet: ImageAssets.symbol,
                            amount: 5000,
                            nameToken: 'BNB',
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: Center(
        child: TextFormField(
          controller: readOnly ? null : txtToAddressNft,
          onChanged: (value) {
            sendNftCubit.checkHaveVlAddressFormToken(
              value,
              type: typeSend.SEND_NFT,
            );
          },
          style: textNormal(
            Colors.white,
            16,
          ),
          cursorColor: Colors.white,
          // controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
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
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                top: 0.h,
              ),
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: TextFormField(
        onChanged: (value) {
          sendNftCubit.checkHaveVLQuantityFormNFT(value);
          sendNftCubit.checkHaveVlAddressFormToken(
            txtToAddressNft.text,
            type: typeSend.SEND_NFT,
          );
        },
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        controller: txtQuantity,
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
                    padding: EdgeInsets.only(top: 20.h, right: 20.w),
                    child: Text(
                      '${S.current.of_all} $maxQuantityFirstFetch',
                      style: textNormal(
                        const Color.fromRGBO(255, 255, 255, 1),
                        16,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ImageIcon(
              AssetImage(prefixImg),
              color: Colors.white,
            ),
          ),
          border: InputBorder.none,
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
}
