import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/ui/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionItem extends StatelessWidget {
  final String urlBackGround;
  final String urlIcon;
  final String title;

  const CollectionItem({
    Key? key,
    required this.urlBackGround,
    required this.urlIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const DetailCollection(
                  walletAddress: 'a6b1b1a6-6cbe-4375-a981-0e727b8120c4',
                  id: 'a6b1b1a6-6cbe-4375-a981-0e727b8120c4');
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            height: 147.h,
            width: 222.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.getInstance().selectDialogColor(),
                width: 1.w,
              ),
              color: AppTheme.getInstance().borderItemColor(),
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 222.w,
                      height: 77.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: urlBackGround.isEmpty
                              ? const AssetImage(ImageAssets.ic_search)
                                  as ImageProvider
                              : NetworkImage(urlBackGround),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 30.h,
                          left: 10.w,
                          right: 10.w,
                        ),
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: AppTheme.getInstance().whiteColor(),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 47.h,
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.getInstance().borderItemColor(),
                        width: 4.w,
                      ),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: 52.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: urlIcon.isEmpty
                              ? const AssetImage(ImageAssets.ic_search)
                                  as ImageProvider
                              : NetworkImage(urlIcon),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }
}
