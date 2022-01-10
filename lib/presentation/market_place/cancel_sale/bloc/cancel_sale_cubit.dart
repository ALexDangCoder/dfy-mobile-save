import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cancel_sale_state.dart';

class CancelSaleCubit extends Cubit<CancelSaleState> {
  CancelSaleCubit({required this.ntfValue, required this.quantity})
      : super(CancelSaleInitial());
  final String ntfValue;
  final String quantity;

  List<DetailItemApproveModel> initListApprove() {
    List<DetailItemApproveModel> listApprove = [
      DetailItemApproveModel(title: 'NTF', value: ntfValue),
      DetailItemApproveModel(title: S.current.quantity, value: quantity)
    ];
    return listApprove;
  }

  Future<void> getEstimateFromWeb3()async {
    Web3Utils web3utils = Web3Utils();
  }
}
