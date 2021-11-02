import 'dart:ui';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/item_create/item_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showMadelBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 764.h,
          width: 375.w,
          padding: const EdgeInsets.all(26),
          decoration: const BoxDecoration(
            // shape: BoxShape.circle,
            color: Color(0xff24234C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                        color: Colors.white,
                      )),
                ],
              ),
              ItemPassPhrase(
                listTitle: listTitle,
              ),
              ListPassPhrase(
                listTitle: listTitle,
              ),
              const CheckBoxCustom(
                title:
                    'I understand that if I lose my recovery private key\n or passphrase,'
                    ' I will not be able to acess my \nwallet',
              ),
              SizedBox(
                height: 18.h,
              ),
              GestureDetector(
                onTap: () {
                  print('continue');
                },
                child: const ButtonGold(
                  title: 'Continue',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
