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

  String getSpender() {
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        return nft_sales_address_dev2;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        return nft_auction_dev2;
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        return nft_sales_address_dev2;
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        {
          return isSoftCollection
              ? nft_factory_dev2
              : hard_nft_factory_address_dev2;
        }
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        return nft_sales_address_dev2;
      default:
        return nft_factory_dev2;
    }
  }
}
