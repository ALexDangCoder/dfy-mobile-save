package com.edsolabs.dfy_mobile.data.model

data class NftModel(
    val walletAddress: String,
    val nftAddress: String,
    val nftName: String,
    val iconNFT: String,
    val nftID: Int,
    var isShow: Boolean = true,
)