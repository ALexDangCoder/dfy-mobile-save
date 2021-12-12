package com.edsolabs.dfy_mobile.data.model

data class WalletModel(
    var walletName: String,
    val walletAddress: String,
    val seedPhrase: String,
    val privateKey: String,
    val isImportWallet: Boolean = false,
)
