import 'package:mot3lqat/src/pages/cards_page/hive/ID.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/boxes.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/country.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/credit_card.dart';
import 'package:mot3lqat/src/services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mot3lqat/src/config/routes/routes_path.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/hive.dart' as hive_models;
import 'package:mot3lqat/src/config/routes/route_names.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CreditCardAdapter());
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(IdAdapter());
  boxCountries = await Hive.openBox<hive_models.Country>('countryBox');
  boxCreditCards = await Hive.openBox<CreditCard>('creditCardBox');
  boxId = await Hive.openBox<Id>('IdBox');

  runApp(const Mot3lqat());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Mot3lqat extends StatefulWidget {
  const Mot3lqat({super.key});

  @override
  State<Mot3lqat> createState() => _Mot3lqatState();
}

class _Mot3lqatState extends State<Mot3lqat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homePage,
      routes: RoutesPath.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(119, 153, 168, 90)),
        useMaterial3: true,
      ),
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const Auth(),
    );
  }
}
