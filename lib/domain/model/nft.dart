class NFT {
  final String name;
  final String description;
  final Standard standard;
  final String identity;
  final String link;
  final String blockChain;
  final String contract;

  NFT(
    this.name,
    this.description,
    this.standard,
    this.link,
    this.blockChain,
    this.contract,
    this.identity,
  );
}

enum Standard { ERC_1155, ERC_721 }
