import 'dart:io';
import 'package:mot3lqat/src/pages/cards_page/hive/boxes.dart';
import 'package:mot3lqat/src/pages/cards_page/input_formatters/input_formatters.dart';
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/hive.dart' as hive_models;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../hive/credit_card.dart';
import '../../utils/credit_card_uitls.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  Box<hive_models.Country> boxCountries =
      Hive.box<hive_models.Country>('countryBox');
  final ImagePicker picker = ImagePicker();

  @override
  initState() {
    super.initState();
    for (hive_models.Country country in boxCountries.values) {
      savedBannedCountryCodes.add(country.code);
    }
  }

  List<String> savedBannedCountryCodes = <String>[];
  final _addCardFormKey = GlobalKey<FormState>();
  String cardTypePath = '';
  Widget issuer = CardUtils.getCreditCardIcon('');

  //Controllers
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  final CreditCardValidator _ccValidator = CreditCardValidator();

  Country selectedCountry = Country(
      phoneCode: '27',
      countryCode: 'ZA',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'South Africa',
      example: '711234567',
      displayName: 'South Africa (ZA) [+27]',
      displayNameNoCountryCode: 'South Africa (ZA)',
      e164Key: '27-ZA-0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _addCardFormKey,
          child: Column(
            children: <Widget>[
              buildName(),
              buildCardNumber(),
              Row(
                children: [
                  Expanded(
                    child: buildCVV(),
                  ),
                  Expanded(
                    child: buildDate(),
                  ),
                ],
              ),
              buildIssuingCountry(),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardNumber() => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
          controller: cardNumberController,
          onChanged: (value) {
            if (value.length > 4) return;
            setState(() {
              issuer = CardUtils.getCreditCardIcon(value);
            });
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Card Number',
            border: const OutlineInputBorder(),
            icon: SizedBox(
              width: 25,
              child: issuer,
            ),
          ),
          maxLength: 19,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(19),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Number on Card';
            }
            if (!_ccValidator.validateCCNum(value).isValid) {
              return 'Credit Card Number is invalid';
            }
            return null;
          },
        ),
      );

  Widget buildCVV() => Container(
      padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: cvvController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'CVV',
          border: OutlineInputBorder(),
          icon: SizedBox(
            // width: 25,
            child: Icon(Icons.numbers),
          ),
        ),
        maxLength: 4,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.length < 3 || value.length > 4) {
            return 'Invalid CVV';
          }
          return null;
        },
      ));

  Widget buildIssuingCountry() => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 25),
        child: Row(
          children: <Widget>[
            const Icon(Icons.flag),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 285,
                height: 50,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  onPressed: () {
                    pickCountry();
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCountry.flagEmoji),
                        Text(selectedCountry.name),
                        const Icon(Icons.arrow_drop_down)
                      ]),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildSubmitButton() {
    return Container(
      width: 400,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          submit();
        },
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget buildName() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: cardHolderNameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Name of Card Holder',
          border: OutlineInputBorder(),
          icon: SizedBox(
            width: 23,
            child: Icon(Icons.person),
          ),
        ),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\s]'))
        ],
        validator: (value) {
          if (value == null || value.length < 2) {
            return 'Name must contain at least 2 digits';
          }
          return null;
        },
      ));

  Widget buildDate() => Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: expiryDateController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Expiry Date',
          border: OutlineInputBorder(),
          icon: SizedBox(
            // width: 25,
            child: Icon(Icons.date_range),
          ),
        ),
        maxLength: 5,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CardMonthInputFormatter()
        ],
        validator: (value) {
          ValidationResults datavalidator =
              _ccValidator.validateExpDate(value!);
          if (value.length < 2) {
            return 'Invalid Date';
          }
          if (!datavalidator.isValid) {
            return 'Date is invalid';
          }
          return null;
        },
      ));


  Future scan() async {
    _addCardFormKey.currentState!.reset();
    await showDialoguePrompt(
        instructionText: 'Please scan front of card', onPress: autoFillFields);
    await showDialoguePrompt(
        instructionText: 'Please scan back of card', onPress: autoFillFields);
  }

  Future<void> autoFillFields() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    if (image != null) {
      final imagePath = File(image.path);
      final inputImage = InputImage.fromFile(imagePath);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      for (TextBlock block in recognizedText.blocks) {
        final String text = block.text;

        if (text.startsWith(RegExp('([0-9])')) &&
            text.length > 13 &&
            text.length < 20) {
          String formattedNumber =
              cardNumberController.text = text.replaceAll(' ', '').trim();
          setState(() {
            issuer = CardUtils.getCreditCardIcon(formattedNumber);
            cardNumberController.text = formattedNumber;
          });
        }
        if (text.length == 5 && text.contains('/')) {
          //checks date fromat
          expiryDateController.text = text;
        }
        if (num.tryParse(text) != null && //checks if string is a number
            text.length >= 3 &&
            text.length < 5) {
          cvvController.text = text;
        }
      }
    }
    textRecognizer.close();
  }

  Future<void> showDialoguePrompt(
      {required String instructionText, required Function onPress}) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shadowColor: Colors.blueAccent,
        title: Text(
          instructionText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {onPress(), Navigator.pop(context, 'OK')},
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Select Country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

  submit() {
    bool? isValid = _addCardFormKey.currentState?.validate();
    bool? cardExists = boxCreditCards.containsKey(cardNumberController.text);
    if (cardExists) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shadowColor: Colors.blueAccent,
          title: const Text(
            'Card Number already exists',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Please add card card with a different number',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (isValid != null && isValid && !cardExists) {
      CreditCard newCard = CreditCard(
          cardNumber: cardNumberController.text,
          expiryDate: expiryDateController.text,
          cardHolderName: cardHolderNameController.text,
          cvv: cvvController.text,
          countryFlagEmoji: selectedCountry.flagEmoji,
          cardType:
              CardUtils.getCreditCardType(cardNumberController.text).name);
      setState(() {
        boxCreditCards
            .put(cardNumberController.text, newCard)
            .then((value) => Navigator.pop(context));
      });
    }
  }
}
