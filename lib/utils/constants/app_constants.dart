import 'package:intl/intl.dart';

enum AppMode { LIGHT, DARK }

enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

enum MenuType { FEED, NOTIFICATIONS, POLICY, LOGOUT }

enum AuthMode { LOGIN, REGISTER }

enum AuthType { ACCOUNT, PHONE }
enum MarketType { SALE, AUCTION, PAWN, NOT_ON_MARKET }
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
const String ID_MONTH = '1';
const String ID_WEEK = '1';


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
const _dtFormat5 = 'MMM dd, yyyy';

//contract
const nft_sales_address_dev2 = '0xcE80f7DFEC1589D6cf9a0586446618aAbBC711E7'; /// buy
const nft_factory_dev2 = '0x0bcA4DCddE35d2F2aC5a3fAF0baD966639e6EB41';
const nft_auction_dev2 = '0xdE92A451d22C1D84E874b6B8A5A70AC5f91b6D86';
const bearTokenViNhieuTien =
    'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ3YWxsZXRfYWRkcmVzcyI6IjB4MzllZTRjMjhlMDljZTZkOTA4NjQzZGRkZWVhZWVmMjM0MTEzOGViYiIsImdyYW50X3R5cGUiOiJ3YWxsZXQiLCJ1c2VyX25hbWUiOiIweDM5ZWU0YzI4ZTA5Y2U2ZDkwODY0M2RkZGVlYWVlZjIzNDExMzhlYmIiLCJzY29wZSI6WyJERUZBVUxUIl0sImV4cCI6MTY0MjE3ODU0MywianRpIjoiZTdlYjRjZWYtNGY3MC00YjFhLWJjZGEtMDg0YjdiOTQ5Yjk0IiwiY2xpZW50X2lkIjoidGFpbmQifQ.p2svN_bhHI06IoyXh4SCAmehWk1GlHEUQOBRwnD5Pn_Nq7U59xasr6NSpZb0GWePC8qZdrGj3Bo_JbMqazE_nzLFsjxo1dBD0uK3v_zob-ZYhACn6sz_EMgvrcggbFI8mrihDJRLLDrN_-v83ZaPXpxHPs9Qq5DEA3sfoUxcqcK6UMYbf_ZSpfjww004P50gNyZ-n6uDH0BHDuWF5q-LCC4QR1txNepLmx5pNHI_eCrxPrVy6RzdmNjjSkOPId3vdK0doZRfuWaUCdY1FM3nNjOn1hZuY7w05AoGYdILn1lZQ9ofRQLAqHrPns0mDoyXELgZGH05OkZfpNbjXBwkpQ';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
}
