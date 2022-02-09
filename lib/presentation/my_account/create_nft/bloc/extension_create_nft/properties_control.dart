import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension PropertiesControl on CreateNftCubit {
  void addProperty() {
    boolProperties.add(false);
    checkProperty();
    if (listProperty.length < 10) {
      listProperty.add({
        KEY_PROPERTY: '',
        VALUE_PROPERTY: '',
      });
      listPropertySubject.sink.add(listProperty);
    }
    if (listProperty.length >= 10) {
      showAddPropertySubject.sink.add(false);
    }
  }

  void removeProperty(int _index) {
    try {
      boolProperties.removeAt(_index);
      listProperty.removeAt(_index);
    } catch (_) {}
    listPropertySubject.sink.add(listProperty);
    if (listProperty.length < 10) {
      showAddPropertySubject.sink.add(true);
    }
    checkProperty();
  }

  void changeValue(int _index, String vl) {
    listProperty[_index][VALUE_PROPERTY] = vl;
  }

  void changeKey(int _index, String vl) {
    listProperty[_index][KEY_PROPERTY] = vl;
  }

  String getError(String _key, String _value) {
    if (_key.isEmpty || _value.isEmpty) {
      return 'Property or Value cannot be empty';
    }
    if (_key.length > 30 || _value.length > 30) {
      return 'Maximum length is 30 character';
    }
    return '';
  }

  void checkProperty() {
    for (final e in boolProperties) {
      e
          ? createNftMapCheck[PROPERTIES_KEY] = true
          : createNftMapCheck[PROPERTIES_KEY] = false;
    }
    validateCreate();
  }
}
