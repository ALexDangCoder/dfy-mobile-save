import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/confirm_blockchain.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
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
                    prefixImg: ImageAssets.from,
                    suffixImg: '',
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  formShowFtAddress(
                    hintText: 'To address',
                    callBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              QRViewExample(
                                controller: txtToAddress,
                              ),
                        ),
                      );
                    },
                    suffixImg: ImageAssets.code,
                    prefixImg: ImageAssets.to,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  formAmountFtQuantity(
                    hintText: 'Quantity',
                    isAmount: true,
                    isQuantity: true,
                    prefixImg: ImageAssets.quantity,
                  ),
                  SizedBox(
                    height: 353.h,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: StreamBuilder<bool>(
                stream: sendNftCubit.isShowCFBlockChainStream,
                builder: (context, snapshot) {
                  return ButtonGold(
                    title: 'Continue',
                    isEnable: snapshot.data ?? false,
                  );
                }
            ),
            onTap: () {
              if (txtToAddress.text.isNotEmpty && txtQuantity.text.isNotEmpty) {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) =>
                      ConfirmBlockchain(
                        toAddress: txtToAddress.text,
                        fromAddress: '0xxxxasdasdasd',
                        amount: txtQuantity.text,
                      ),
                  context: context,
                );
              } else {
                //nothing
              }
            },
          ),
          SizedBox(
            height: 34.h,
          ),
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
      constraints: BoxConstraints(minHeight: 64.h),
      child: Container(
        width: 323.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xff32324c),
        ),
        child: TextFormField(
          controller: readOnly ? null : txtToAddress,
          onChanged: (value) {
            if (txtQuantity.text.isNotEmpty && value.isNotEmpty) {
              sendNftCubit.isShowConfirmBlockChain(
                isHaveFrAddress: true,
                isHaveAmount: true,
              );
            } else {
              sendNftCubit.isShowConfirmBlockChain(
                isHaveFrAddress: false,
                isHaveAmount: false,
              );
            }
          },
          readOnly: readOnly,
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: readOnly
                ? TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            )
                : textNormal(
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
        width: 323.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xff32324c),
        ),
        child: TextFormField(
          onChanged: (value) {
            if (txtToAddress.text.isNotEmpty && value.isNotEmpty) {
              sendNftCubit.isShowConfirmBlockChain(
                isHaveAmount: true,
                isHaveFrAddress: true,
              );
            } else {
              sendNftCubit.isShowConfirmBlockChain(
                isHaveFrAddress: false, isHaveAmount: false,);
            }
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
                  top: 18.h,
                ),
                child: Text(
                  'Max',
                  style: TextStyle(
                    color: const Color.fromRGBO(228, 172, 26, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              )
                  : Padding(
                padding: EdgeInsets.only(
                  top: 18.h,
                ),
                child: Text(
                  'of 10',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
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

  Padding header({required String nameSend}) {
    return Padding(
      padding:
      EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          SizedBox(
            width: 121.w,
          ),
          Text(
            'Send $nameSend',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
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
              icon: Image.asset('assets/images/Group.png'),
            ),
          )
        ],
      ),
    );
  }
}
