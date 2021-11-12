import 'package:Dfy/domain/model/private_key_model.dart';
import 'package:rxdart/rxdart.dart';

class PrivateKeySeedPhraseBloc {
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);
  List<PrivateKeyModel> listWallet = [
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'doanhdz',
      privateKey: '123421342134214231421344234',
      seedPhrase:
          'party response give dove'
              ' tooth master flip video permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'nam vippro',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'huy cuc suc',
      privateKey: '1234123444421342314231421342',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video '
              'permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '21342134231421344213423142314231412342134',
      seedPhrase:
          'party response give dove tooth master flip video '
              'permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video '
              'permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '21342134234234231423999999999999',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip vid'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '9999999999999999999999999999999999999',
    ),
    PrivateKeyModel(
      urlImage: 'assets/images/Ellipse 39.png',
      walletName: 'hung vay nen',
      privateKey: '0x753EE7D5FdBD248fED37add0C951211E03a7DA15',
      seedPhrase:
          'party response give dove tooth master flip video'
              ' permit game expire token',
      walletAddress: '9999999999999999999999999999999999999',
    ),
  ];

  List<String> stringToList(String seedPhrase) {
    final List<String> list = seedPhrase.split(' ');
    return list;
  }

  String formatText(String text) {
    final String value =
        '${text.substring(0, 10)}'
        '...${text.substring(text.length - 10, text.length)}';
    return value;
  }
}
