import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/bloc/pawn_list_bloc.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/filter_pawn.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/pawn_shop_item.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_filter.dart';
import 'item_header_filter.dart';

class PawnList extends StatefulWidget {
  const PawnList({Key? key}) : super(key: key);

  @override
  _PawnListState createState() => _PawnListState();
}

class _PawnListState extends State<PawnList> {
  late PawnListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PawnListBloc();
    _bloc.getListPawn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: 764.h,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                        ),
                        width: 28.w,
                        height: 28.h,
                        child: Image.asset(
                          ImageAssets.ic_back,
                        ),
                      ),
                    ),
                    Text(
                      S.current.pawnshop_list,
                      style: textNormalCustom(
                        null,
                        20.sp,
                        FontWeight.w700,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => FilterPawn(
                            bloc: _bloc,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_filter),
                      ),
                    ),
                  ],
                ),
                spaceH20,
                line,
                spaceH24,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final res = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DialogFilter(
                                  title: S.current.rating,
                                  type: _bloc.typeRating ??
                                      TypeFilter.HIGH_TO_LOW,
                                );
                              },
                            ),
                          );
                          if (res != null) {
                            _bloc.typeRating = res;
                            //todo filter
                          }
                        },
                        child: ItemHeaderFilter(
                          title: S.current.rating,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final res = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DialogFilter(
                                  title: S.current.interest_rate_pawn,
                                  type: _bloc.typeInterest ??
                                      TypeFilter.HIGH_TO_LOW,
                                );
                              },
                            ),
                          );
                          if (res != null) {
                            _bloc.typeInterest = res;
                            //todo filter
                          }
                        },
                        child: ItemHeaderFilter(
                          title: S.current.interest_rate_pawn,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final res = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DialogFilter(
                                  title: S.current.signed_contracts,
                                  type: _bloc.typeSigned ??
                                      TypeFilter.HIGH_TO_LOW,
                                );
                              },
                            ),
                          );
                          if (res != null) {
                            _bloc.typeSigned = res;
                            //todo filter
                          }
                        },
                        child: ItemHeaderFilter(
                          title: S.current.signed_contracts,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH20,
                StreamBuilder<List<PawnShopModel>>(
                    stream: _bloc.list,
                    builder: (context, snapshot) {
                      final list = snapshot.data ?? [];
                      return Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              bottom: 20.h,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) => PawnItem(
                              rate: list[index].reputation.toString(),
                              total: list[index].totalValue.toString(),
                              imageAvatar: ApiConstants.BASE_URL_IMAGE +
                                  list[index].avatar.toString(),
                              //todo avatar
                              interestRate: '${list[index].interest}%',
                              imageCover: ApiConstants.BASE_URL_IMAGE +
                                  list[index].avatar.toString(),
                              nameShop: list[index].name.toString(),
                              loadToken: list[index].loanToken ?? [],
                              availableLoan:
                                  list[index].availableLoanPackage.toString(),
                              collateral: list[index].collateralAccepted ?? [],
                              isShop: list[index].isKYC ?? false,
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
