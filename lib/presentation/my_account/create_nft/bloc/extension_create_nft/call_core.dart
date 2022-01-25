import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:flutter/services.dart';

extension CallCore on CreateNftCubit{
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
        } else {
          final List<Wallet> listWallet = [];
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          walletAddress = listWallet.first.address ?? '';
        }
        break;
      default:
        break;
    }
  }
}