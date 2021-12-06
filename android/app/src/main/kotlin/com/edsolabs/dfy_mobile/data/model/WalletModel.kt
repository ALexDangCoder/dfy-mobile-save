package com.edsolabs.dfy_mobile.data.model

data class WalletModel(
    val walletName: String,
    val walletAddress: String,
    val seedPhrase: String,
    val privateKey: String
)
