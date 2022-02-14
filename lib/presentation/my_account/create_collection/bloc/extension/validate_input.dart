import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';

extension ValidateInput on CreateCollectionCubit {

  void validateCase({
    required String hintText,
    required String value,
    required String inputCase,
  }) {
    final mess = validateText(value: value, hintText: hintText);
    switch (inputCase) {
      case 'name':
        {
          validateName(mess, value);
          break;
        }
      case 'des':
        {
          validateDes(mess, value);
          break;
        }
      case 'category':
        {
          validateCategory(mess);
          break;
        }
      case 'royalty':
        {
          validateRoyalty(mess);
          break;
        }
      case 'facebook':
        {
          validateFacebook(mess, value);
          break;
        }
      case 'twitter':
        {
          validateTwitter(mess, value);
          break;
        }
      case 'instagram':
        {
          validateInstagram(mess, value);
          break;
        }
      case 'telegram':
        {
          validateTelegram(mess, value);
          break;
        }
      default:
        {
          break;
        }
    }
    validateCreate();
  }

  String validateText({required String value, required String hintText}) {
    if (value.isEmpty &&
        hintText != 'Facebook' &&
        hintText != 'Twitter' &&
        hintText != 'Instagram' &&
        hintText != 'Telegram' &&
        hintText != S.current.royalties &&
        hintText != 'app.defiforyou/uk/marketplace/....' &&
        hintText != S.current.description) {
      return S.current.collection_name_require;
    } else if (hintText == S.current.royalties) {
      if (value.isEmpty) {
        royalties = 0;
        return '';
      } else {
        try {
          final int tempInt = int.parse(value);
          if (tempInt > 50) {
            return S.current.max_royalty;
          } else {
            royalties = tempInt;
            return '';
          }
        } catch (e) {
          return S.current.only_digits;
        }
      }
    } else if (value.length > 255) {
      return S.current.maximum_len;
    } else {
      return '';
    }
  }

  void validateName(String mess, String value) {
    nameCollectionSubject.sink.add(mess);
    if (mess.isEmpty) {
      collectionName = value;
      mapCheck[COLLECTION_NAME_MAP] = true;
    } else {
      mapCheck[COLLECTION_NAME_MAP] = false;
    }
  }

  void validateDes(String mess, String value) {
    descriptionSubject.sink.add(mess);
    if (mess.isEmpty) {
      description = value;
      mapCheck[DESCRIPTION_MAP] = true;
    } else {
      mapCheck[DESCRIPTION_MAP] = false;
    }
  }

  void validateRoyalty(String mess) {
    royaltySubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck[ROYALTIES_MAP] = true;
    } else {
      mapCheck[ROYALTIES_MAP] = false;
    }
  }

  void validateFacebook(String mess, String value) {
    facebookSubject.sink.add(mess);
    if (mess.isEmpty) {
      faceBook = value;
      mapCheck[FACEBOOK_MAP] = true;
    } else {
      mapCheck[FACEBOOK_MAP] = false;
    }
  }

  void validateTwitter(String mess, String value) {
    twitterSubject.sink.add(mess);
    if (mess.isEmpty) {
      twitter = value;
      mapCheck[TWITTER_MAP] = true;
    } else {
      mapCheck[TWITTER_MAP] = false;
    }
  }

  void validateInstagram(String mess, String value) {
    instagramSubject.sink.add(mess);
    if (mess.isEmpty) {
      instagram = value;
      mapCheck[INSTAGRAM_MAP] = true;
    } else {
      mapCheck[INSTAGRAM_MAP] = false;
    }
  }

  void validateTelegram(String mess, String value) {
    telegramSubject.sink.add(mess);
    if (mess.isEmpty) {
      telegram = value;
      mapCheck[TELEGRAM_MAP] = true;
    } else {
      mapCheck[TELEGRAM_MAP] = false;
    }
  }

  void validateCategory(String value) {
    if (value.isNotEmpty) {
      categoryId = value;
      getCategoryNameById(value);
      mapCheck[CATEGORIES_MAP] = true;
    } else {
      categoriesSubject.sink.add(S.current.category_require);
      mapCheck[CATEGORIES_MAP] = false;
    }
  }

  ///get category name by ID
  void getCategoryNameById(String _id) {
    categoryName = listCategory
            .where((element) => element.id == categoryId)
            .toList()
            .first
            .name ??
        '';
  }
}
