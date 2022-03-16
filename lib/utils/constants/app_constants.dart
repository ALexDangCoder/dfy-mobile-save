import 'dart:core';

import 'package:intl/intl.dart';

enum AppMode { LIGHT, DARK }

enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

enum MenuType { FEED, NOTIFICATIONS, POLICY, LOGOUT }
enum TypeCheckBox { LOAN, COLLATERAL, COLLECTION }

enum AuthMode { LOGIN, REGISTER }

enum AuthType { ACCOUNT, PHONE }
enum MarketType { SALE, AUCTION, PAWN, NOT_ON_MARKET }
enum PageRouter { MARKET, MY_ACC }
enum TypeNFT { HARD_NFT, SOFT_NFT }
enum TypeImage { IMAGE, VIDEO }
enum PackageType {AUTO,SEMI_AUTO,NEGOTIATION,P2P}

enum PageTransitionType {
  FADE,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  RIGHT_TO_LEFT_WITH_FADE,
}
// enum CircleStatus {
//   IS_CREATING,
//   IS_NOT_CREATE,
// }

const int CODE_ERROR_AUTH = 401;
const int CODE_ERROR_NOT_FOUND = 400;
const int CODE_ERROR_MAINTAIN = 503;
const int CODE_ERROR_NETWORK = 0;
//filter
const int NOT_ON_MARKET = 0;
const int SALE = 1;
const int AUCTION = 2;
const int PAWN = 3;
const String PUT_ON_PAWN = 'list NFT on pawn';
const String PUT_ON_SALE = 'list NFT on sale';
const String PUT_ON_AUCTION = 'list NFT on auction';
const int WEEK = 0;
const int MONTH = 1;
const String CALENDAR_TYPE_DAY = 'Day';
const String CALENDAR_TYPE_MONTH = 'Month';
const String CALENDAR_TYPE_YEAR = 'Year';
const String ERASE_WALLET = 'earse_wallet';
const String SUCCESS = 'success';
const String FAIL = 'fail';
const String HOUR = 'hour';
const String MINUTE = 'minute';
const String EVALUATION_FEE = '2';
NumberFormat formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');
NumberFormat formatPrice = NumberFormat('###,###,###.#####', 'en_US');
NumberFormat formatPricePawn = NumberFormat('#.#####', 'en_US');
DateFormat formatDateTime = DateFormat('HH:mm - dd/MM/yyyy');

const String STATUS_TRANSACTION_FAIL = '0';
const String STATUS_TRANSACTION_SUCCESS = '1';
const int ID_MONTH = 1;
const int ID_WEEK = 0;

const int secondShowPopUp = 2;

const String TRANSACTION_TOKEN = '0';
const String TRANSACTION_NFT = '1';

const EN_CODE = 'en';
const VI_CODE = 'vi';
const VI_LANG = 'vn';

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const VN_PHONE = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
const AMOUNT_5 = r'^\d+((.)|(.\d{0,5})?)$';

//2021-06-18 04:24:27
const _dtFormat1 = 'yyyy-MM-dd HH:mm:ss';
const _dtFormat2 = 'hh:mm a';
const _dtFormat3 = 'dd/MM hh:mm a';
const _dtFormat4 = 'yyyy-MM-dd';
const _dtFormat6 = 'yyyy-MM-dd hh : mm';
const _dtFormat5 = 'MMM dd, yyyy';
const _dtFormat7 = 'HH';
const _dtFormat8 = 'mm';
const _dtFormat9 = 'MM';
const _dtFormat10 = 'yyyy';
const _dtFormat11 = 'HH:mm';
const _dtFormat12 = 'dd/MM/yyyy';
const _dtFormat13 = 'EEEE';
const _dtFormat14 = 'yyyy-MM-dd';
const _dtFormat15 = 'dd/MM/yyyy HH:mm';

//Regex
final twoDecimal = RegExp(r'^(?=\D*(?:\d\D*){1,}$)\d+(?:\.\d{1,2})?$');
final fiveDecimal = RegExp(r'^(?=\D*(?:\d\D*){1,}$)\d+(?:\.\d{1,5})?$');
//contract
const nft_sales_address_dev2 =
    '0xcE80f7DFEC1589D6cf9a0586446618aAbBC711E7'; // buy
const nft_factory_dev2 =
    '0x0bcA4DCddE35d2F2aC5a3fAF0baD966639e6EB41'; // tao collection
const nft_auction_dev2 =
    '0xdE92A451d22C1D84E874b6B8A5A70AC5f91b6D86'; // auction
const nft_pawn_dev2 = '0x687011EBE0493191485805BfE04505D8Ca48Ec92'; // pawn
const hard_nft_factory_address_dev2 =
    '0x51Ed2FDb40bD921F48708F58b4B0c7D669B6481C';
const contract_defy = '0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14';
const eva_dev2 = '0xE3059b5143bfB2dd9C12581c841419863b868681';

const networkName = 'BSC';

//Media file type
const String MEDIA_VIDEO_FILE = 'video';
const String MEDIA_IMAGE_FILE = 'image';
const String MEDIA_AUDIO_FILE = 'audio';
const String DOCUMENT_FILE = 'document';
const String AVATAR_PHOTO = 'AVATAR';
const String COVER_PHOTO = 'COVER_PHOTO';
const String FEATURE_PHOTO = 'FEATURE_PHOTO';
const String VIDEO_ACTIVITY = 'video/MP4';

//Collection type, standard
const int SOFT_COLLECTION = 0;
const int HARD_COLLECTION = 1;
const int ERC721 = 0;
const int ERC1155 = 1;
const String BINANCE_SMART_CHAIN = 'Binance smart chain';
const String ERC_721 = 'ERC-721';
const String ERC_1155 = 'ERC-1155';
const String NFT = 'NFT';

// defi infomation

const String appName = 'DeFi For You';
const String appURL = 'defiforyou.uk';
const String defiLink = 'https://defiforyou.uk/';
const String mailAsk = 'ask@defiforyou.uk';
const String mailSupport = 'support@defiforyou.uk';
const String mailAskHanoi = 'ask@defiforyou.uk';
const String mailMarketingHanoi = 'marketing@defiforyou.uk';
const String locationHanoi =
    'BT NQ 25-15 Vinhomes Riverside, Long Bien, Hanoi, Vietnam';
const String mailOfficeLondon = 'sean@defiforyou.uk';
const String seanMason = 'Sean Mason ';
const String cfo = '- CFO';
const String locationLondon =
    'Office 32 19-21 Crawford Street, London, United Kingdom, W1H 1PJ';
const String registrationNumber = '13126050';
const String gitLink = 'https://github.com/defi-vn/';
const String telegramLink = 'https://t.me/DeFiForYou_English';
const String facebookLink = 'https://www.facebook.com/DeFiForYouDFY';
const String youtubeLink =
    'https://www.youtube.com/channel/UCGaSCU17Zo_2CzJNaBeUHaA/featured';
const String linkedinLink = 'https://www.linkedin.com/company/defiforyou';
const String twitterLink = 'https://twitter.com/Defiforyou';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
  static const DATE_TIME_AUCTION_FORMAT = _dtFormat6;
  static const BOOK_HOUR = _dtFormat7;
  static const BOOK_MIN = _dtFormat8;
  static const BOOK_MONTH = _dtFormat9;
  static const BOOK_YEAR = _dtFormat10;
  static const BOOK_HOURS = _dtFormat11;
  static const BOOK_DATE = _dtFormat12;
  static const BOOK_IN_WEEK = _dtFormat13;
  static const CREATE_DATE = _dtFormat14;
  static const CREATE_STRING_TO_DATE = _dtFormat15;
}

const USDT = 'USDT';
const BNB = 'BNB';
const PERCENT = '%';
const DFY = 'DFY';
const PROCESSING_CREATE = 1;
const FAILED_CREATE = 2;
const OPEN = 3;
const PROCESSING_ACCEPT = 4;
const PROCESSING_REJECT = 5;
const PROCESSING_CANCEL = 6;
const ACCEPTED = 7;
const REJECTED = 8;
const CANCELED = 9;
enum StatusOffer {
  PROCESSING_CREATE,
  FAILED_CREATE,
  OPEN,
  PROCESSING_ACCEPT,
  PROCESSING_REJECT,
  PROCESSING_CANCEL,
  ACCEPTED,
  REJECTED,
  CANCELED,
}

//file type
const String DAPP = 'Dapp';
const String EMPTYSPACESTEP3 = '                     ';
const String MP4 = 'video/mp4';
const String WEBM = 'video/webm';
const String MP3 = 'audio/mpeg';
const String WAV = 'audio/wav';
const String OGG_AUDIO = 'audio/ogg';
const String OGG_VIDEO = 'video/ogg';
const String OGG = 'application/ogg';
const String PNG = 'image/png';
const String JPG = 'image/jpeg';
const String JPEG = 'image/jpeg';
const String GIF = 'image/gif';
const String DOCX =
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
const String DOC = 'application/msword';
const String PDF = 'application/pdf';
const String XLS = 'application/vnd.ms-excel';
const String XLSX =
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const String POWER_POINT = 'application/vnd.ms-powerpoint';
const String POWER_POINT_XML =
    'application/vnd.openxmlformats-officedocument.presentationml.presentation';
const String ADDRESS_COLLECTION_721 =
    '0x45e42092ee4c4c1bed3476cc1ed85b26517cece1';
const String ADDRESS_COLLECTION_1155 =
    '0x45e42092ee4c4c1bed3476cc1ed85b26517cece1';
const String ID_COLLECTION_721 = '61ca6cf4b05ecbb0d62b7b37';
const String ID_COLLECTION_1155 = '61ca6d06b05ecbb0d62b7b9e';
const String ADDRESS_DFY = '0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14';
