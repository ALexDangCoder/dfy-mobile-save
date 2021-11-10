import 'package:Dfy/domain/model/account_model.dart';
import 'package:rxdart/rxdart.dart';

class SelectAccBloc {
  SelectAccBloc() {
    getList();
  }

  BehaviorSubject<List<AccountModel>> list = BehaviorSubject.seeded([]);

  void getList() {
    list.sink.add(listSelectAccBloc);
  }

  List<AccountModel> listSelectAccBloc = [
    AccountModel(
        isCheck: true,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: false,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: false,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: false,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: false,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: false,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
    AccountModel(
        isCheck: false,
        addressWallet: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
        amountWallet: 21342314,
        imported: true,
        nameWallet: 'Account 1',
        url: 'assets/images/Ellipse 39.png'),
  ];

  String formatAddress(String address) {
    final String a =
        '${address.substring(0,5)}...${address.substring(address.length - 4,
        address.length,)}';
    return a;
  }

  void click(int index){
    for(final AccountModel value in listSelectAccBloc){
      value.isCheck=false;
    }
    listSelectAccBloc[index].isCheck=true;
    list.sink.add(listSelectAccBloc);
  }
}
