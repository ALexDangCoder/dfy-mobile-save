import 'package:intl/intl.dart';

enum AppMode { LIGHT, DARK }

enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

enum MenuType { FEED, NOTIFICATIONS, POLICY, LOGOUT }

enum AuthMode { LOGIN, REGISTER }

enum AuthType { ACCOUNT, PHONE }
enum MarketType { SALE, AUCTION, PAWN, NOT_ON_MARKET }
enum PageRouter { MARKET, MY_ACC }
enum TypeNFT { HARD_NFT, SOFT_NFT }
enum TypeImage { IMAGE, VIDEO }

enum PageTransitionType {
  FADE,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  RIGHT_TO_LEFT_WITH_FADE,
}

const String CALENDAR_TYPE_DAY = 'Day';
const String CALENDAR_TYPE_MONTH = 'Month';
const String CALENDAR_TYPE_YEAR = 'Year';
const String ERASE_WALLET = 'earse_wallet';
const String SUCCESS = 'success';
const String FAIL = 'fail';
NumberFormat formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');
DateFormat formatDateTime = DateFormat('HH:mm - dd/MM/yyyy');

const String STATUS_TRANSACTION_FAIL = '0';
const String STATUS_TRANSACTION_SUCCESS = '1';

const int secondShowPopUp = 2;

const String TRANSACTION_TOKEN = '0';
const String TRANSACTION_NFT = '1';

const EN_CODE = 'en';
const VI_CODE = 'vi';
const VI_LANG = 'vn';

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const VN_PHONE = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';

//2021-06-18 04:24:27
const _dtFormat1 = 'yyyy-MM-dd HH:mm:ss';
const _dtFormat2 = 'hh:mm a';
const _dtFormat3 = 'dd/MM hh:mm a';
const _dtFormat4 = 'yyyy-MM-dd';
const _dtFormat6 = 'yyyy-MM-dd hh : mm';
const _dtFormat5 = 'MMM dd, yyyy';

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

const networkName = 'BSC';

//Media file type
const String MEDIA_VIDEO_FILE = 'video';
const String MEDIA_IMAGE_FILE = 'image';
const String MEDIA_AUDIO_FILE = 'audio';
const String AVATAR_PHOTO = 'AVATAR';
const String COVER_PHOTO = 'COVER_PHOTO';
const String FEATURE_PHOTO = 'FEATURE_PHOTO';

//Collection type, standard
const int SOFT_COLLECTION = 0;
const int HARD_COLLECTION = 1;
const int ERC721 = 0;
const int ERC1155 = 1;



// defi infomation

const String appName = 'DeFi For You';
const String appURL = 'defiforyou.uk';
const String defiLink = 'https://defiforyou.uk/';
const String mailAsk = 'ask@defiforyou.uk';
const String mailSupport = 'support@defiforyou.uk';
const String mailAskHanoi = 'ask@defiforyou.uk';
const String mailMarketingHanoi = 'marketing@defiforyou.uk';
const String locationHanoi = 'BT NQ 25-15 Vinhomes Riverside, Long Bien, Hanoi, Vietnam';
const String mailOfficeLondon = 'sean@defiforyou.uk';
const String seanMason = 'Sean Mason ';
const String cfo = '- CFO';
const String locationLondon = 'Office 32 19-21 Crawford Street, London, United Kingdom, W1H 1PJ';
const String registrationNumber =  '13126050';
const String gitLink = 'https://github.com/defi-vn/';
const String telegramLink = 'https://t.me/DeFiForYou_English';
const String facebookLink = 'https://www.facebook.com/DeFiForYouDFY';
const String youtubeLink = 'https://www.youtube.com/channel/UCGaSCU17Zo_2CzJNaBeUHaA/featured';
const String linkedinLink = 'https://www.linkedin.com/company/defiforyou';
const String twitterLink = 'https://twitter.com/Defiforyou';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
  static const DATE_TIME_AUCTION_FORMAT = _dtFormat6;
}
