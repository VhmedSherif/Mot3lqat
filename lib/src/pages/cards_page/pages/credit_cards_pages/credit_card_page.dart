import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../config/routes/route_names.dart';
import '../../components/components.dart';
import '../../hive/boxes.dart';
import '../../hive/credit_card.dart';
import '../id_pages/id_Page.dart';
import 'button_add_credit_card_page.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cards'),
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
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card_rounded),
              title: const Text('cards'),
              onTap: () {
                Navigator.pop(context);
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
      body: ValueListenableBuilder(
        valueListenable: boxCreditCards.listenable(),
        builder: (context, box, widget) {
          if (boxCreditCards.isEmpty) {
            return const Center(
                child: Text(
                  'You currently have no cards',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: boxCreditCards.length,
            itemBuilder: (BuildContext context, int index) {
              CreditCard cCard = boxCreditCards.getAt(index);
              return Stack(
                children: <Widget>[
                  CreditCardWidget(
                    creditCardData: cCard,
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton.small(
                        splashColor: Colors.amber,
                        backgroundColor: Colors.red[400],
                        onPressed: () {
                          setState(() {
                            boxCreditCards.deleteAt(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCardPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
