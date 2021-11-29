import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/buy_nft/bloc/buy_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_without_prefix.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyNFT extends StatefulWidget {
  const BuyNFT({Key? key}) : super(key: key);

  @override
  _BuyNFTState createState() => _BuyNFTState();
}

class _BuyNFTState extends State<BuyNFT> {
  late BuyNftCubit cubit;
  late TextEditingController txtQuantity;
  int fakeQuantityFetch = 10;
  late double balanceDFYFetch;
  late double pricePer1Fetch;

  @override
  void initState() {
    super.initState();
    cubit = BuyNftCubit();
    txtQuantity = TextEditingController();
    balanceDFYFetch = 125214.36;
    pricePer1Fetch = 10000.25;
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
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: BaseBottomSheet(
            isImage: true,
            text: ImageAssets.ic_close,
            title: '${S.current.buy} NFT',
            child: Column(
              children: [
                spaceH24,
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.quantity,
                                style: textNormalCustom(
                                  Colors.white,
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH4,
                              FormWithOutPrefix(
                                hintText: S.current.enter_quantity,
                                typeForm: TypeFormWithoutPrefix.IMAGE_FT_TEXT,
                                cubit: BuyNftCubit,
                                txtController: txtQuantity,
                                quantityOfAll: fakeQuantityFetch,
                                imageAsset: ImageAssets.ic_symbol,
                                isTokenOrQuantity: false,
                              ),
                              spaceH20,
                              pricePerOne(),
                              spaceH12,
                              divider,
                              spaceH12,
                              showTotalPayment(),
                              spaceH4,
                              Text(
                                '${S.current.your_balance} $balanceDFYFetch DFY',
                                style: textNormalCustom(
                                  Colors.white.withOpacity(0.7),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 300.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return const ConfirmBlockchainCategory(
                          nameWallet: 'Test wallet',
                          nameTokenWallet: 'BNB',
                          balanceWallet: 0.551,
                          typeConfirm: TYPE_CONFIRM.BUY_NFT,
                          addressFrom: '0xFE5788e2...EB7144fd0',
                          addressTo: '0xf94138c9...43FE932eA',
                          imageWallet: ImageAssets.symbol,
                        );
                      },
                      context: context,
                    );
                  },
                  child: ButtonGold(
                    title: '${S.current.buy} NFT',
                    isEnable: true,
                  ),
                ),
                spaceH38,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row showTotalPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.current.total_payment_upper,
          style: textNormalCustom(
            Colors.white,
            16,
            FontWeight.w600,
          ),
        ),
        Wrap(
          children: [
            Row(
              children: [
                circularImage(
                  ImageAssets.ic_symbol,
                  height: 20,
                  width: 20,
                ),
                spaceW4,
                Text(
                  '$pricePer1Fetch DFY',
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  ConstrainedBox pricePerOne() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              S.current.price_per_1,
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w400,
              ),
            ),
          ),
          Wrap(
            children: [
              Row(
                children: [
                  circularImage(
                    ImageAssets.ic_symbol,
                    height: 20,
                    width: 20,
                  ),
                  spaceW4,
                  Text(
                    '$pricePer1Fetch DFY',
                    style: textNormalCustom(
                      Colors.white,
                      16,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
