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
const nft_sales_address_dev2 = '0xcE80f7DFEC1589D6cf9a0586446618aAbBC711E7';
const nft_factory_dev2 = '0x0bcA4DCddE35d2F2aC5a3fAF0baD966639e6EB41';
const nft_auction_dev2 = '0xdE92A451d22C1D84E874b6B8A5A70AC5f91b6D86';
const bearTokenViNhieuTien =
    'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ3YWxsZXRfYWRkcmVzcyI6IjB4Mz'
    'llZTRjMjhlMDljZTZkOTA4NjQzZGRkZWVhZWVmMjM0MTEzOGViYiIsImdyYW50X3R5cGUiOiJ3'
    'YWxsZXQiLCJ1c2VyX25hbWUiOiIweDM5ZWU0YzI4ZTA5Y2U2ZDkwODY0M2RkZGVlYWVlZjIzND'
    'ExMzhlYmIiLCJzY29wZSI6WyJERUZBVUxUIl0sImV4cCI6MTY0MjE2MjI0OCwianRpIjoiZGY4'
    'ODhmNGUtYzFkYi00NmQ4LTgwYTAtYzA1YmUwMzY1MjQyIiwiY2xpZW50X2lkIjoidGFpbmQifQ'
    '.gt94dx10snss-tzzCJ2icz8WGoRd9tBrvzf7IZrsF3jXgjxBGt1hhIsPf4YHbwybCPasjlMZD'
    '1BzlLdwC5LFqkwJ7E8UJf1Kj0uO5kqKQcmF0HLGARID6VFeo_b5v1GPcBCGN2561fgLsQQx2Qh'
    'xcsXBzCld4S7O0DHfNFBns_NBIxQowhom-MpZhkmockxdt07bR4_Z1-lcZt05TvlyCY0PQUORs'
    'wgGmktjznzBZ-wqWz-8BapS5zsxm8PYwdQ9jNeOaxISLCQ0jaHxcH_XpDqK6OX3fQFmRniv0V'
    '7X1noidYL_atDSLg_baHOjkQk4WHJGqTxZ9IKsMPMibgs0ww';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
}
