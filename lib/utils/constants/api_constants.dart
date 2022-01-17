class ApiConstants {
  static const LOGIN = '/example_view';

  static const int DEFAULT_PAGE_SIZE = 45;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const String DEFAULT_NFT_SIZE = '12';
  static const String GET_LIST_TOKEN =
      '/nft-market-svc/public-api/market/coin-list';
  static const String DETAIL_CATEGORY = 'nft-market-svc/public-api/collection';
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
  static const String GET_NONCE =
      '/defi-user-service/public-api/v1.0.0/users/nonce?';
  static const String LOGIN_EMAIL =
      '/defi-user-service/public-api/v1.0.0/users/nonce?';
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
  static const String GET_DETAIL_HARD_NFT =
      '/nft-market-svc/public-api/hard-nft/';
  static const String GET_HISTORY = 'inventory-svc/public-api/v1.0.0/histories';
  static const String GET_OWNER = 'inventory-svc/public-api/v1.0.0/owners';
  static const String GET_BIDDING =
      '/nft-market-svc/public-api/auction/bidding-list';
  static const String BUY_NFT = '/nft-market-svc/api/market/buy';
  static const String BID_NFT = '/nft-market-svc/api/auction/bid';

  static const String GET_DETAIL_NFT_ON_PAWN =
      '/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/nfts/';

  static const String GET_OFFER =
      '/defi-pawn-crypto-service/public-api/v1.0.0/loan-crypto-offer';

  // BSC SCAN

  static const String BSC_SCAN_ADDRESS = 'address/';
  static const String BSC_SCAN_TX = 'tx/';

  //cacel sale
  static const String CANCEL_SALE = '/nft-market-svc/api/market/cancel';

}
