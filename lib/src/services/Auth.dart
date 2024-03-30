import 'package:mot3lqat/src/pages/registry/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/cards_page/pages/credit_cards_pages/credit_card_page.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot){
          if(snapshot.hasData){
            return const CreditCardPage();
          }else{
            return const LoginPage();
          }

        }),
      ),
    );

  }
  
}