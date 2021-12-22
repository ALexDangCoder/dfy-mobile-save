import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListPassPhrase extends StatelessWidget {
  final List<String> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const ListPassPhrase({
    Key? key,
    required this.listTitle,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 123.h,
        padding: EdgeInsets.only(right: 26.w, left: 26.w),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 12.h,
          children: List<Widget>.generate(
            listTitle.length,
                (int index) {
              return GestureDetector(
                onTap: () {
                  bLocCreateSeedPhrase.addListBoxSeedPhrase(listTitle[index]);
                  bLocCreateSeedPhrase.removeListSeedPhrase(index);
                  if (listTitle.isEmpty) {
                    bLocCreateSeedPhrase.getCheck();
                    bLocCreateSeedPhrase.getIsSeedPhraseImport();
                  }
                },
                child: ItemSeedPhrase(title: listTitle[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
