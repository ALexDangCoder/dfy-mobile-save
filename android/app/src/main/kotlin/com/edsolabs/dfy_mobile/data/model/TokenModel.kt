package com.edsolabs.dfy_mobile.data.model

data class TokenModel(
    val walletAddress: String,
    val tokenAddress: String,
    val tokenFullName: String,
    val iconToken: String,
    val symbol: String,
    val decimal: Int,
    var isShow: Boolean = true,
)