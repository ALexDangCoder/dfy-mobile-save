import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/history_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/nft_detail_on_auction.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/offer_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/owner_tab.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/bloc/nft_pawn_bloc.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/send_offer/send_offer.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnPawn extends StatefulWidget {
  const OnPawn({Key? key}) : super(key: key);

  @override
  _OnPawnState createState() => _OnPawnState();
}

class _OnPawnState extends State<OnPawn> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PawnBloc _bloc;
  final List<Widget> tabPage = const [
    HistoryTab(
      listHistory: [],
    ),
    OwnerTab(),
    OfferTab(),
  ];
  final List<Tab> titTab = [
    Tab(
      child: Text(
        S.current.history,
        style: textNormalCustom(
          AppTheme.getInstance().titleTabColor(),
          14,
          FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        S.current.owner,
        style: textNormalCustom(
          AppTheme.getInstance().titleTabColor(),
          14,
          FontWeight.w600,
        ),
      ),
    ), Tab(
      child: Text(
        S.current.offer,
        style: textNormalCustom(
          AppTheme.getInstance().titleTabColor(),
          14,
          FontWeight.w600,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bloc = PawnBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCustomScrollView(
      bottomBar: _buildButtonSendOffer(context),
      title: EXAMPLE_TITLE,
      image: EXAMPLE_IMAGE_URL,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: roundButton(image: ImageAssets.ic_btn_back_svg),
        ),
      ),
      initHeight: 360.h,
      content: [
        _cardTitle(title: EXAMPLE_TITLE),
        _priceContainer(),
        spaceH14,
        _durationRow(),
        spaceH14,
        divide,
        spaceH12,
        _description(
          'Pharetra etiam libero erat in sit risus at vestibulum nulla. Cras enim nulla neque mauris. Mollis eu lorem '
          'lectus egestas maecenas mattis id convallis imperdiet.`',
        ),
        spaceH20,
        StreamBuilder<bool>(
          initialData: false,
          stream: _bloc.viewStream,
          builder: (context, snapshot) {
            return Visibility(
              visible: !snapshot.data!,
              child: Column(
                children: [
                  _rowCollection('DFY', 'BDA collection', true),
                  spaceH20,
                  additionalColumn(),
                  spaceH20,
                  _buildTable(),
                  spaceH12,
                ],
              ),
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: true,
          stream: _bloc.viewStream,
          builder: (context, snapshot) {
            return Visibility(
              child: InkWell(
                onTap: () {
                  _bloc.viewSink.add(!snapshot.data!);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                  ),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sizedSvgImage(
                        w: 14,
                        h: 14,
                        image: !snapshot.data!
                            ? ImageAssets.ic_collapse_svg
                            : ImageAssets.ic_expand_svg,
                      ),
                      SizedBox(
                        width: 13.15.w,
                      ),
                      Text(
                        !snapshot.data!
                            ? S.current.view_less
                            : S.current.view_more,
                        style: textNormalCustom(
                          AppTheme.getInstance().fillColor(),
                          16.sp,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        divide,
      ],
      tabBar: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.getInstance().titleTabColor(),
        indicatorColor: AppTheme.getInstance().titleTabColor(),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        tabs: titTab,
      ),
      tabBarView: TabBarView(
        controller: _tabController,
        children: tabPage,
      ),
    );
  }

  Widget _buildButtonSendOffer(BuildContext context) {
    return ButtonGradient(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const SendOffer();
            },
          ),
        );
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: Text(
        S.current.send_offer,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    );
  }

  Widget _description(String des) {
    return Text(
      des,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        14,
        FontWeight.w400,
      ),
    );
  }

  Widget _cardTitle({required String title, int quantity = 1}) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  EXAMPLE_TITLE,
                  style: textNormalCustom(null, 24, FontWeight.w600),
                ),
              ),
              //todo when has feature backend
              // SizedBox(
              //   width: 25.h,
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: roundButton(
              //     image: ImageAssets.ic_flag_svg,
              //     whiteBackground: true,
              //   ),
              // ),
              // SizedBox(
              //   width: 20.h,
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: roundButton(
              //     image: ImageAssets.ic_share_svg,
              //     whiteBackground: true,
              //   ),
              // ),
            ],
          ),
          Text(
            '1 of $quantity available',
            textAlign: TextAlign.left,
            style: tokenDetailAmount(
              fontSize: 16,
            ),
          ),
          spaceH12,
          line,
        ],
      ),
    );
  }

  Widget additionalColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.additional,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w600,
          ),
        ),
        spaceH14,
        Wrap(
          spacing: 12.w,
          runSpacing: 8.h,
          children: List.generate(
            10,
            (index) => SizedBox(
              height: 50.h,
              child: Chip(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color:
                        AppTheme.getInstance().divideColor().withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor: AppTheme.getInstance().bgBtsColor(),
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'tag $index',
                      textAlign: TextAlign.left,
                      style: textNormalCustom(
                        AppTheme.getInstance()
                            .textThemeColor()
                            .withOpacity(0.7),
                        12,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH4,
                    Text(
                      '${index * index * 10000}',
                      textAlign: TextAlign.left,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        14,
                        FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTable() => Column(
        children: [
          buildRow(
            title: S.current.collection_address,
            detail: '0xfd223fafw3839399202020d0w9dannac82nfajs2882fba',
            type: TextType.RICH_BLUE,
            isShowCopy: true,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_id,
            detail: '101033',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.contract,
            detail: '0xffffadakakdwqiacmaciqwmcacmiacmaciwcmascmia',
            type: TextType.RICH_BLUE,
            isShowCopy: true,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_standard,
            detail: 'ERC-721',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.block_chain,
            detail: 'Binance Smart chain',
            type: TextType.NORMAL,
          ),
        ],
      );

  Widget _rowCollection(String symbol, String collectionName, bool verify) {
    return Row(
      children: [
        SizedBox(
          height: 28.h,
          width: 28.w,
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            radius: 18.r,
            child: Center(
              child: Text(
                symbol.substring(0, 1),
                style: textNormalCustom(
                  Colors.black,
                  20,
                  FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          collectionName,
          style: textNormalCustom(
            Colors.white,
            16,
            FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        if (verify) ...[
          sizedSvgImage(w: 16.w, h: 16.h, image: ImageAssets.ic_verify_svg)
        ]
      ],
    );
  }

  Row _durationRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.duration,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              14,
              FontWeight.normal,
            ),
          ),
          Text(
            '12 ${S.current.month}',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
            ),
          ),
        ],
      );

  Container _priceContainer() => Container(
        width: 343.w,
        height: 50.h,
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.expected_loan,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                14,
                FontWeight.normal,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    sizedSvgImage(
                      w: 20,
                      h: 20,
                      image: ImageAssets.ic_token_dfy_svg,
                    ),
                    spaceW4,
                    Text(
                      '30,000 DFY',
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    '~100,000,000',
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                      14,
                      FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
