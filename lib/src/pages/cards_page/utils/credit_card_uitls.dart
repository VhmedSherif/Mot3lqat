import 'package:flutter/material.dart';

enum CreditCardType {
  mastercard,
  meeza,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  other,
  invalid,
  // Couldn't find a working pattern for elo, hipercard and rupay
  // elo,
  // hipercard,
  // rupay,
  unionpay
}

class CardUtils {
  static CreditCardType getCreditCardType(String input) {
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      return CreditCardType.mastercard;
    } if (input.startsWith(RegExp(
        r'[50]'))) {
      return CreditCardType.meeza;
    }
    if (input.startsWith(RegExp(r'[4]'))) return CreditCardType.visa;
    if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      return CreditCardType.verve;
    }
    if (input.startsWith(RegExp(r'((34)|(37))'))) {
      return CreditCardType.americanExpress;
    }
    if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      return CreditCardType.discover;
    }
    if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      return CreditCardType.dinersClub;
    }
    if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      return CreditCardType.jcb;
    }
    if (input.startsWith(RegExp(r'(62)'))) {
      return CreditCardType.unionpay;
    }
    // if (input.startsWith(RegExp(r'6(?!011)(?:0[0-9]{14}|52[12][0-9]{12})'))) {
    //   return CardType.rupay;
    // }

    // if (input.startsWith(RegExp(r'(606282\d{10}(\d{3})?)|(3841(0|4|6)0\d{13})'))) {
    //   return CardType.hipercard;
    // }
    // if (input.startsWith(RegExp(
    //     r'(4(0117[89]|3(1274|8935)|5(1416|7(393|63[12])))|50(4175|6(699|7([0-6]\d|7[0-8]))|9\d{3})|6(27780|36(297|368)|5(0(0(3[1-35-9]|4\d|5[01])|4(0[5-9]|([1-3]\d|8[5-9]|9\d))|5([0-2]\d|3[0-8]|4[1-9]|[5-8]\d|9[0-8])|7(0\d|1[0-8]|2[0-7])|9(0[1-9]|[1-6]\d|7[0-8]))|16(5[2-9]|[67]\d)|50([01]\d|2[1-9]|[34]\d|5[0-8]))))'))) {
    //   return CardType.elo;
    // }

    //Todo: Not returning correct icon when length is larger than 8 
    if (input.length >= 8) return CreditCardType.other;
    return CreditCardType.invalid;
  }

  static Widget getCreditCardIcon(String type) {
    //Return Credit card type image from assets or Icon if invalid or other
    CreditCardType cardType = getCreditCardType(type);
    if (cardType == CreditCardType.other) return const Icon(Icons.credit_card);
    if (cardType == CreditCardType.invalid) {
      return const Icon(Icons.credit_card_off);
    }
    String typeString = cardType.name;
    return Image.asset('assets/images/$typeString.png');
  }
}
