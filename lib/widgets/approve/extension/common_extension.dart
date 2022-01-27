import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';

extension CommonExtension on ApproveCubit {
  Future<int> getNonce() async {
    try {
      final TransactionCountResponse model =
          await web3Client.getTransactionCount(
        address: addressWallet ?? '',
      );
      return model.count;
    } catch (_) {
      return -1;
    }
  }

  Future<void > loopCheckApprove() async {
    DateTime? _lastQuitTime;
    bool approved  = false;
    while (!approved){
      if (_lastQuitTime == null ) {
        _lastQuitTime = DateTime.now();
        approved = await checkApprove(
          payValue: payValue ?? '',
          tokenAddress: tokenAddress ?? '',
        );
      } else {
        approved= await checkApprove(
          payValue: payValue ?? '',
          tokenAddress: tokenAddress ?? '',
        );
        if (DateTime.now().difference(_lastQuitTime).inSeconds > 30){
          break;
        }
      }
    }
  }

  String getSpender() {
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        return nft_sales_address_dev2;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        return nft_auction_dev2;
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        return nft_sales_address_dev2;
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        return nft_pawn_dev2;
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        {
          return isSoftCollection
              ? nft_factory_dev2
              : hard_nft_factory_address_dev2;
        }
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        return nft_sales_address_dev2;
      case TYPE_CONFIRM_BASE.PUT_ON_AUCTION:
        return nft_auction_dev2;
      case TYPE_CONFIRM_BASE.PUT_ON_PAWN:
        return nft_pawn_dev2;
      case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
        return nft_auction_dev2;
      case TYPE_CONFIRM_BASE.CREATE_SOFT_NFT:
        return spender ?? '';
      default:
        return nft_factory_dev2;
    }
  }
}
