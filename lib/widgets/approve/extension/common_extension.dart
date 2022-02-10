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

}
