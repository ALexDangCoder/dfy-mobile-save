package com.edsolabs.dfy_mobile.data.model

data class NftModel(
    var walletAddress: String? = "",
    var collectionAddress: String? = "",
    var nftName: String? = "",
    var symbol: String? = "",
    var item: ArrayList<ItemNftModel> = ArrayList()
)

data class ItemNftModel(
    var id: String,
    var contract: String,
    var uri: String
)