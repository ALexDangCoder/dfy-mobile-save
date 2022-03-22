import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:Dfy/presentation/pawn/other_profile/cubit/other_profile_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LenderTab extends StatefulWidget {
  const LenderTab({
    Key? key,
    required this.cubit,
    required this.listReputation,
  }) : super(key: key);
  final OtherProfileCubit cubit;
  final List<Reputation> listReputation;

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
                            widget.cubit.getPointLender(newValue!);
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
        ],
      ),
    );
  }
}
