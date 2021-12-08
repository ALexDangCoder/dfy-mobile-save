package com.edsolabs.dfy_mobile.data.model

data class TokenModel(
    val walletAddress: String,
    val tokenAddress: String,
    val tokenFullName: String,
    val iconUrl: String,
    val symbol: String,
    val decimal: Int,
    val exchangeRate: Double,
    var isShow: Boolean = true,
)