
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import '../../hive/ID.dart';
import '../../hive/boxes.dart';
import '../../input_formatters/card_month_input_formatter.dart';

class AddIdPage extends StatefulWidget {
  const AddIdPage({super.key});

  @override
  State<AddIdPage> createState() => _AddIdPageState();
}

class _AddIdPageState extends State<AddIdPage> {
  final _addCardFormKey = GlobalKey<FormState>();
  String cardTypePath = '';
  String? genderValue;
  //Controllers
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressDateController = TextEditingController();
  TextEditingController jopController = TextEditingController();
  final CreditCardValidator _ccValidator = CreditCardValidator();

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
              buildAddress(),
              buildjop(),
              Row(
                children: [
                  Expanded(
                    child: buildDateOfBirth(),
                  ),
                  Expanded(
                    child: buildExpiryDate(),
                  ),
                ],
              ),
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
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
            icon: SizedBox(
              width: 23,
              child: Icon(Icons.credit_card),
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
            if (_ccValidator.validateCCNum(value).isValid) {
              return 'Credit Card Number is invalid';
            }
            return null;
          },
        ),
      );

  Widget buildExpiryDate() => Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: expiryDateController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Expiry Date',
          hintText: '12/26',
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
  Widget buildSubmitButton() {
    return Container(
      width: 400,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          submit();
        },
        child: const Text(
          'submit',
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
          labelText: 'Name of Id Card ',
          border: OutlineInputBorder(),
          icon: SizedBox(
            width: 23,
            child: Icon(Icons.person),
          ),
        ),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zا-ي\s]'))
        ],
        validator: (value) {
          if (value == null || value.length < 2) {
            return 'Name must contain at least 2 digits';
          }
          return null;
        },
      ));

  Widget buildAddress() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: addressDateController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Address ',
          border: OutlineInputBorder(),
          icon: SizedBox(
            width: 23,
            child: Icon(Icons.location_on),
          ),
        ),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zأ-ي1-9\s]'))
        ],
        validator: (value) {
          if (value == null || value.length < 10) {
            return 'address must contain at least 10 digits';
          }
          return null;
        },
      ));Widget buildjop() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: jopController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Jop ',
          border: OutlineInputBorder(),
          icon: SizedBox(
            width: 23,
            child: Icon(Icons.work_outline),
          ),
        ),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zأ-ي1-9\s]'))
        ],
        validator: (value) {
          if (value == null || value.length < 4) {
            return 'Jop must contain at least 10 digits';
          }
          return null;
        },
      ));

  Widget buildDateOfBirth() => Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: dateOfBirthController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'DateOfBirth',
          border: OutlineInputBorder(),
          icon: SizedBox(
            // width: 25,
            child: Icon(Icons.date_range),
          ),
        ),
        maxLength: 8,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CardMonthInputFormatter()
        ],
        validator: (value) {
          ValidationResults datavalidator =
              _ccValidator.validateExpDate(value!);
          if (value.length < 8) {
            return 'Invalid Date';
          }
          if (datavalidator.isValid) {
            return 'Date is invalid';
          }
          return null;
        },
      ));
  submit() {
    bool? isValid = _addCardFormKey.currentState?.validate();
    bool? cardExists = boxId.containsKey(cardNumberController.text);
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
      Id newCard = Id(
        idNumber: cardNumberController.text,
        ExpiryDate: expiryDateController.text,
        cardHolderName: cardHolderNameController.text,
        DateOfBirth: dateOfBirthController.text,
        Addres: addressDateController.text,
       Jop: jopController.text,
        cardType: cardNumberController.text,
      );
      setState(() {
        boxId
            .put(cardNumberController.text, newCard)
            .then((value) => Navigator.pop(context));
      });
    }
  }
}
