import 'dart:developer';

import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:flutter/material.dart';
class HardNFTScreen extends StatelessWidget {
  const HardNFTScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseNFTMarket(
      filterFunc: filterFunc,
      title: 'Lamborghini Aventador Pink Ver 2021',
      child: Container(),
    );
  }
  void filterFunc(){
    log('AAAAA');
  }
}
