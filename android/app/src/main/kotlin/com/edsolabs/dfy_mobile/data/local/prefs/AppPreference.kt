package com.edsolabs.dfy_mobile.data.local.prefs

import android.content.Context
import android.content.SharedPreferences
import com.edsolabs.dfy_mobile.data.helper.JsonHelper
import com.edsolabs.dfy_mobile.data.model.WalletModel
import jp.takuji31.koreference.KoreferenceModel
import jp.takuji31.koreference.intPreference
import jp.takuji31.koreference.stringPreference

open class AppPreference(sharedPreferences: SharedPreferences) :
    KoreferenceModel(sharedPreferences) {

    constructor(context: Context) : this(
        context.applicationContext.getSharedPreferences(
            context.packageName, Context.MODE_PRIVATE
        )
    )

    fun clearAll() {
        sharedPreferences.edit().clear().apply()
    }

    var sttWallet: Int by intPreference(default = 1)
    var listWallet: String by stringPreference("")

    fun setSttWallet(stt: Int): Int {
        this.sttWallet = stt
        return stt
    }


    fun getListWallet(): List<WalletModel> {
        return JsonHelper.getList(listWallet, WalletModel::class.java)
    }

    fun saveListWallet(data: List<WalletModel>) {
        listWallet = JsonHelper.saveList(data, WalletModel::class.java)
    }
}