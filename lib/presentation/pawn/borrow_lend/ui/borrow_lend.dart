import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/bloc/borrow_lend_bloc.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/ui/select_type.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/borrow_result.dart';
import 'package:Dfy/presentation/pawn/collateral_nft_result/ui/collateral_result_nft.dart';
import 'package:Dfy/presentation/pawn/collateral_result/ui/collateral_result.dart';
import 'package:Dfy/presentation/pawn/home_pawn/bloc/home_pawn_cubit.dart';
import 'package:Dfy/presentation/pawn/personal_lending_hard/ui/personal_lending_hard.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'borrow_item.dart';

class BorrowLendScreen extends StatefulWidget {
  final TYPE_BORROW_OR_LEND type;

  const BorrowLendScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _BorrowLendScreenState createState() => _BorrowLendScreenState();
}

class _BorrowLendScreenState extends State<BorrowLendScreen> {
  late BorrowLendBloc _bloc;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BorrowLendBloc();
    _bloc.getTokenInf();
    if (widget.type == TYPE_BORROW_OR_LEND.LEND) {
      index = 1;
    } else {
      index = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      text: ImageAssets.ic_close,
      title: index == 0 ? S.current.borrow : S.current.lend,
      onRightClick: () {
        Navigator.pop(context);
      },
      isImage: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              if (index == 0) GestureDetector(
                      onTap: () {
                        final FocusScopeNode currentFocus =
                            FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _bloc.isChooseToken.add(false);
                      },
                      child: SingleChildScrollView(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 20.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.current.what_you_can_borrow,
                                    style: textNormalCustom(
                                      null,
                                      20,
                                      FontWeight.w700,
                                    ),
                                  ),
                                  spaceH20,
                                  Text(
                                    S.current.what_is_your_collateral,
                                    style: textNormalCustom(
                                      null,
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                  spaceH16,
                                  SelectType(
                                    bloc: _bloc,
                                  ),
                                  StreamBuilder<TypeLend>(
                                    stream: _bloc.typeScreen,
                                    builder: (context, snapshot) {
                                      return SizedBox(
                                        child: snapshot.data == TypeLend.CRYPTO
                                            ? BorrowItem(
                                                bloc: _bloc,
                                              )
                                            : const SizedBox.shrink(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) else Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.what_you_can_lend,
                            style: textNormalCustom(
                              null,
                              20,
                              FontWeight.w700,
                            ),
                          ),
                          spaceH20,
                          Text(
                            S.current.what_is_your_collateral,
                            style: textNormalCustom(
                              null,
                              16,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH16,
                          SelectType(
                            bloc: _bloc,
                          ),
                        ],
                      ),
                    ),
              spaceH40,
            ],
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: _bloc.isChooseToken,
            builder: (ctx, snapshot) {
              return Visibility(
                visible: snapshot.data ?? false,
                child: Positioned(
                  top: 450.h,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().colorTextReset(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    width: 343.w,
                    height: 123.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _bloc.listToken.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _bloc.chooseAddressFilter(
                              _bloc.listToken[index],
                            );
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                            ),
                            color: _bloc.listToken[index] ==
                                    _bloc.tokenSymbol.value
                                ? AppTheme.getInstance()
                                    .whiteColor()
                                    .withOpacity(0.3)
                                : Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: _bloc.listToken[index].toUpperCase() ==
                                          S.current.all.toUpperCase()
                                      ? const SizedBox.shrink()
                                      : Image.network(
                                          ImageAssets.getSymbolAsset(
                                            _bloc.listToken[index]
                                                .toUpperCase(),
                                          ),
                                          height: 24.w,
                                          width: 24.w,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) =>
                                              Container(
                                            height: 24.w,
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .bgBtsColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                _bloc.listToken[index]
                                                    .toUpperCase()
                                                    .substring(
                                                      0,
                                                      1,
                                                    ),
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                spaceW4,
                                Text(
                                  _bloc.listToken[index] == S.current.all
                                      ? S.current.all.toUpperCase()
                                      : _bloc.listToken[index].toUpperCase(),
                                  style: textNormalCustom(
                                    null,
                                    16,
                                    null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 38.h,
            ),
            color: AppTheme.getInstance().bgBtsColor(),
            child: GestureDetector(
              onTap: () {
                if (index == 0) {
                  if (_bloc.typeScreen.value == TypeLend.CRYPTO) {
                    if (_bloc.isAmount.value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BorrowResult(
                                  nameToken: _bloc.tokenSymbol.value,
                                ),
                            settings: const RouteSettings(
                              name: AppRouter.borrow_result,
                            )),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BorrowResult(
                            nameToken: _bloc.tokenSymbol.value,
                            amount: _bloc.textAmount.value,
                          ),
                          settings: const RouteSettings(
                            name: AppRouter.borrow_result,
                          ),
                        ),
                      );
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalLendingHardScreen(),
                      ),
                    );
                  }
                } else {
                  if (_bloc.typeScreen.value == TypeLend.CRYPTO) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CollateralResultScreen(),
                        settings: const RouteSettings(
                          name: AppRouter.collateral_result,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CollateralResultNFTScreen(),
                      ),
                    );
                  }
                }
              },
              child: ButtonGold(
                title: S.current.continue_s,
                isEnable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
