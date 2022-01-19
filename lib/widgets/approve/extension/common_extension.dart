import 'package:Dfy/data/web3/web3_utils.dart';
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
}
