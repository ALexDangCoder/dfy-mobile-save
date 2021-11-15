import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/confirm_blockchain.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendNft extends StatefulWidget {
  const SendNft({Key? key}) : super(key: key);

  @override
  _SendNftState createState() => _SendNftState();
}

class _SendNftState extends State<SendNft> {
  late TextEditingController txtToAddress;
  late TextEditingController txtQuantity;
  late SendTokenCubit sendNftCubit;
  final String fakeFromAddress = '0xFE5788e2...EB7144fd0';

  @override
  void initState() {
    super.initState();
    sendNftCubit = SendTokenCubit();
    txtToAddress = TextEditingController();
    txtQuantity = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          header(nameSend: 'NFT'),
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
                    callBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => QRViewExample(
                            controller: txtToAddress,
                          ),
                        ),
                      );
                    },
                    suffixImg: ImageAssets.ic_qr_code,
                    prefixImg: ImageAssets.ic_to,
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
          StreamBuilder<bool>(
            stream: sendNftCubit.isShowCFBlockChainStream,
            builder: (context, snapshot) {
              return GestureDetector(
                child: ButtonGold(
                  title: S.current.continue_s,
                  isEnable: snapshot.data ?? false,
                ),
                onTap: () {
                  if (snapshot.data ?? false) {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => ConfirmBlockchain(
                        toAddress: txtToAddress.text,
                        fromAddress: fakeFromAddress,
                        amount: txtQuantity.text,
                      ),
                      context: context,
                    );
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
      width: 323.w,
      // padding: EdgeInsets.only(
      //   top: 12.h,
      //   bottom: 12.h,
      // ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: TextFormField(
          controller: readOnly ? null : txtToAddress,
          onChanged: (value) {
            sendNftCubit.checkValidAddress(value);
          },
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          cursorColor: Colors.white,
          // controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              14.sp,
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
              padding: EdgeInsets.only(top: 0.h,),
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
      width: 323.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 0.h),
        child: TextFormField(
          onChanged: (value) {
            //todo
            sendNftCubit.checkValidQuantity(value);
          },
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          controller: txtQuantity,
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              14.sp,
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
                      padding: EdgeInsets.only(
                        top: 20.h,
                        right: 20.w
                      ),
                      child: Text(
                        '${S.current.of_all} 10',
                        style: textNormal(
                                const Color.fromRGBO(255, 255, 255, 1), 16)
                            .copyWith(fontWeight: FontWeight.w400),
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
      ),
    );
  }

  Container header({required String nameSend}) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${S.current.send} $nameSend',
            style: textNormal(Colors.white, 20.sp)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 110.w,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_close),
          ),
        ],
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
                          12.sp,
                          FontWeight.w400,
                        ),
                      );
                    }),
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
                        12.sp,
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
