import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/account_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/dialog_remove/remove_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeScreen2 { setting, detail }

class SelectAcc extends StatefulWidget {
  final WalletCubit bloc;
  final TypeScreen2 typeScreen2;

  const SelectAcc({
    Key? key,
    required this.bloc,
    required this.typeScreen2,
  }) : super(key: key);

  @override
  _SelectAccState createState() => _SelectAccState();
}

class _SelectAccState extends State<SelectAcc> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getListWallet(
      addressWallet: widget.bloc.addressWallet.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
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
                          20,
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
                stream: bloc.list,
                builder: (context, AsyncSnapshot<List<AccountModel>> snapshot) {
                  if (snapshot.hasData) {
                    final listAcc = snapshot.data ?? [];
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: listAcc.length,
                        itemBuilder: (context, index) {
                          return MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              bloc.chooseWallet(
                                walletAddress:
                                    listAcc[index].addressWallet ?? '',
                              );
                              bloc.click(index);
                              if (widget.typeScreen2 == TypeScreen2.detail) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(
                                      index: 1,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(
                                      index: 1,
                                    ),
                                  ),
                                );
                              }
                            },
                            onLongPress: () {
                              Navigator.of(context)
                                  .push(
                                    HeroDialogRoute(
                                      builder: (context) {
                                        return RemoveAcc(
                                          bloc: bloc,
                                          index: index,
                                          walletAddress: snapshot
                                                  .data?[index].addressWallet ??
                                              '',
                                        );
                                      },
                                      isNonBackground: false,
                                    ),
                                  )
                                  .whenComplete(
                                    () => {
                                      if (bloc.listSelectAccBloc.isEmpty)
                                        {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen(
                                                index: 3,
                                              ),
                                            ),
                                          ),
                                        },
                                    },
                                  );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  child: index != 0 ? line : null,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 74.h,
                                  ),
                                  child: Container(
                                    width: 357.w,
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        listAcc[index].url ??
                                                            '',
                                                      ),
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                spaceW8,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 99.w,
                                                          child: Text(
                                                            snapshot
                                                                    .data?[
                                                                        index]
                                                                    .nameWallet ??
                                                                '',
                                                            style:
                                                                textNormalCustom(
                                                              null,
                                                              16,
                                                              FontWeight.w700,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        spaceW4,
                                                        Text(
                                                          listAcc[index]
                                                                  .addressWallet
                                                                  ?.formatAddressWallet() ??
                                                              '',
                                                          style:
                                                              textNormalCustom(
                                                            AppTheme.getInstance()
                                                                .whiteWithOpacityFireZero(),
                                                            14,
                                                            FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    FutureBuilder(
                                                      future:
                                                          bloc.getAmountWallet(
                                                        listAcc[index]
                                                                .addressWallet ??
                                                            '',
                                                      ),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<double>
                                                              snapshot) {
                                                        return Text(
                                                          '${snapshot.data?.toStringAsFixed(5) ?? 0} ${S.current.bnb}',
                                                          style:
                                                              textNormalCustom(
                                                            null,
                                                            16,
                                                            FontWeight.w400,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: listAcc[index]
                                                              .imported ??
                                                          false
                                                      ? Container(
                                                          width: 65.w,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 4.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                6.r,
                                                              ),
                                                            ),
                                                            border: Border.all(
                                                              color: AppTheme
                                                                      .getInstance()
                                                                  .whiteWithOpacityFireZero(),
                                                              width: 1.h,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            S.current.import,
                                                            style: textNormal(
                                                              AppTheme.getInstance()
                                                                  .whiteWithOpacityFireZero(),
                                                              11,
                                                            ).copyWith(
                                                              height: 1.2,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
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
                                                      listAcc[index].isCheck ??
                                                              false
                                                          ? Image.asset(
                                                              ImageAssets
                                                                  .ic_selected,
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
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
