import 'package:firebase_auth/firebase_auth.dart';
import 'package:mot3lqat/src/config/routes/route_names.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/hive.dart' as hive_models;
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mot3lqat/src/pages/cards_page/hive/ID.dart';
import '../../components/Id_widget.dart';
import '../../hive/boxes.dart';
import 'add_ID_page.dart';


class IdPage extends StatefulWidget {
  const IdPage({super.key});

  @override
  State<IdPage> createState() => _IdPageState();
}

class _IdPageState extends State<IdPage> {
  Box<hive_models.Country> boxCountries =
      Hive.box<hive_models.Country>('countryBox');

  void addCountry(Country country) {
    hive_models.Country newCountry = hive_models.Country(
        code: country.countryCode,
        name: country.name,
        flagEmoji: country.flagEmoji);
    setState(() {
      boxCountries.put(country.countryCode, newCountry);
    });
  }

  void deleteCountry(int index) {
    setState(() {
      boxCountries.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ID'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(children: [
                Text(style: TextStyle(fontSize: 20), 'Options'),
                Icon(Icons.menu_open_rounded)
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card_rounded),
              title: const Text('Cards'),
              onTap: () {
                Navigator.pushNamed(context, Routes.creditCardPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('ID'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IdPage(),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.output_outlined),
              title: const Text('SignOut'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginPage,
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddIdPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: boxId.listenable(),
        builder: (context, box, widget) {
          if (boxId.isEmpty) {
            return const Center(
                child: Text(
              'You currently have no id cards',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: boxId.length,
            itemBuilder: (BuildContext context, int index) {
              Id cCard = boxId.getAt(index);
              return Stack(
                children: <Widget>[
                  IdWidget(
                    IdData: cCard,
                  ),

                  Container(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton.small(
                        splashColor: Colors.amber,
                        backgroundColor: Colors.red[400],
                        onPressed: () {
                          setState(() {
                            boxId.deleteAt(index);
                          });
                        },
                        child: const Icon(Icons.delete),
                      ))
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
    );
  }
}
