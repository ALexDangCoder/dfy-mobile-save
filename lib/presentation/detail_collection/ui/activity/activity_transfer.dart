import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferActivity extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String addressSend;
  final String address;
  final String copy;

  const TransferActivity({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.copy,
    required this.addressSend,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceW12,
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                width: 66.w,
                height: 66.w,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  color: Colors.yellow,
                  child: Text(
                    title.substring(0, 1),
                    style: textNormalCustom(
                      Colors.black,
                      60,
                      FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                imageUrl: urlAvatar,
              ),
            ),
            Positioned(
              top: -2,
              left: -4,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.w,
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageAssets.img_activity_transfer,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        spaceW12,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              title,
              style: textNormalCustom(
                null,
                14,
                FontWeight.w600,
              ),
            ),
            //content
            SizedBox(
              width: MediaQuery.of(context).size.width - 106,
              child: RichText(
                //Transferred %X copy% from %địa chỉ ví gửi% to  %địa chỉ ví nhận%
                //
                // %địa chỉ ví gửi%: Địa chỉ ví gửi. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví gửi%, hiển thị là YOU.
                // %địa chỉ ví nhận%: Địa chỉ ví nhận.  Nếu user đang connect địa chỉ ví trùng với %địa chỉ nhận%, hiển thị là YOU.
                // %X copies%: Sổ bản transfer. Chỉ hiển thị Đối với NFT 1155
                text: TextSpan(
                  text: '${S.current.activity_transferred} ',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    14,
                    FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: copy.isEmpty
                          ? '${S.current.activity_by} '
                          : '${S.current.activity_copied} $copy ${S.current.activity_by} ',
                    ),
                    TextSpan(
                      text: addressSend == S.current.activity_you
                          ? S.current.activity_you
                          : addressSend,
                      style: addressSend == S.current.activity_you
                          ? textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            )
                          : textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                    ),
                    TextSpan(
                      text: ' ${S.current.activity_from_to} ',
                    ),
                    TextSpan(
                      text: address == S.current.activity_you
                          ? S.current.activity_you
                          : address,
                      style: address == S.current.activity_you
                          ? textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            )
                          : textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            //date
            spaceH6,
            Text(
              date,
              style: textNormalCustom(
                AppTheme.getInstance().activityDateColor(),
                14,
                null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
