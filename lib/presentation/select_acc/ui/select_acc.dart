import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/remove_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeScreen2 { setting, detail }

void showSelectAcc(
  BuildContext context,
  WalletCubit bloc,
  TypeScreen2 typeScreen2,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SelectAcc(
        bloc: bloc,
        typeScreen2: typeScreen2,
      );
    },
  );
}

class SelectAcc extends StatefulWidget {
  final WalletCubit bloc;
  final TypeScreen2 typeScreen2;

  const SelectAcc({Key? key, required this.bloc, required this.typeScreen2})
      : super(key: key);

  @override
  _SelectAccState createState() => _SelectAccState();
}

class _SelectAccState extends State<SelectAcc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28.h,
            width: 343.w,
            margin: EdgeInsets.only(right: 26.w, left: 16.w, top: 16.h),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Image.asset(
                      ImageAssets.ic_back,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 70.w),
                  child: Text(
                    S.current.select_acc,
                    style: textNormalCustom(
                      Colors.white,
                      20.sp,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          spaceH20,
          line,
          StreamBuilder(
            stream: widget.bloc.list,
            builder: (context, AsyncSnapshot<List<AccountModel>> snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.bloc.addressWallet.sink
                            .add(snapshot.data?[index].addressWallet ?? '');
                        widget.bloc.walletName.sink
                            .add(snapshot.data?[index].nameWallet ?? '');
                        widget.bloc.click(index);
                        if (widget.typeScreen2 == TypeScreen2.detail) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      onLongPress: () {
                        Navigator.of(context).push(
                          HeroDialogRoute(
                            builder: (context) {
                              return RemoveAcc(
                                bloc: widget.bloc,
                                index: index,
                              );
                            },
                            isNonBackground: false,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        height: 74.h,
                        width: 357.w,
                        padding: EdgeInsets.only(
                          left: 15.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 40.h,
                                      width: 40.w,
                                      child: Image.asset(
                                        snapshot.data?[index].url ?? '',
                                      ),
                                    ),
                                    spaceW8,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data?[index]
                                                      .nameWallet ??
                                                  '',
                                              style: textNormalCustom(
                                                null,
                                                16.sp,
                                                FontWeight.w700,
                                              ),
                                            ),
                                            spaceW4,
                                            Text(
                                              widget.bloc.formatAddress(
                                                snapshot.data?[index]
                                                        .addressWallet ??
                                                    '',
                                              ),
                                              style: textNormalCustom(
                                                AppTheme.getInstance()
                                                    .whiteWithOpacityFireZero(),
                                                14.sp,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${snapshot.data?[index].amountWallet?.toStringAsFixed(5)} BNB',
                                          style: textNormalCustom(
                                            null,
                                            16.sp,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: snapshot.data?[index].imported ??
                                              false
                                          ? Container(
                                              width: 65.w,
                                              height: 22.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(6.r),
                                                ),
                                                border: Border.all(
                                                  color: AppTheme.getInstance()
                                                      .whiteWithOpacityFireZero(),
                                                  width: 1.h,
                                                ),
                                              ),
                                              child: Align(
                                                child: Text(
                                                  S.current.import,
                                                  style: textNormal(
                                                    AppTheme.getInstance()
                                                        .whiteWithOpacityFireZero(),
                                                    11.sp,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 65.w,
                                              height: 22.h,
                                            ),
                                    ),
                                    spaceW10,
                                    Container(
                                      child:
                                          snapshot.data?[index].isCheck ?? false
                                              ? Image.asset(
                                                  ImageAssets.ic_selected,
                                                  width: 24.w,
                                                  height: 24.h,
                                                )
                                              : SizedBox(
                                                  width: 24.w,
                                                ),
                                    ),
                                    spaceW5,
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
