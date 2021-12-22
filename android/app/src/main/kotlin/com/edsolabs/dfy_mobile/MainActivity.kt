package com.edsolabs.dfy_mobile

import com.edsolabs.dfy_mobile.extension.*
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }

    private val CHANNEL_TRUST_WALLET = "flutter/trust_wallet"

    private var channel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_TRUST_WALLET)
        channel?.setMethodCallHandler { call, _ ->
            when (call.method) {
                "checkPassword" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    this.checkPassWordWallet(channel = channel, password = password)
                }
                "changePassword" -> {
                    val oldPassword = call.argument<String>("oldPassword")
                        ?: return@setMethodCallHandler
                    val newPassword = call.argument<String>("newPassword")
                        ?: return@setMethodCallHandler
                    this.changePassWordWallet(
                        channel = channel,
                        oldPassword = oldPassword,
                        newPassword = newPassword
                    )
                }
                "savePassword" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    this.savePassWordWallet(channel = channel, password = password)
                }
                "getConfig" -> {
                    this.getConfigWallet(channel = channel)
                }
                "earseWallet" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    this.earseWallet(channel = channel, walletAddress = walletAddress)
                }
                "changeNameWallet" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val walletName =
                        call.argument<String>("walletName") ?: return@setMethodCallHandler
                    this.changeNameWallet(
                        channel = channel,
                        walletAddress = walletAddress,
                        walletName = walletName
                    )
                }
//                "earseAllWallet" -> {
//                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
//                    this.earseAllWallet(channel = channel, type = type)
//                }
                "importWallet" -> {
                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
                    val content = call.argument<String>("content")
                        ?: return@setMethodCallHandler
                    val typeEarseWallet = call.argument<String>("typeEarseWallet")
                        ?: ""
                    this.importWallet(
                        channel = channel,
                        type = type,
                        content = content,
                        typeEarseWallet = typeEarseWallet
                    )
                }
                "getListWallets" -> {
                    this.getListWallets(channel = channel)
                }
                "generateWallet" -> {
                    val typeEarseWallet =
                        call.argument<String>("typeEarseWallet") ?: ""
                    this.generateWallet(channel = channel, typeEarseWallet = typeEarseWallet)
                }
                "storeWallet" -> {
                    val seedPhrase =
                        call.argument<String>("seedPhrase") ?: return@setMethodCallHandler
                    val walletName =
                        call.argument<String>("walletName") ?: return@setMethodCallHandler
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val privateKey =
                        call.argument<String>("privateKey") ?: return@setMethodCallHandler
                    val typeEarseWallet =
                        call.argument<String>("typeEarseWallet") ?: ""
                    this.storeWallet(
                        channel = channel,
                        seedPhrase = seedPhrase,
                        walletName = walletName,
                        walletAddress = walletAddress,
                        privateKey = privateKey,
                        typeEarseWallet = typeEarseWallet,
                    )
                }
                "chooseWallet" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    this.chooseWallet(channel = channel, walletAddress = walletAddress)
                }
                "setConfig" -> {
                    val isAppLock =
                        call.argument<Boolean>("isAppLock") ?: true
                    val isFaceID =
                        call.argument<Boolean>("isFaceID") ?: false
                    this.setConfig(channel = channel, appLock = isAppLock, faceID = isFaceID)
                }
                "checkToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress") ?: return@setMethodCallHandler
                    this.checkToken(
                        channel = channel,
                        walletAddress = walletAddress,
                        tokenAddress = tokenAddress
                    )
                }
                "importToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress") ?: return@setMethodCallHandler
                    val tokenFullName =
                        call.argument<String>("tokenFullName") ?: return@setMethodCallHandler
                    val iconToken =
                        call.argument<String>("iconToken") ?: return@setMethodCallHandler
                    val symbol =
                        call.argument<String>("symbol") ?: return@setMethodCallHandler
                    val decimal =
                        call.argument<Int>("decimal") ?: return@setMethodCallHandler
                    val exchangeRate =
                        call.argument<Double>("exchangeRate") ?: return@setMethodCallHandler
                    val isImport =
                        call.argument<Boolean>("isImport") ?: return@setMethodCallHandler
                    this.importToken(
                        channel = channel,
                        walletAddress = walletAddress,
                        tokenAddress = tokenAddress,
                        tokenFullName = tokenFullName,
                        iconToken = iconToken,
                        symbol = symbol,
                        decimal = decimal,
                        exchangeRate = exchangeRate,
                        isImport = isImport
                    )
                }
                "importListToken" -> {
                    val jsonTokens =
                        call.argument<String>("jsonTokens")
                            ?: return@setMethodCallHandler
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    this.importListToken(
                        channel = channel,
                        walletAddress = walletAddress,
                        jsonTokens = jsonTokens
                    )
                }
                "setShowedToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress")
                            ?: return@setMethodCallHandler
                    val isShow =
                        call.argument<Boolean>("isShow")
                            ?: return@setMethodCallHandler
                    val isImport =
                        call.argument<Boolean>("isImport")
                            ?: return@setMethodCallHandler
                    this.setShowedToken(
                        channel = channel,
                        walletAddress = walletAddress,
                        tokenAddress = tokenAddress,
                        isShow = isShow,
                        isImport = isImport
                    )
                }
                "importNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val jsonNft =
                        call.argument<String>("jsonNft")
                            ?: return@setMethodCallHandler
                    this.importNft(
                        channel = channel,
                        jsonNft = jsonNft,
                        walletAddress = walletAddress
                    )
                }
                "deleteNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val collectionAddress =
                        call.argument<String>("collectionAddress")
                            ?: return@setMethodCallHandler
                    val nftId =
                        call.argument<String>("nftId")
                            ?: return@setMethodCallHandler
                    this.deleteNft(
                        channel = channel,
                        walletAddress = walletAddress,
                        collectionAddress = collectionAddress,
                        nftId = nftId
                    )
                }
                "deleteCollection" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val collectionAddress =
                        call.argument<String>("collectionAddress")
                            ?: return@setMethodCallHandler
                    this.deleteCollection(
                        channel = channel,
                        walletAddress = walletAddress,
                        collectionAddress = collectionAddress
                    )
                }
                "getTokens" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    this.getTokens(channel = channel, walletAddress = walletAddress)
                }
                "getNFT" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    this.getNFT(channel = channel, walletAddress = walletAddress)
                }
                "signTransactionToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val toAddress =
                        call.argument<String>("toAddress")
                            ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress")
                            ?: return@setMethodCallHandler
                    val nonce =
                        call.argument<String>("nonce")
                            ?: return@setMethodCallHandler
                    val chainId =
                        call.argument<String>("chainId")
                            ?: return@setMethodCallHandler
                    val gasPrice =
                        call.argument<String>("gasPrice")
                            ?: return@setMethodCallHandler
                    val gasLimit =
                        call.argument<String>("gasLimit")
                            ?: return@setMethodCallHandler
                    val amount =
                        call.argument<String>("amount")
                            ?: return@setMethodCallHandler
                    this.signTransactionToken(
                        channel = channel,
                        walletAddress = walletAddress,
                        tokenAddress = tokenAddress,
                        toAddress = toAddress,
                        nonce = nonce,
                        chainId = chainId,
                        gasPrice = gasPrice,
                        gasLimit = gasLimit,
                        amount = amount
                    )
                }
                "signTransactionNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val toAddress =
                        call.argument<String>("toAddress")
                            ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress")
                            ?: return@setMethodCallHandler
                    val nonce =
                        call.argument<String>("nonce")
                            ?: return@setMethodCallHandler
                    val chainId =
                        call.argument<String>("chainId")
                            ?: return@setMethodCallHandler
                    val gasPrice =
                        call.argument<String>("gasPrice")
                            ?: return@setMethodCallHandler
                    val gasLimit =
                        call.argument<String>("gasLimit")
                            ?: return@setMethodCallHandler
                    val tokenId =
                        call.argument<String>("tokenId")
                            ?: return@setMethodCallHandler
                    this.signTransactionNft(
                        channel = channel,
                        walletAddress = walletAddress,
                        tokenAddress = tokenAddress,
                        toAddress = toAddress,
                        nonce = nonce,
                        chainId = chainId,
                        gasPrice = gasPrice,
                        gasLimit = gasLimit,
                        tokenId = tokenId
                    )
                }
                "exportWallet" -> {
                    val password =
                        call.argument<String>("password")
                            ?: return@setMethodCallHandler
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    this.exportWallet(
                        channel = channel,
                        password = password,
                        walletAddress = walletAddress
                    )
                }
            }
        }
    }


}