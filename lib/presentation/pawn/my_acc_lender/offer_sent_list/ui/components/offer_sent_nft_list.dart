import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/nft/lender_loan_request_nft_item.dart';
import 'package:flutter/material.dart';

class OfferSentNftList extends StatefulWidget {
  const OfferSentNftList({Key? key}) : super(key: key);

  @override
  _OfferSentNftListState createState() => _OfferSentNftListState();
}

class _OfferSentNftListState extends State<OfferSentNftList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return LenderLoanRequestNftItem();
            },
          ),
        )
      ],
    );
  }
}
