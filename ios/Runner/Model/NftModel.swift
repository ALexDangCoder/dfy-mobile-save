//
//  NftModel.swift
//  Runner
//
//  Created by NguyenHuuNghia on 20/12/2021.
//

import Foundation

struct NftDTO: Decodable {
    var name: String?
    var symbol: String?
    var contract: String?
    var listNft: [ItemNftDTO]?
}

struct ItemNftDTO: Decodable {
    var id: String?
    var contract: String?
    var uri: String?
}

class NftModel {
    var walletAddress = ""
    var collectionAddress = ""
    var nftName = ""
    var symbol = ""
    var item: [ItemNftModel] = []
    
    init(walletAddress: String, collectionAddress: String, nftName: String, symbol: String, item: [ItemNftModel]) {
        self.walletAddress = walletAddress
        self.collectionAddress = collectionAddress
        self.nftName = nftName
        self.symbol = symbol
        self.item = item
    }
    
    init(param: [String: Any]) {
        let listItemParam = param["item"] as? [[String: Any]] ?? []
        self.walletAddress = param["walletAddress"] as! String
        self.collectionAddress = param["collectionAddress"] as! String
        self.nftName = param["nftName"] as! String
        self.symbol = param["symbol"] as! String
        self.item = listItemParam.map{ItemNftModel(param: $0)}
        print("List nft count: \(self.item.count)")
    }
    
    func toDict() -> [String: Any] {
        let listItemParam = item.map{$0.toDict()}
        return [
            "walletAddress": walletAddress,
            "collectionAddress": collectionAddress,
            "nftName": nftName,
            "symbol": symbol,
            "item": listItemParam,
        ]
    }
}

class ItemNftModel {
    var id = ""
    var contract = ""
    var uri = ""
    
    init(id: String, contract: String, uri: String) {
        self.id = id
        self.contract = contract
        self.uri = uri
    }
    
    init(param: [String: Any]) {
        self.id = param["id"] as! String
        self.contract = param["contract"] as! String
        self.uri = param["uri"] as! String
    }
    
    func toDict() -> [String: Any] {
        return [
            "id": id,
            "contract": contract,
            "uri": uri,
        ]
    }
}
