import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/hide_customize_fee.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/information_wallet.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/show_customize_fee.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmBlockchain extends StatefulWidget {
  const ConfirmBlockchain({
    required this.toAddress,
    required this.fromAddress,
    required this.amount,
    Key? key,
  }) : super(key: key);
  final String toAddress;
  final String fromAddress;
  final String amount;

  @override
  _ConfirmBlockchainState createState() => _ConfirmBlockchainState();
}

class _ConfirmBlockchainState extends State<ConfirmBlockchain> {
  late SendTokenCubit sendTokenCubit;
  late TextEditingController txtGasLimit;
  late TextEditingController txtGasPrice;
  late InformationWallet informationWallet;

  @override
  void initState() {
    informationWallet = const InformationWallet(
      nameWallet: 'Test wallet',
      fromAddress: '0xFE5...4fd0',
      amount: 0.551,
      nameToken: 'BNB',
      imgWallet: ImageAssets.hardCoreImgWallet,
    );
    sendTokenCubit = SendTokenCubit();
    txtGasLimit = TextEditingController();
    txtGasPrice = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    sendTokenCubit.dispose();
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormAddFtAmount(
                      from: widget.fromAddress,
                      to: widget.toAddress,
                      amount: '${widget.amount} DFY',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 26.w, right: 26.w),
                      child: const Divider(
                        thickness: 1,
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    informationWallet,
                    SizedBox(
                      height: 16.h,
                    ),
                    StreamBuilder(
                      stream: sendTokenCubit.isCustomizeFeeStream,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return snapshot.data ?? false
                            ? ShowCustomizeFee(
                                nameToken: 'BNB',
                                sendTokenCubit: sendTokenCubit,
                                txtGasPrice: txtGasPrice,
                                txtGasLimit: txtGasLimit,
                                balance : informationWallet.amount,
                              )
                            : HideCustomizeFee(
                                nameToken: 'BNB',
                                sendTokenCubit: sendTokenCubit,
                                balance: informationWallet.amount,
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: const ButtonGold(
                title: 'Approve',
                isEnable: true,
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }

  Padding header({required String nameToken}) {
    return Padding(
      padding:
          EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.back),
          ),
          SizedBox(
            width: 95.w,
          ),
          Text(
            'Send $nameToken',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
