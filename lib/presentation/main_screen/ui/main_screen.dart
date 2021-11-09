import 'package:Dfy/config/base/base_screen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/presentation/home/ui/home_screen.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';
import 'package:Dfy/presentation/pawn/ui/pawn_screen.dart';
import 'package:Dfy/presentation/staking/ui/staking_screen.dart';
import 'package:Dfy/presentation/wallet/ui/wallet_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/bottom_appbar.dart';
import 'package:Dfy/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';



const int tabWalletIndex = 0;
const int tabPawnIndex = 1;
const int tabHomeIndex = 2;
const int tabMarketingPlaceIndex = 3;
const int tabStakingIndex = 4;

class MainScreen extends BaseScreen {


  const MainScreen({Key? key})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

  static NavigatorState? of(BuildContext context, {int? tabIndex}) {
    final appScaffoldState =
        context.findAncestorStateOfType<_MainScreenState>();

    if (appScaffoldState != null) {
      final currentIndex = appScaffoldState.pageIndex;
      final navigatorKeys = appScaffoldState.navigatorKeys;

      if (tabIndex != null &&
          tabIndex != currentIndex &&
          appScaffoldState.mounted) {
        appScaffoldState.selectPage(tabIndex);
        return navigatorKeys[tabIndex].currentState;
      }

      return navigatorKeys[currentIndex].currentState;
    }
    return null;
  }
}

class _MainScreenState extends BaseState<MainScreen> {
  List<Widget> _pages = [];
  int pageIndex = 0;
  List<GlobalKey<NavigatorState>> navigatorKeys = <GlobalKey<NavigatorState>>[];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int lastDuration = 2;



  final CompositeSubscription compositeSubscription = CompositeSubscription();
  late MainCubit _cubit;

  @override
  void initState() {
     _handleEventBus();
    _cubit = MainCubit();
    _cubit.init();
    super.initState();
    _pages = [
      const LoginScreen(),
      const WalletScreen(),
      const WalletScreen(),
      const MarketPlaceScreen(),
      const LoginScreen(),
    ];
    navigatorKeys = List.generate(
      _pages.length,
      (_) => GlobalKey<NavigatorState>(),
    );
  }

  void _handleEventBus() {
    eventBus.on<OpenMainTabIndex>().listen((event) {
      selectPage(event.tabIndex);
    }).addTo(compositeSubscription);
  }

  @override
  void dispose() {
    compositeSubscription.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(ImageAssets.symbol), context);
    precacheImage(const AssetImage(ImageAssets.center), context);
    precacheImage(const AssetImage(ImageAssets.center), context);
    return Scaffold(
      key: scaffoldKey,

      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: _cubit.indexStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _pages.elementAt(snapshot.data ?? tabWalletIndex),
              CustomBottomHomeAppbar(
                mainCubit: _cubit,
              )
            ],
          );
        },
      ),
    );
  }

  void selectPage(int index) => setState(() {
        pageIndex = index;
      });
}
