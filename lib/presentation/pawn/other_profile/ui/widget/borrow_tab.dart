import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/presentation/pawn/other_profile/cubit/other_profile_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class BorrowTab extends StatefulWidget {
  const BorrowTab({
    Key? key,
    required this.cubit,
    required this.listReputation,
  }) : super(key: key);

  final OtherProfileCubit cubit;
  final List<Reputation> listReputation;

  @override
  _BorrowTabState createState() => _BorrowTabState();
}

class _BorrowTabState extends State<BorrowTab>
    with SingleTickerProviderStateMixin {
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
                            widget.cubit.getPoint(newValue!);
                          },
                          dropdownMaxHeight: 100.h,
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
                stream: widget.cubit.reputationBorrowStream,
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
          StreamBuilder<bool>(
            stream: widget.cubit.getDataBorrow,
            builder: (builder, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title('AVAILABLE COLLATERAL'),
                        StreamBuilder<bool>(
                          stream: widget.cubit.seeMoreCollateral,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                widget.cubit.seeMoreCollateral
                                    .add(!(snapshot.data ?? false));
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
                    spaceH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.cubit.available.totalAvailableCollateral} available collaterals',
                          style: textNormal(textPawnGray, 16),
                        ),
                        Container(
                          height: 11.h,
                          width: 1.w,
                          color: grey2,
                        ),
                        Text(
                          '${formatUSD.format(widget.cubit.available.totalValue ?? 0)} in value',
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
                        itemCount: widget.cubit.available.symbol?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: Image.network(
                                  ImageAssets.getUrlToken(
                                    widget.cubit.available.symbol?[index] ?? '',
                                  ),
                                ),
                              ),
                              spaceW12,
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(),

                    ///View collateral
                    spaceH35,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title('SIGNED CONTRACT'),
                        StreamBuilder<bool>(
                          stream: widget.cubit.seeMoreSignContract,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                widget.cubit.seeMoreSignContract
                                    .add(!(snapshot.data ?? false));
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
                          '${widget.cubit.signedContract.totalContract} signed contracts',
                          style: textNormal(textPawnGray, 16),
                        ),
                        Container(
                          height: 11.h,
                          width: 1.w,
                          color: grey2,
                        ),
                        Text(
                          '${formatUSD.format(widget.cubit.signedContract.totalValue ?? 0)} in value',
                          style: textNormal(textPawnGray, 16),
                        ),
                      ],
                    ),
                    SizedBox(),
                    spaceH32,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title('MESSAGE'),
                        StreamBuilder<bool>(
                          stream: widget.cubit.seeMoreMessage,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                widget.cubit.seeMoreMessage
                                    .add(!(snapshot.data ?? false));
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
      ),
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: textNormalCustom(purple, 14, FontWeight.w400),
    );
  }
}
