import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/other_profile/cubit/other_profile_cubit.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/loan_package_item.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/widget/signed_contract_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LenderTab extends StatefulWidget {
  const LenderTab({
    Key? key,
    required this.cubit,
    required this.listReputation, required this.pageRouter,
  }) : super(key: key);
  final OtherProfileCubit cubit;
  final List<Reputation> listReputation;
  final PageRouter pageRouter;

  @override
  _LenderTabState createState() => _LenderTabState();
}

class _LenderTabState extends State<LenderTab> {
  late String walletAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletAddress = widget.cubit.walletAddress[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        children: [
          Container(
            height: 46.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Theme(
              data: ThemeData(
                hintColor: Colors.white24,
                selectedRowColor: Colors.white24,
              ),
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        right: 12.w,
                        left: 45.w,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          buttonDecoration: BoxDecoration(
                            color: AppTheme.getInstance().backgroundBTSColor(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                          items: widget.cubit.walletAddress.map((String model) {
                            return DropdownMenuItem(
                              value: model,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    model != 'All Wallet'
                                        ? model.formatAddress(index: 5)
                                        : model,
                                    style: textNormal(
                                      Colors.white,
                                      16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              walletAddress = newValue!;
                            });
                            if(widget.pageRouter ==PageRouter.MARKET){
                              widget.cubit.getPointLender(newValue!);
                              widget.cubit.selectWalletLender(newValue);
                            }
                          },
                          dropdownMaxHeight: 150.h,
                          dropdownWidth:
                              MediaQuery.of(context).size.width - 32.w,
                          dropdownDecoration: BoxDecoration(
                            color: AppTheme.getInstance().backgroundBTSColor(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                          ),
                          scrollbarThickness: 0,
                          scrollbarAlwaysShow: false,
                          offset: Offset(-45.w, 0),
                          value: walletAddress,
                          icon: Image.asset(
                            ImageAssets.ic_line_down,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Image.asset(ImageAssets.ic_wallet),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 48.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(ImageAssets.ic_copy),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          spaceH15,
          Row(
            children: [
              Text(
                'Points:',
                style: textNormal(grey3, 16),
              ),
              spaceW12,
              Image.asset(
                ImageAssets.ic_star,
                height: 20.h,
                width: 20.w,
              ),
              spaceW5,
              StreamBuilder<String>(
                stream: widget.cubit.reputationLenderStream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style: textNormalCustom(Colors.white, 20, FontWeight.w600),
                  );
                },
              ),
              spaceW5,
              InkWell(
                onTap: () {
                  launch('https://defi-for-you.gitbook.io/faq/list/reputation');
                },
                child: Image.asset(
                  ImageAssets.ic_about_2,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ],
          ),
          spaceH36,
          if(widget.pageRouter == PageRouter.MARKET)...[
            StreamBuilder<bool>(
              stream: widget.cubit.getDataLender,
              builder: (builder, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == true) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          title('LENDING SETTING'),
                          StreamBuilder<bool>(
                            stream: widget.cubit.seeMoreLendingSetting,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  if (widget.cubit.listLoanPackage.isNotEmpty) {
                                    widget.cubit.seeMoreLendingSetting
                                        .add(!(snapshot.data ?? false));
                                  }
                                },
                                child: Image.asset(
                                  snapshot.data == true
                                      ? ImageAssets.ic_view_less
                                      : ImageAssets.ic_view_more,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      spaceH14,
                      Row(
                        children: [
                          Text(
                            '${S.current.interest_rate_apr}:',
                            style: textNormal(textPawnGray, 16),
                          ),
                          spaceW12,
                          Text(
                            '${widget.cubit.lendingSetting.interestMin}-${widget.cubit.lendingSetting.interestMax}%',
                            style: textNormal(Colors.white, 16),
                          ),
                        ],
                      ),
                      spaceH16,
                      Row(
                        children: [
                          Text(
                            '${S.current.nft_collateral}:',
                            style: textNormal(textPawnGray, 16),
                          ),
                          spaceW12,
                          Text(
                            getNftType(),
                            style: textNormal(Colors.white, 16),
                          ),
                        ],
                      ),
                      spaceH16,
                      Row(
                        children: [
                          Text(
                            '${S.current.collateral_accepted}:',
                            style: textNormal(textPawnGray, 16),
                          ),
                        ],
                      ),
                      spaceH16,
                      SizedBox(
                        height: 30.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.cubit.lendingSetting
                              .collateralAcceptances?.length ??
                              0,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.network(
                                    ImageAssets.getUrlToken(
                                      widget
                                          .cubit
                                          .lendingSetting
                                          .collateralAcceptances?[index]
                                          .symbol ??
                                          '',
                                    ),
                                  ),
                                ),
                                spaceW12,
                              ],
                            );
                          },
                        ),
                      ),
                      spaceH24,
                      Center(
                        child: ButtonRadial(
                          height: 40.h,
                          width: 122.w,
                          child: Center(
                            child: Text(
                              'Request loan',
                              style: textNormalCustom(
                                Colors.white,
                                16,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      spaceH20,
                      StreamBuilder<bool>(
                        stream: widget.cubit.seeMoreLendingSetting,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data == true) {
                            return StreamBuilder<bool>(
                              stream: widget.cubit.viewMoreLendingSetting,
                              builder: (context, AsyncSnapshot<bool> snapshot2) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Loan package',
                                          style: textNormalCustom(
                                            Colors.white,
                                            16,
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    spaceH20,
                                    SizedBox(
                                      child: ListView.builder(
                                        itemCount: snapshot2.data == false
                                            ? (widget.cubit.listLoanPackage
                                            .length >
                                            3
                                            ? 3
                                            : widget
                                            .cubit.listLoanPackage.length)
                                            : widget.cubit.listLoanPackage.length,
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              LoanPackageItem(
                                                pawnshopPackage: widget
                                                    .cubit.listLoanPackage[index],
                                              ),
                                              spaceH20,
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    if (widget.cubit.listLoanPackage.length >
                                        3) ...[
                                      divider,
                                      spaceH20,
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          sizedSvgImage(
                                            w: 14,
                                            h: 14,
                                            image: snapshot2.data == true
                                                ? ImageAssets.ic_collapse_svg
                                                : ImageAssets.ic_expand_svg,
                                          ),
                                          SizedBox(
                                            width: 13.15.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              widget.cubit.viewMoreLendingSetting
                                                  .add(
                                                !(snapshot2.data ?? false),
                                              );
                                            },
                                            child: Text(
                                              snapshot2.data == true
                                                  ? S.current.see_less
                                                  : S.current.see_more,
                                              style: textNormalCustom(
                                                AppTheme.getInstance()
                                                    .fillColor(),
                                                16,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceH20,
                                      divider,
                                    ],

                                  ],
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH35,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          title('SIGNED CONTRACT'),
                          StreamBuilder<bool>(
                            stream: widget.cubit.seeMoreLenderSignContract,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  if (widget.cubit.lenderSignedContract
                                      .totalContract !=
                                      0 &&
                                      widget.cubit.lenderSignedContract
                                          .totalContract !=
                                          null) {
                                    widget.cubit.seeMoreLenderSignContract
                                        .add(!(snapshot.data ?? false));
                                  }
                                },
                                child: Image.asset(
                                  snapshot.data == true
                                      ? ImageAssets.ic_view_less
                                      : ImageAssets.ic_view_more,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      spaceH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.cubit.lenderSignedContract.totalContract ?? 0} signed contracts',
                            style: textNormal(textPawnGray, 16),
                          ),
                          Container(
                            height: 11.h,
                            width: 1.w,
                            color: grey2,
                          ),
                          Text(
                            '${formatUSD.format(widget.cubit.lenderSignedContract.totalValue ?? 0)} in value',
                            style: textNormal(textPawnGray, 16),
                          ),
                        ],
                      ),
                      spaceH20,
                      StreamBuilder<bool>(
                        stream: widget.cubit.seeMoreLenderSignContract,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data == true) {
                            return StreamBuilder<bool>(
                              stream: widget.cubit.viewMoreLenderSignContract,
                              builder: (context, AsyncSnapshot<bool> snapshot2) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      child: ListView.builder(
                                        itemCount: snapshot2.data == false
                                            ? (widget
                                            .cubit
                                            .listLenderSignedContract
                                            .length >
                                            3
                                            ? 3
                                            : widget
                                            .cubit
                                            .listLenderSignedContract
                                            .length)
                                            : widget.cubit
                                            .listLenderSignedContract.length,
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              SignedContractItem(
                                                signedContractUser: widget.cubit
                                                    .listLenderSignedContract[
                                                index],
                                              ),
                                              spaceH20,
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    if (widget.cubit.listLenderSignedContract
                                        .length >
                                        3) ...[
                                      divider,
                                      spaceH20,
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          sizedSvgImage(
                                            w: 14,
                                            h: 14,
                                            image: snapshot2.data == true
                                                ? ImageAssets.ic_collapse_svg
                                                : ImageAssets.ic_expand_svg,
                                          ),
                                          SizedBox(
                                            width: 13.15.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              widget.cubit
                                                  .viewMoreLenderSignContract
                                                  .add(
                                                !(snapshot2.data ?? false),
                                              );
                                            },
                                            child: Text(
                                              snapshot2.data == true
                                                  ? S.current.see_less
                                                  : S.current.see_more,
                                              style: textNormalCustom(
                                                AppTheme.getInstance()
                                                    .fillColor(),
                                                16,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceH20,
                                      divider,
                                    ],
                                  ],
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      spaceH32,
                    ],
                  );
                } else {
                  return CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4.r,
                  );
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: textNormalCustom(purple, 14, FontWeight.w400),
    );
  }

  String getNftType() {
    switch (widget.cubit.lendingSetting.lendingType) {
      case 0:
        return 'All type NFT';
      case 1:
        return 'Soft NFT';
      default:
        return 'Hard NFT';
    }
  }
}
