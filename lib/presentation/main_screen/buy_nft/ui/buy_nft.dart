import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/buy_nft/bloc/buy_nft_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_without_prefix.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyNFT extends StatefulWidget {
  const BuyNFT({
    Key? key,
    required this.balance,
  }) : super(key: key);
  final double balance;

  @override
  _BuyNFTState createState() => _BuyNFTState();
}

class _BuyNFTState extends State<BuyNFT> {
  late BuyNftCubit cubit;
  late TextEditingController txtQuantity;
  final NftMarket nftMarket = nftKey.currentState!.bloc.nftMarket;
  final _nftBloc = nftKey.currentState!.bloc;

  @override
  void initState() {
    super.initState();
    cubit = BuyNftCubit();
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
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: BlocListener(
            bloc: _nftBloc,
            listener: (context, state) {
              if (state is GetGasLimitSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Approve(
                      title: S.current.buy_nft,
                      textActiveButton: S.current.buy_nft,
                      approve: () {},
                      action: () {},
                      gasLimit: double.parse(state.gasLimit),
                    ),
                  ),
                );
              }
            },
            child: StateStreamLayout(
              stream: _nftBloc.stateStream,
              error:
                  AppException(S.current.error, S.current.something_went_wrong),
              retry: () async {},
              textEmpty: '',
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
                                      AppTheme.getInstance().textThemeColor(),
                                      14.sp,
                                      FontWeight.w400,
                                    ),
                                  ),
                                  spaceH4,
                                  FormWithOutPrefix(
                                    hintText: S.current.enter_quantity,
                                    typeForm:
                                        TypeFormWithoutPrefix.IMAGE_FT_TEXT,
                                    cubit: BuyNftCubit,
                                    txtController: txtQuantity,
                                    quantityOfAll: nftMarket.totalCopies,
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
                                    '${S.current.your_balance} ${widget.balance} DFY',
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
                        _nftBloc.callWeb3(context);
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
            AppTheme.getInstance().textThemeColor(),
            16.sp,
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
                  '${nftMarket.price}DFY',
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    20.sp,
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
                AppTheme.getInstance().textThemeColor(),
                16.sp,
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
                    '${nftMarket.price} DFY',
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16.sp,
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
