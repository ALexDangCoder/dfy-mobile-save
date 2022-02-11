class ApiConstants {
  static const LOGIN = '/example_view';

  static const int DEFAULT_PAGE_SIZE = 45;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const String DEFAULT_NFT_SIZE = '12';
  static const String GET_LIST_TOKEN =
      '/nft-market-svc/public-api/market/coin-list';
  static const String DETAIL_CATEGORY = 'inventory-svc/public-api/collections';
  static const String GET_PRICE_TOKEN_BY_SYMBOL =
      '/nft-market-svc/public-api/market/coin-price';
  static const String GET_DETAIL_NFT_AUCTION =
      '/nft-market-svc/public-api/auction/detail/';
  static const String GET_EVALUATION_HARD_NFT =
      '/hard-nft-svc/public-api/evaluations/';
  static const String GET_LIST_NFT_COLLECTION_EXPLORE =
      '/nft-market-svc/public-api/home';
  static const String GET_LIST_NFT_COLLECTION_EXPLORE_SEARCH =
      '/nft-market-svc/public-api/search';
  static const String BASE_URL_IMAGE =
      'https://defiforyou.mypinata.cloud/ipfs/';
  static const String URL_BASE = 'https://defiforyou.mypinata.cloud/ipfs/';
  static const String GET_LIST_COLLECTION =
      '/inventory-svc/public-api/collections';
  static const String GET_LIST_COLLECTION_MARKET =
      '/nft-market-svc/public-api/search/collection';
  static const String GET_LIST_FILTER_COLLECTION_DETAIL =
      '/inventory-svc/public-api/collections/get-filter-properties';
  static const String GET_LIST_CATEGORY = '/nft-market-svc/public-api/category';
  static const String GET_BOOL_CUSTOM_URL =
      'nft-market-svc/public-api/collection/check-validated-custom-url?custom_url=https://marketplace.defiforyou.uk/';
  static const String GET_LIST_COLLECTION_FILTER =
      '/nft-market-svc/public-api/collection';
  static const String GET_LIST_NFT = '/nft-market-svc/public-api/search/nft';
  static const String GET_LIST_TYPE_NFT =
      '/hard-nft-svc/public-api/collections/types';

  static const String GET_LIST_NFT_COLLECTION =
      '/inventory-svc/public-api/collections/list-nft/';
  static const String COLLECTION_DETAIL =
      '/inventory-svc/public-api/collections/';
  static const String COLLECTION_ACTIVITY_LIST =
      '/inventory-svc/public-api/v1.0.0/collections/activities';

  ///NFT
  static const String GET_DETAIL_NFT_ON_SALE =
      '/nft-market-svc/public-api/market/detail/';

  static const String GET_DETAIL_NFT_NOT_ON_MARKET =
      '/inventory-svc/public-api/nfts/';
  static const String GET_DETAIL_HARD_NFT =
      '/nft-market-svc/public-api/hard-nft/';
  static const String GET_HISTORY = 'inventory-svc/public-api/v1.0.0/histories';
  static const String GET_OWNER = 'inventory-svc/public-api/v1.0.0/owners';
  static const String GET_BIDDING =
      '/nft-market-svc/public-api/auction/bidding-list';
  static const String BUY_NFT = '/nft-market-svc/api/market/buy';
  static const String OFFER_DETAIL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer/';

  static const String GET_CRYPTO_ASSET =
      '/nft-market-svc/public-api/crypto-asset';

  static const String GET_DETAIL_NFT_ON_PAWN =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/nfts/';

  static const String GET_OFFER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/loan-crypto-offer';

  // BSC SCAN

  static const String BSC_SCAN_ADDRESS = 'address/';
  static const String BSC_SCAN_TX = 'tx/';

  //cancel sale
  static const String CANCEL_SALE = '/nft-market-svc/api/market/cancel';
  static const String BID_NFT = '/nft-market-svc/api/auction/bid';

  ///MyAcc
  static const String GET_LIST_NFT_MY_ACC = '/inventory-svc/api/v1.0.0/nfts';

  //CREATE COLLECTION
  static const String CREATE_SOFT_COLLECTION =
      '/nft-market-svc/api/collection/create';
  static const String PUT_ON_SALE = '/nft-market-svc/api/market/put-on-sale';
  static const String PUT_ON_PAWN =
      '/defi-pawn-crypto-service/api/v1.0.0/collaterals/nfts';
  static const String PUT_ON_AUCTION =
      '/nft-market-svc/api/auction/put-on-auction';
  static const String CREATE_HARD_COLLECTION =
      '/hard-nft-svc/api/collections/create-hard-collection';

  //Get Nonce để ký login
  static const String GET_NONCE =
      '/defi-user-service/public-api/v1.0.0/users/nonce?';

  //login
  static const String LOGIN_MARKET =
      '/defi-user-service/public-api/v1.0.0/users/mobile/login';

  //GET PROFILE WHEN LOGIN:
  static const String GET_USER_PROFILE =
      '/defi-user-service/api/v1.0.0/users/profile';

  //REFRESH TOKEN:
  static const String REFRESH_TOKEN =
      '/defi-user-service/public-api/v1.0.0/users/refresh_token';

  //GET LIST WALLET
  static const String GET_LIST_WALLET =
      '/defi-user-service/api/v1.0.0/users/wallet-address';

  //send offer
  static const String ACCEPT_OFFER =
      'defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer/{id}/accept';
  static const String REJECT_OFFER =
      'defi-pawn-crypto-service/api/v1.0.0/crypto-offer/{id}/cancel';
  static const String SEND_OFFER =
      'defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer';

  //IPFS
  static const String PINATA_API_KEY = 'ac8828bff3bcd1c1b828';
  static const String PINATA_SECRET_API_KEY =
      'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df';
  static const String PIN_FILE_TO_IPFS =
      'https://api.pinata.cloud/pinning/pinFileToIPFS?file';
  static const String PIN_JSON_TO_IPFS =
      'https://api.pinata.cloud/pinning/pinJSONToIPFS';

  //Custom URL
  static const String PREFIX_CUSTOM_URL = 'https://marketplace.defiforyou.uk/';

//createHard NFT

  //CreateNFT
  static const String CREATE_SOFT_NFT = '/nft-svc/api/soft-nft/create-721';

  //Liên kết email:
  static const String GET_OTP = '/defi-user-service/api/v1.0.0/users/otp';
  static const String VERIFY_OTP = '/defi-user-service/api/v1.0.0/users/otp';

  //cancel auction
  static const String CANCEL_AUCTION = '/nft-market-svc/api/auction/cancel';

  //cancel pawn
  static const String CANCEL_PAWN =
      '/defi-pawn-crypto-service/api/v1.0.0/collaterals/nfts/withdraw?id=';

  //logout:
  static const String LOG_OUT = '/defi-user-service/api/v1.0.0/users/logout';
  static const String GET_LIST_APPOINTMENTS = '/hard-nft-svc/api/appointments';

  static const String GET_LIST_EVALUATORS_CITY =
      '/hard-nft-svc/public-api/evaluators/find-by-city';

  static const String GET_EVALUATORS_DETAIL =
      '/hard-nft-svc/public-api/evaluators/';

  static const String GET_EVALUATORS_DETAIL_END = '/customer-view-profile';

  static const String CREATE_EVALUATION = '/hard-nft-svc/api//appointments';

  static const String CANCEL = '/hard-nft-svc/api/appointments/';

  static const String CANCEL_END = '/cancel';

  ///HARD NFT MY ACCOUNT
  static const String GET_PHONE_CODE = 'hard-nft-svc/public-api/phone-codes';

  static const String GET_COUNTRIES = 'hard-nft-svc/public-api/countries';

  ///HARD NFT MY ACCOUNT
  static const String GET_CITIES = '/hard-nft-svc/public-api/countries/';

  ///get_evaluation_result
  static const String GET_LIST_EVALUATION_RESULT = '/hard-nft-svc/api/evaluations/';
  static const String ACCEPT = '/accept';
  static const String REJECT = '/reject';
  static const String GET_EVALUATION_FEE = '/hard-nft-svc/public-api/system-fee';
  static const String PATH_GET_CITIES = '/cities';

  static const String GET_CONDITION =
      'hard-nft-svc/public-api/assets/conditions';
}
