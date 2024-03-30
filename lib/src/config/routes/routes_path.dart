import 'package:flutter/material.dart';
import '../../pages/cards_page/pages/credit_cards_pages/credit_card_page.dart';
import '../../pages/cards_page/pages/id_pages/id_Page.dart';
import '../../pages/registry/Home.dart';
import '../../pages/registry/login.dart';
import '../../pages/registry/signup.dart';
import 'route_names.dart';

class RoutesPath {
  static final routes = <String, WidgetBuilder>{
    Routes.homePage: (context) => const HomePage(),
    Routes.idPage: (context) => const IdPage(),
    Routes.creditCardPage: (context) => const CreditCardPage(),
    Routes.loginPage: (context) => const LoginPage(),
    Routes.signupPage: (context) =>  SignupPage(),




  };
}
