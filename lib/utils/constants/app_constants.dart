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
const bearTokenViNhieuTien = 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ3YWxsZ'
    'XRfYWRkcmVzcyI6IjB4YWIwNWFiNzljMGY0NDBhZDk4MmIxNDA1NTM2YWJjODA5N'
    'GM4MGFmYiIsImdyYW50X3R5cGUiOiJ3YWxsZXQiLCJ1c2VyX25hbWUiOiIweGF'
    'iMDVhYjc5YzBmNDQwYWQ5ODJiMTQwNTUzNmFiYzgwOTRjODBhZmIiLCJzY29wZS'
    'I6WyJERUZBVUxUIl0sImV4cCI6MTY0MjA3NjgxMiwianRpIjoiYjNhYTkyNGYt'
    'ZGVmZC00YzYxLTgyZGYtY2RiYThlMWM1ODNlIiwiY2xpZW50X2lkIjoidGFpbmQ'
    'ifQ.CPDpOdnPYHTVCbBPxT4OzTT57rvSGxbGDUSux7X7g2JcHu_rL-2vjeONXk'
    'vWxQfi5HREwtCcUbsCMCvicZt7pTRc8CGbBC8Ep4oAqaQRV3tE8KMytVoZXxeO'
    'nK1JjrNlD6vjjcSRF6XsUoaT2gHK73EUZJ96W9a5FZnGLnPLsEwmNKP9ijXG'
    '_ZmA0tSgCKdLMGWNDJofmLsZ1ykmFQrc7HLhFCic7X4zkn8OtWLfdh4MWaNnDhi'
    'XmokB6n6_fFQPsx0tSWOI89BOUV0kd5b5mN1HTC4LEj_xhK8yDt0ffjZBpcI8tg'
    'KJl_DU26CXtNS92JAIwBO8dybZwYA7NLgn4g';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
}
