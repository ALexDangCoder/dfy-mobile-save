//
//  NftModel.swift
//  Runner
//
//  Created by NguyenHuuNghia on 20/12/2021.
//

import Foundation

class NftModel {
    var walletAddress = ""
    var collectionAddress = ""
    var nftName = ""
    var symbol = ""
    var item: [ItemNftModel] = []
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
}
