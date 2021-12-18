// Copyright © 2017-2020 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
//
// This is a GENERATED FILE, changes made here WILL BE LOST.
//

#include <jni.h>
#include <stdio.h>
#include <string.h>

#include <TrustWalletCore/TWAccount.h>

#include "TWJNI.h"
#include "Account.h"

jlong JNICALL Java_wallet_core_jni_Account_nativeCreate(JNIEnv *env, jclass thisClass, jstring address, jobject coin, jstring derivationPath, jstring extendedPublicKey) {
    TWString *addressString = TWStringCreateWithJString(env, address);
    jclass coinClass = (*env)->GetObjectClass(env, coin);
    jmethodID coinValueMethodID = (*env)->GetMethodID(env, coinClass, "value", "()I");
    jint coinValue = (*env)->CallIntMethod(env, coin, coinValueMethodID);
    TWString *derivationPathString = TWStringCreateWithJString(env, derivationPath);
    TWString *extendedPublicKeyString = TWStringCreateWithJString(env, extendedPublicKey);
    struct TWAccount *instance = TWAccountCreate(addressString, coinValue, derivationPathString, extendedPublicKeyString);
    TWStringDelete(addressString);
    (*env)->DeleteLocalRef(env, coinClass);
    TWStringDelete(derivationPathString);
    TWStringDelete(extendedPublicKeyString);
    return (jlong) instance;
}

void JNICALL Java_wallet_core_jni_Account_nativeDelete(JNIEnv *env, jclass thisClass, jlong handle) {
    TWAccountDelete((struct TWAccount *) handle);
}

jstring JNICALL Java_wallet_core_jni_Account_address(JNIEnv *env, jobject thisObject) {
    jclass thisClass = (*env)->GetObjectClass(env, thisObject);
    jfieldID handleFieldID = (*env)->GetFieldID(env, thisClass, "nativeHandle", "J");
    struct TWAccount *instance = (struct TWAccount *) (*env)->GetLongField(env, thisObject, handleFieldID);

    jstring result = NULL;
    TWString *resultString = TWAccountAddress(instance);
    result = TWStringJString(resultString, env);

    (*env)->DeleteLocalRef(env, thisClass);
    return result;
}

jstring JNICALL Java_wallet_core_jni_Account_derivationPath(JNIEnv *env, jobject thisObject) {
    jclass thisClass = (*env)->GetObjectClass(env, thisObject);
    jfieldID handleFieldID = (*env)->GetFieldID(env, thisClass, "nativeHandle", "J");
    struct TWAccount *instance = (struct TWAccount *) (*env)->GetLongField(env, thisObject, handleFieldID);

    jstring result = NULL;
    TWString *resultString = TWAccountDerivationPath(instance);
    result = TWStringJString(resultString, env);

    (*env)->DeleteLocalRef(env, thisClass);
    return result;
}

jstring JNICALL Java_wallet_core_jni_Account_extendedPublicKey(JNIEnv *env, jobject thisObject) {
    jclass thisClass = (*env)->GetObjectClass(env, thisObject);
    jfieldID handleFieldID = (*env)->GetFieldID(env, thisClass, "nativeHandle", "J");
    struct TWAccount *instance = (struct TWAccount *) (*env)->GetLongField(env, thisObject, handleFieldID);

    jstring result = NULL;
    TWString *resultString = TWAccountExtendedPublicKey(instance);
    result = TWStringJString(resultString, env);

    (*env)->DeleteLocalRef(env, thisClass);
    return result;
}

jobject JNICALL Java_wallet_core_jni_Account_coin(JNIEnv *env, jobject thisObject) {
    jclass thisClass = (*env)->GetObjectClass(env, thisObject);
    jfieldID handleFieldID = (*env)->GetFieldID(env, thisClass, "nativeHandle", "J");
    struct TWAccount *instance = (struct TWAccount *) (*env)->GetLongField(env, thisObject, handleFieldID);

    enum TWCoinType result = TWAccountCoin(instance);


    (*env)->DeleteLocalRef(env, thisClass);

    jclass class = (*env)->FindClass(env, "wallet/core/jni/CoinType");
    jmethodID method = (*env)->GetStaticMethodID(env, class, "createFromValue", "(I)Lwallet/core/jni/CoinType;");
    return (*env)->CallStaticObjectMethod(env, class, method, (jint) result);
}

