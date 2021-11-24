import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/hide_customize_fee.dart';
import 'package:Dfy/presentation/send_token_nft/ui/confirm_blockchain/components/show_customize_fee.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_address_ft_amount.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/form_sale_ft_pawn.dart';
import 'package:Dfy/widgets/confirm_blockchain/components/information_wallet.dart';
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
  late double gasFeeFirstFetch;
  late double gasLimitFirstFetch;
  late double gasPriceFirstFetch;

  @override
  void initState() {
    gasPriceFirstFetch = 1.1;
    gasLimitFirstFetch = 0.624;
    gasFeeFirstFetch = 0.4;
    informationWallet = const InformationWallet(
      nameWallet: 'Test wallet',
      fromAddress: '0xFE5...4fd0',
      amount: 0.3,
      nameToken: 'BNB',
      imgWallet: ImageAssets.ic_symbol,
    );
    sendTokenCubit = SendTokenCubit();
    txtGasLimit = TextEditingController(text: gasLimitFirstFetch.toString());
    txtGasPrice = TextEditingController(text: gasPriceFirstFetch.toString());
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
      child: BaseBottomSheet(
        title: '${S.current.send} DFY',
        child: Column(
          children: [
            // spaceH24,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormAddFtAmount(
                      from: widget.fromAddress,
                      to: widget.toAddress,
                      amount: '${widget.amount} DFY',
                      typeForm: TypeIsHaveAmount.HAVE_AMOUNT,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    FormSaleFtPawn(
                      isPawnOrSale: IS_PAWN_OR_SALE.BUY,
                      loanAmount: 4,
                      loanToVl: 3,
                      quantity: 5,
                      pricePerOne: 5000.2,
                      totalPayment: 123123213,
                      interestRate: 5,
                      ltvLiquidThreshold: 10,
                      duration: 24,
                      repaymentCurrent: 'DFY',
                      recurringInterest: 'month',
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    informationWallet,
                    SizedBox(
                      height: 16.h,
                    ),
                    StreamBuilder(
                      initialData: gasFeeFirstFetch < informationWallet.amount,
                      stream: sendTokenCubit.isCustomizeFeeStream,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return snapshot.data ?? false
                            ? ShowCustomizeFee(
                                nameToken: 'BNB',
                                sendTokenCubit: sendTokenCubit,
                                txtGasPrice: txtGasPrice,
                                txtGasLimit: txtGasLimit,
                                balanceFirstFetch: informationWallet.amount,
                                gasFee: gasFeeFirstFetch,
                                gasLimitFirstFetch: gasLimitFirstFetch,
                                gasPriceFirstFetch: gasPriceFirstFetch,
                              )
                            : HideCustomizeFee(
                                nameToken: 'BNB',
                                sendTokenCubit: sendTokenCubit,
                                balance: informationWallet.amount,
                                gasFee: gasFeeFirstFetch,
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<bool>(
              initialData: gasFeeFirstFetch <= informationWallet.amount,
              stream: sendTokenCubit.isSufficientTokenStream,
              builder: (context, snapshot) {
                final isEnable = snapshot.data ?? false;
                return GestureDetector(
                  child: isEnable
                      ? ButtonGradient(
                          gradient: RadialGradient(
                            center: const Alignment(0.5, -0.5),
                            radius: 4,
                            colors:
                                AppTheme.getInstance().gradientButtonColor(),
                          ),
                          onPressed: () {},
                          child: Text(
                            S.current.approve,
                            style: textNormal(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                            ),
                          ),
                        )
                      : ErrorButton(
                          child: Center(
                            child: Text(
                              S.current.approve,
                              style: textNormal(
                                AppTheme.getInstance().textThemeColor(),
                                20,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            spaceH38,
          ],
        ),
      ),
    );
  }

  Padding header({required String nameToken}) {
    return Padding(
      padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),
          SizedBox(
            width: 95.w,
          ),
          Text(
            '${S.current.send} $nameToken',
            style: textNormalCustom(
              Colors.white,
              20,
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
