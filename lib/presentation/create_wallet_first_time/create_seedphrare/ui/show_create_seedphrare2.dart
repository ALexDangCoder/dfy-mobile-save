import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom2.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCreateSeedPhrase2(
  BuildContext context,
  BLocCreateSeedPhrase bLocCreateSeedPhrase,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final FToast fToast = FToast();
      fToast.init(context);
      void _showToast() {
        final Widget toast = Container(
          margin: EdgeInsets.only(bottom: 70.h),
          height: 35.h,
          width: 298.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black.withOpacity(0.5),
          ),
          padding: EdgeInsets.only(left: 10.w, top: 10.h),
          child: Text(
            S.current.failed,
            style: TextStyle(color: Colors.red, fontSize: 14.sp),
          ),
        );
        fToast.showToast(
          child: toast,
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      }

      return Container(
        height: 764.h,
        width: 375.w,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: const Color(0xff3e3d5c),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 28.h,
              width: 323.w,
              margin: EdgeInsets.only(right: 26.w, left: 26.w, top: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      url_ic_out,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 66.w,
                  ),
                  Text(
                    S.current.CreateNewWallet,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 64.w,
                  ),
                  GestureDetector(
                    child: Image.asset(
                      url_ic_close,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            spaceH20,
            line,
            spaceH24,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 26.w, left: 26.w),
                      child: Text(
                        'Tap the words to put them next to each other in '
                        'the correct order',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                    spaceH20,
                    Column(
                      children: [
                        StreamBuilder(
                          stream: bLocCreateSeedPhrase.listSeedPhrase,
                          builder:
                              (context, AsyncSnapshot<List<Item>> snapshot) {
                            final listSeedPhrase = snapshot.data;
                            return BoxListPassWordPhrase(
                              listTitle: listSeedPhrase ?? [],
                              bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                            );
                          },
                        ),
                        spaceH24,
                        StreamBuilder(
                          stream: bLocCreateSeedPhrase.listTitle,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<List<Item>> snapshot,
                          ) {
                            final listTitle = snapshot.data;
                            return ListPassPhrase(
                              listTitle: listTitle ?? [],
                              bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 41.h,
                    ),
                    CheckBoxCustom2(
                      title: 'I understand that if I lose my recovery private'
                          ' key or passphrase, I will not be able to '
                          'access my'
                          ' wallet',
                      bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (bLocCreateSeedPhrase.isCheckBox2.value) {
                    if (bLocCreateSeedPhrase.getCheck()) {
                      showCreateSuccessfully(context);
                    } else {
                      _showToast();
                    }
                  }
                },
                child: StreamBuilder(
                  stream: bLocCreateSeedPhrase.isCheckBox2,
                  builder: (context, snapshot) {
                    return ButtonGold(
                      title: 'Continue',
                      isEnable: bLocCreateSeedPhrase.isCheckBox2.value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(
    () => bLocCreateSeedPhrase.reloadListSeedPhrase1(),
  );
}
