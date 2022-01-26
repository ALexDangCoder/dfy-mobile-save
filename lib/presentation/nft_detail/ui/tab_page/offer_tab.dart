import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/presentation/offer_detail/ui/offer_detail_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferTab extends StatefulWidget {
  const OfferTab({Key? key, required this.listOffer}) : super(key: key);

  final List<OfferDetail> listOffer;

  @override
  _OfferTabState createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listOffer.isEmpty) {
      return SizedBox(
        height: 150.h,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: sizedPngImage(
                  w: 94,
                  h: 94,
                  image: ImageAssets.icNoTransaction,
                ),
              ),
              Center(
                child: Text(
                  'No offer',
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().currencyDetailTokenColor(),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.listOffer.length,
        itemBuilder: (context, index) {
          return _buildItemOffer(widget.listOffer[index]);
        },
      );
    }
  }

  Widget _buildItemOffer(OfferDetail objOffer) {
    final String duration = (objOffer.durationType == 0) ? 'week' : 'month';
    return BaseItem(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetailScreen(
                id: objOffer.id ?? -1,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          ImageAssets
                              .ic_user_verified,
                          height: 24.h,
                          width: 24.w,
                        ),
                        spaceW12,
                        Text(
                          '${objOffer.addressLender}'.handleString(),
                          style: richTextWhite
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          )
                              .copyWith(fontSize: 14.sp),
                        ),
                      ],
                    ),
                    spaceH6,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'offered ',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14,
                              FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '${objOffer.supplyCurrency?.amount ?? ''} '
                                '${objOffer.supplyCurrency?.symbol ?? ''}',
                            style: textNormal(
                              amountColor,
                              14,
                            ),
                          ),
                          TextSpan(
                            text:
                            ' with a ${objOffer.duration ?? ''} $duration',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14,
                              FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' loan term',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14,
                              FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ImageIcon(
                  const AssetImage(ImageAssets.ic_line_right),
                  size: 24.sp,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
