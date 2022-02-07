import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension PropertiesControl on CreateNftCubit {
  void addProperty() {
    if(listProperty.length < 10){
      listProperty.add({
        'key': '',
        'value': '',
      });
      listPropertySubject.sink.add(listProperty);
      // ignore: invariant_booleans
    }
    if (listProperty.length >= 10){
      showAddPropertySubject.sink.add(false);
    }
  }

  void removeProperty(int _index) {
    try {
      listProperty.removeAt(_index);
    } catch (_) {}
    listPropertySubject.sink.add(listProperty);
    if (listProperty.length < 10){
      showAddPropertySubject.sink.add(true);
    }
  }
}
