import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';

extension ValidateInput on CreateNftCubit {
  String? validateCollectionName(String vl) {
    if (vl.isEmpty) {
      return S.current.collection_name_require;
    } else if (vl.length > 255) {
      return S.current.maximum_len;
    } else {
      nftName = vl;
      return null;
    }
  }

  String? validateDescription(String vl) {
    description = vl;
    if (vl.length > 255) {
      return S.current.maximum_len;
    }
    return null;
  }

  String? validateRoyalty(String vl) {
    if (vl.isNotEmpty) {
      try {
        final tempVl = int.parse(vl);
        if (tempVl > 50 || tempVl < 0) {
          return S.current.max_royalty;
        } else {
          royalty = tempVl;
          return null;
        }
      } catch (_) {
        return S.current.only_digits;
      }
    } else {
      return null;
    }
  }

  void validateInput({required bool value}) {
    createNftMapCheck['input_text'] = value;
    validateCreate();
  }

  void voidCheckCollectionId(String value) {
    collectionAddress = value;
    collectionId = softCollectionList
            .where((element) => element.addressCollection == collectionAddress)
            .toList()
            .first
            .collectionId ??
        '';
    if (collectionAddress.isNotEmpty) {
      createNftMapCheck['collection'] = true;
    } else {
      createNftMapCheck['collection'] = false;
    }
    validateCreate();
  }
}
