import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';

class ListPassPhrase extends StatefulWidget {
  final List<Item> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const ListPassPhrase(
      {Key? key, required this.listTitle, required this.bLocCreateSeedPhrase})
      : super(key: key);

  @override
  _ListPassPhraseState createState() => _ListPassPhraseState();
}

class _ListPassPhraseState extends State<ListPassPhrase> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List<Widget>.generate(
        widget.listTitle.length,
        (int index) {
          return GestureDetector(
            onTap: () {
              print(index);
              widget.listTitle[index].isCheck = true;
              widget.bLocCreateSeedPhrase.getList();
            },
            child: widget.listTitle[index].isCheck
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      ' ${widget.listTitle[index].title}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
