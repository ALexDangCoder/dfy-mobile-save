import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension PropertiesControl on CreateNftCubit {
  void addProperty() {
    listProperty.add({
      'key': '',
      'value': '',
    });
    listPropertySubject.sink.add(listProperty);
  }

  void removeProperty(int _index) {
    try {
      listProperty.removeAt(_index);
    } catch (_) {}
    listPropertySubject.sink.add(listProperty);
  }
}
