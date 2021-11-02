import 'package:Dfy/domain/model/item.dart';
import 'package:flutter/material.dart';

class ListPassPhrase extends StatefulWidget {
  final List<Item> listTitle;

  const ListPassPhrase({Key? key, required this.listTitle}) : super(key: key);

  @override
  _ListPassPhraseState createState() => _ListPassPhraseState();
}

class _ListPassPhraseState extends State<ListPassPhrase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Wrap(
        spacing: 5,
        runSpacing: 12,
        children: List<Widget>.generate(
          listTitle.length,
              (int index) {
            return GestureDetector(
              onTap: () {
                print(index);
                listTitle[index].isCheck = true;
              },
              child: listTitle[index].isCheck
                  ? const SizedBox(height: 0,width: 0,)
                  : Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  ' ${listTitle[index].title}',
                  style:
                  const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
