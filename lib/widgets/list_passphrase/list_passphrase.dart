import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListPassPhrase extends StatelessWidget {
  final List<Item> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const ListPassPhrase(
      {Key? key, required this.listTitle, required this.bLocCreateSeedPhrase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 123.h,
        padding: EdgeInsets.only(right: 26.w, left: 26.w),
        child: Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: List<Widget>.generate(
            listTitle.length,
            (int index) {
              return GestureDetector(
                  onTap: () {
                    listTitle[index].isCheck = true;
                    bLocCreateSeedPhrase.getList2();
                  },
                  child: listTitle[index].isCheck
                      ? const SizedBox()
                      : ItemSeedPhrase(title: listTitle[index].title));
            },
          ),
        ),
      ),
    );
  }
}
