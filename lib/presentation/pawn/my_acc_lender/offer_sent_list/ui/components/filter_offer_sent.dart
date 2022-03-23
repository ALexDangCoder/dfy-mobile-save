import 'dart:ui';

import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:flutter/material.dart';

class FilerOfferSent extends StatefulWidget {
  const FilerOfferSent({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final OfferSentListCubit cubit;

  @override
  _FilerOfferSentState createState() => _FilerOfferSentState();
}

class _FilerOfferSentState extends State<FilerOfferSent> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Stack(

      ),
    );
  }
}
