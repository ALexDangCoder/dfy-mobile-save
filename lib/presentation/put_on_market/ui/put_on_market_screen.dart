import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/presentation/put_on_market/ui/auction_tab.dart';
import 'package:Dfy/presentation/put_on_market/ui/pawn_tab.dart';
import 'package:Dfy/presentation/put_on_market/ui/sale_tab.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PutOnMarketScreen extends StatefulWidget {
  final bool? canSetQuantity;
  final int? quantity;
  final PutOnMarketModel putOnMarketModel;

  const PutOnMarketScreen({
    Key? key,
    this.canSetQuantity = false,
    this.quantity = 1,
    required this.putOnMarketModel,
  }) : super(key: key);

  @override
  _PutOnMarketScreenState createState() => _PutOnMarketScreenState();
}

class _PutOnMarketScreenState extends State<PutOnMarketScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final PutOnMarketCubit cubit = PutOnMarketCubit();

  final List<Tab> titTab = [
    Tab(
      text: S.current.sell,
    ),
    Tab(
      text: S.current.pawn,
    ),
    Tab(
      text: S.current.auction,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getListToken();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      final FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cubit.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: StateStreamLayout(
        stream: cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () async {
          await cubit.getListToken();
        },
        textEmpty: '',
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 48),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                header(),
                Divider(
                  thickness: 1,
                  color: AppTheme.getInstance().divideColor(),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.white,
                            unselectedLabelColor:
                                AppTheme.getInstance().titleTabColor(),
                            indicatorColor:
                                AppTheme.getInstance().titleTabColor(),
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: titTab,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SaleTab(
                                cubit: cubit,
                                putOnMarketModel: widget.putOnMarketModel,
                              ),
                              PawnTab(
                                putOnMarketModel: widget.putOnMarketModel,
                                cubit: cubit,
                              ),
                              AuctionTab(
                                cubit: cubit,
                                putOnMarketModel: widget.putOnMarketModel,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container header() {
    return Container(
      width: 343,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 26.w,),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),

          Text(
            S.current.put_on_market,
            style: textNormal(AppTheme.getInstance().textThemeColor(), 20)
                .copyWith(fontWeight: FontWeight.w700),
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
}
