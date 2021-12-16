package com.edsolabs.dfy_mobile.data.local.prefs

import android.content.Context
import android.content.SharedPreferences
import com.edsolabs.dfy_mobile.data.helper.JsonHelper
import com.edsolabs.dfy_mobile.data.model.NftModel
import com.edsolabs.dfy_mobile.data.model.TokenModel
import com.edsolabs.dfy_mobile.data.model.WalletModel
import jp.takuji31.koreference.KoreferenceModel
import jp.takuji31.koreference.booleanPreference
import jp.takuji31.koreference.stringPreference

open class AppPreference(sharedPreferences: SharedPreferences) :
    KoreferenceModel(sharedPreferences) {

    companion object {
        const val STT_WALLET_DEFAULT = 1
    }

    constructor(context: Context) : this(
        context.applicationContext.getSharedPreferences(
            context.packageName, Context.MODE_PRIVATE
        )
    )

    fun clearAll() {
        sharedPreferences.edit().clear().apply()
    }

    var isAppLock: Boolean by booleanPreference(true)
    var isFaceID: Boolean by booleanPreference(false)
    var password: String by stringPreference("")

    var seedPhrase: String by stringPreference("")

    private var listWallet: String by stringPreference("")

    private var listTokenSupport: String by stringPreference("")
    var listNft: String by stringPreference("")

    fun earseAllWallet() {
        listWallet = ""
    }

    fun getListWallet(): List<WalletModel> {
        return JsonHelper.getList(listWallet, WalletModel::class.java)
    }

    fun saveListWallet(data: List<WalletModel>) {
        listWallet = JsonHelper.saveList(data, WalletModel::class.java)
    }

    fun getListTokens(): List<TokenModel> {
        return JsonHelper.getList(listTokenSupport, TokenModel::class.java)
    }

    fun saveListTokens(data: List<TokenModel>) {
        listTokenSupport = JsonHelper.saveList(data, TokenModel::class.java)
    }

    fun getListNft(): List<NftModel> {
        return JsonHelper.getList(listNft, NftModel::class.java)
    }

    fun saveListNft(data: List<NftModel>) {
        listNft = JsonHelper.saveList(data, NftModel::class.java)
    }
}