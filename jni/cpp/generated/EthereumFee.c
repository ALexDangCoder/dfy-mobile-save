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

#include <TrustWalletCore/TWEthereumFee.h>

#include "TWJNI.h"
#include "EthereumFee.h"

jstring JNICALL Java_wallet_core_jni_EthereumFee_suggest(JNIEnv *env, jclass thisClass, jstring feeHistory) {
    TWString *feeHistoryString = TWStringCreateWithJString(env, feeHistory);
    jstring result = NULL;
    TWString *resultString = TWEthereumFeeSuggest(feeHistoryString);

    if (resultString == NULL) {
        goto cleanup;
    }
    result = TWStringJString(resultString, env);

cleanup:
    TWStringDelete(feeHistoryString);
    return result;
}

