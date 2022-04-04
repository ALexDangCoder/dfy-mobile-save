class ApiConstants {
  static const LOGIN = '/example_view';

  static const int DEFAULT_PAGE_SIZE = 12;
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
      '/inventory-svc/public-api/search/collection';
  static const String GET_LIST_FILTER_COLLECTION_DETAIL =
      '/inventory-svc/public-api/collections/get-filter-properties';
  static const String GET_LIST_CATEGORY = '/nft-market-svc/public-api/category';
  static const String GET_BOOL_CUSTOM_URL =
      'nft-market-svc/public-api/collection/check-validated-custom-url?custom_url=';
  static const String GET_LIST_COLLECTION_FILTER =
      '/nft-market-svc/public-api/collection';
  static const String GET_LIST_NFT = '/nft-market-svc/public-api/search/nft';
  static const String GET_LIST_TYPE_NFT =
      '/hard-nft-svc/public-api/collections/types';

  static const String GET_LIST_NFT_COLLECTION =
      '/inventory-svc/public-api/collections/list-nft/';

  static const String GET_LIST_NFT_COLLECTION_MY_ACC =
      '/inventory-svc/api/v1.0.0/list-nft/';
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
      '/hard-nft-svc/public-api/hard-nft/';
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
  static const String BUY_OUT = '/nft-market-svc/api/auction/buy-out';

  ///MyAcc
  static const String GET_LIST_NFT_MY_ACC = '/inventory-svc/api/v1.0.0/nfts';

  //list hard nft

  static const String GET_HARD_LIST_NFT = '/inventory-svc/api/nft';

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
      'defi-pawn-crypto-service/api/v1.0.0/crypto-offer/{collateralId}/rejectOffer/{id}?wallet-address={walletAddress}';
  static const String SEND_OFFER =
      'defi-pawn-crypto-service/api/v1.0.0/crypto-offer';

  //IPFS
  static const String PINATA_API_KEY = 'ac8828bff3bcd1c1b828';
  static const String PINATA_SECRET_API_KEY =
      'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df';
  static const String PIN_FILE_TO_IPFS =
      'https://api.pinata.cloud/pinning/pinFileToIPFS?file';
  static const String PIN_JSON_TO_IPFS = '/pinning/pinJSONToIPFS';

  //Custom URL
  static const String PREFIX_CUSTOM_URL = 'https://marketplace.defiforyou.uk/';

//createHard NFT

  //CreateNFT
  static const String CREATE_SOFT_NFT = '/nft-svc/api/soft-nft/create-721';
  static const String GET_ALL_COLLECTION =
      '/nft-market-svc/api/collection/self';
  static const String PUT_HARD_NFT_PREFIX = '/hard-nft-svc/api/assets/';
  static const String PUT_HARD_NFT_SUFFIX = '/submit';

  //Liên kết email:
  static const String GET_OTP = '/defi-user-service/api/v1.0.0/users/otp';
  static const String VERIFY_OTP = '/defi-user-service/api/v1.0.0/users/otp';
  static const String GET_REWARD = '/defi-user-service/api/v1.0.0/verification/get_dfy_reward';
  static const String POST_VERIFICATION = '/defi-user-service/api/v1.0.0/verification';

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

  static const String POST_ASSETS = '/hard-nft-svc/api/assets';

  static const String GET_EVALUATORS_DETAIL_END = '/customer-view-profile';

  static const String CREATE_EVALUATION = '/hard-nft-svc/api/appointments';

  static const String CANCEL = '/hard-nft-svc/api/appointments/';

  static const String CANCEL_END = '/cancel';

  ///HARD NFT MY ACCOUNT
  static const String GET_PHONE_CODE = 'hard-nft-svc/public-api/phone-codes';

  static const String GET_COUNTRIES = 'hard-nft-svc/public-api/countries';

  ///HARD NFT MY ACCOUNT
  static const String GET_CITIES = '/hard-nft-svc/public-api/countries/';

  ///get_evaluation_result
  static const String TRANSFER_NFT = '/nft-svc/api/soft-nft/transfer';
  static const String GET_LIST_EVALUATION_RESULT =
      '/hard-nft-svc/api/evaluations/';
  static const String GET_DETAIL_ASSETS_HARD_NFT = '/hard-nft-svc/api/assets/';
  static const String GET_MINT_REQUEST_HARD_NFT = '/hard-nft-svc/api/assets';
  static const String ACCEPT = '/accept';
  static const String REJECT = '/reject';
  static const String GET_EVALUATION_FEE =
      '/hard-nft-svc/public-api/system-fee';
  static const String PATH_GET_CITIES = '/cities';

  static const String GET_CONDITION =
      'hard-nft-svc/public-api/assets/conditions';

  static const String GET_HARD_NFT_TYPE = 'hard-nft-svc/public-api/asset/types';

//pawn
  static const String GET_LIST_PAWN =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop/search-pawnshop';
  static const String GET_LIST_NFT_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/nfts';

  ///PAWN
  static const String GET_OFFICIAL_PAWNSHOP_WITH_TOKEN =
      '/defi-pawn-crypto-service/public-api/v1.0.0/homepage/list-official-pawnshop';
  static const String GET_TOP_RATED_LENDERS =
      '/defi-pawn-crypto-service/public-api/v1.0.0/homepage/list-top-rated-lender';
  static const String GET_TOP_SALE_PACKAGE_MODEL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/homepage/list-top-sale-package';
  static const String GET_NFTS_COLLATERAL_PAWN =
      '/defi-pawn-crypto-service/public-api/v1.0.0/homepage/list-nft-collateral';
  static const String GET_PERSONAL_LENDING =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop/search-p2p-lenders';
  static const String GET_PAWNSHOP_PACKAGE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package/search';
  static const String GET_PERSONAL_LENDING_HARD =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package/search-lending';

  static const String GET_CRYPTO_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/submit';

  static const String GET_LIST_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/search';
  static const String GET_COLLECTION_HARD_NFT = 'hard-nft-svc/api/collections';
  static const String POST_COLLATERAL_TO_BE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package/submitCollateral';
  static const String GET_COLLECTION_FILTER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/collections';

  static const String GET_ASSET_FILTER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/nfts/asset-types';
  static const String GET_DETAIL_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/';
  static const String GET_LIST_REPUTATION =
      '/defi-user-service/public-api/v1.0.0/users/reputation/by-wallet';

  static const String GET_NFT_SEND_lOAN_REQUEST =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/nfts';
  static const String POST_NFT_SEND_LOAN_REQUEST =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package/submit-nft-collateral';

  static const String POST_SEND_OFFER_REQUEST =
      '/defi-pawn-crypto-service/api/v1.0.0/crypto-offer';
  static const String GET_PAWNSHOP_PACKAGE_DETAIL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package/';
  static const String GET_LENDING_SETTING =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop/lending-setting';
  static const String GET_PROFILE_USER =
      '/defi-user-service/public-api/v1.0.0/users/';
  static const String PUT_PROFILE_USER =
      '/defi-user-service/api/v1.0.0/users/profile';
  static const String DISCONNECT_WALLET =
      '/defi-user-service/api/v1.0.0/users/disassociate';
  static const String PUT_PAWN_SHOP_PROFILE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop/shop-profile';
  static const String GET_MY_PROFILE_USER =
      '/defi-user-service/api/v1.0.0/users/';
  static const String GET_MY_SETTING_EMAIL =
      '/defi-user-service/api/v1.0.0/email-setting';
  static const String GET_MY_SETTING_NOTI =
      '/defi-user-service/api/v1.0.0/noti-setting';
  static const String GET_NOTIFICATION = '/defi-user-service/api/v1.0.0/notify';
  static const String GET_REPUTATION =
      '/defi-user-service/public-api/v1.0.0/users/reputation';
  static const String GET_BORROW_USER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/borrow-available-collateral';
  static const String GET_BORROW_SIGN_CONTRACT_USER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/borrow-signed-contracts';
  static const String GET_LENDER_SIGN_CONTRACT_USER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/lender-signed-contracts';
  static const String GET_LIST_CONTRACT_USER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/borrow-contracts';
  static const String GET_LIST_LOAN_CONTRACT_USER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/loan-contracts';
  static const String GET_LIST_COMMENT =
      '/defi-pawn-crypto-service/public-api/v1.0.0/review';
  static const String GET_LIST_LOAN_PACKAGE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop/';

  //myacc
  static const String COLLATERAL_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals';

  static const String CREATE_NEW_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals';

  static const String DETAIL_COLLATERAL_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/';

  static const String HISTORY_DETAIL_COLLATERAL_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/collaterals/';
  static const String HISTORY_MY_ACC = '/history';

  static const String OFFERS_RECEIVED_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/loan-crypto-offer';

  static const String SEND_TO_LOAN_PACKAGE_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/pawn-shop-package';

  static const String COLLATERAL_WITHDRAW =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/withdraw';

  static const String OFFER_DETAIL_MY_ACC =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer/';

  //Pawn Offer Sent
  static const String GET_LIST_OFFER_SENT_CRYPTO =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer';

  static const String GET_USER_ID_PAWN =
      '/defi-user-service/public-api/v1.0.0/users/check-validate';

  static const String GET_BORROW_CONTRACT =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/borrow-contracts';

  // contract detail

  static const String GET_DETAIl_CONTRACT_LENDER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/borrow-contracts/';

  static const String GET_DETAIl_LENDER =
      '/defi-pawn-crypto-service/api/v1.0.0/my-contract/lender-contracts/';

  static const String GET_BORROW_REPAYMENT_HISTORY =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/';
  static const String REPAYMENT_STATS = '/repayment-stats';

  static const String GET_BORROW_REPAYMENT_REQUEST =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/';
  static const String REPAYMENT_REQUEST = '/repayment-requests';

  static const String GET_CHECK_RATE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/review/check';

  static const String GET_LIST_ITEM_REPAYMENT =
      '/defi-pawn-crypto-service/public-api/v1.0.0/repayment-request/';

  static const String GET_TOTAL_REPAYMENT =
      '/defi-pawn-crypto-service/public-api/v1.0.0/repayment-request/';
  static const String SUMMARY = '/summary';

  static const String GET_REPAYMENT_PAY =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/';
  static const String ACTIVE_REPAYMENT = '/active-repayment-request';

  static const String POST_REPAYMENT_PAY =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/';
  static const String CALCULATE = '/calculate-repayment-fee';

  static const String PUT_ACCEPT_OFFER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer/';
  static const String ACCEPT_OFFER_PAWN = '/accept';

  static const String PUT_CANCEL_OFFER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/loan-crypto-offer/';
  static const String CANCEL_OFFER_PAWN = '/cancel';

  static const String ADD_MORE_COLLATERAL =
      '/defi-pawn-crypto-service/public-api/v1.0.0/my-contract/';
  static const String COLLATERAL = '/collaterals';

  static const String REVIEW_RATE =
      '/defi-pawn-crypto-service/public-api/v1.0.0/review';
}
