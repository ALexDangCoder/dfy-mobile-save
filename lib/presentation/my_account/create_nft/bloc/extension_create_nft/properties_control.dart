import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension PropertiesControl on CreateNftCubit {
  void addProperty() {
    if(listProperty.length < 10){
      listProperty.add({
        KEY_PROPERTY: '',
        VALUE_PROPERTY: '',
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

  void changeValue(int _index, String vl){
    listProperty[_index][VALUE_PROPERTY] = vl;

  }

  void changeKey(int _index, String vl){
    listProperty[_index][KEY_PROPERTY] = vl;
  }

  String? validateProperty(String vl){
    if(vl.isEmpty){
      return 'Cannot be empty';
    } else if (vl.length > 30){
      return 'Max len is 30 char';
    }
    return null;
  }
}
