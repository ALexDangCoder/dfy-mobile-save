package com.edsolabs.dfy_mobile.extension

import com.edsolabs.dfy_mobile.Numeric
import com.google.protobuf.ByteString
import java.math.BigInteger
import kotlin.experimental.and

fun String.handleAmount(decimal: Int): String {
    val parts = this.split(".")
    if (this.isEmpty()) {
        return "0"
    } else {
        if (parts.size == 1) {
            val buffer = StringBuffer()
            var size = 0
            while (size < decimal) {
                buffer.append("0")
                size++
            }
            return this + buffer.toString()
        } else if (parts.size > 1) {
            if (parts[1].length >= decimal) {
                return parts[0] + parts[1].substring(0, decimal)
            } else {
                val valueAmount = parts[0]
                val valueDecimal = parts[1]
                val buffer = StringBuffer()
                var size = valueDecimal.length
                while (size < decimal) {
                    buffer.append("0")
                    size++
                }
                return valueAmount + valueDecimal + buffer.toString()
            }
        } else {
            return "0"
        }
    }
}

fun String.hexStringToByteArray(): ByteArray {
    val HEX_CHARS = "0123456789ABCDEF"
    val result = ByteArray(length / 2)
    for (i in 0 until length step 2) {
        val firstIndex = HEX_CHARS.indexOf(this[i].toUpperCase());
        val secondIndex = HEX_CHARS.indexOf(this[i + 1].toUpperCase());
        val octet = firstIndex.shl(4).or(secondIndex)
        result.set(i.shr(1), octet.toByte())
    }
    return result
}

fun ByteArray.toHexString(withPrefix: Boolean = true): String {
    val stringBuilder = StringBuilder()
    if (withPrefix) {
        stringBuilder.append("0x")
    }
    for (element in this) {
        stringBuilder.append(String.format("%02x", element and 0xFF.toByte()))
    }
    return stringBuilder.toString()
}

fun BigInteger.toByteString(): ByteString {
    return ByteString.copyFrom(this.toByteArray())
}

fun String.toHexBytes(): ByteArray {
    return Numeric.hexStringToByteArray(this)
}
