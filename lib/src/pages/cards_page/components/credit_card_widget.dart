import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import '../hive/credit_card.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key, required this.creditCardData});

  final CreditCard creditCardData;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        margin: const EdgeInsets.fromLTRB(13, 10, 13, 10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.black87,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.view_compact_alt_rounded,
                color: Colors.amberAccent,
              ),
            ),
            Text(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              creditCardData.cardNumber,
            ),
            Text(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              creditCardData.cardHolderName,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'VALID THRU ',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        style: const TextStyle(color: Colors.white60),
                        creditCardData.expiryDate,
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(10),
                    child: buildCardTypeImage(creditCardData.cardType)),
              ],
            ),
          ],
        ),
      ),
      back: Container(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
        height: 195,
        width: 90,
        decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'CVV ',
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              alignment: Alignment.center,
              width: 300,
              height: 40,
              margin: const EdgeInsets.all(10),
              child: Text(

                style: const TextStyle(color: Colors.white),
                creditCardData.cvv,
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Text(creditCardData.countryFlagEmoji))
          ],
        ),
      ),
    );
  }

  Widget buildCardTypeImage(String? cardTypeString) {
    List<String> validImageStrings = <String>[
      'americanExpress',
      'dinersClub',
      'discover',
      'jcb',
      'mastercard',
      'unionpay',
      'verve',
      'visa',
      'meeza',
    ];

    // Checks if card type exists as an image in assets other return credit card
    // Icon
    for (String cType in validImageStrings) {
      if (cType == cardTypeString) {
        return SizedBox(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/$cardTypeString.png', width: 20));
      }
    }
    return const SizedBox(
      height: 30,
      width: 20,
      child: Icon(
        Icons.credit_card,
        color: Colors.white,
      ),
    );
  }
}
