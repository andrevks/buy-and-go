import 'package:buy_and_go/models/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class AddPurchaseScreen extends StatefulWidget {
  const AddPurchaseScreen({Key? key}) : super(key: key);

  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerTotalPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Gerar Compra',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    generateProduct();
                    Navigator.of(context).pop();
                  },
                  child: Text("Gerar Compra"),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  void generateProduct() async {
    List<Map<String, dynamic>> allProducts = await Database.getData();

    print("-----------------------");
    print("LENGTH: ${allProducts.length}");

    int len = allProducts.length;

    var rng = Random();
    int nItems = 1;
    for (int i = 0; i < 20; i++) {
      nItems = rng.nextInt(len);
      if (nItems > 0) {
        print("Number of Items: $nItems");
        break;
      }
    }

    print("-----------------------\n");

    double totalPrice = 0.0;
    List<Map<String, dynamic>> purchasedItems = [];
    for (int i = 0; i < nItems; i++) {
      Map<String, dynamic> element = allProducts[rng.nextInt(len)];

      if (purchasedItems.contains(element)) {
        print('${element['name']} is present in the list $purchasedItems');
        element['qty'] += 1;
      } else {
        print('${element['name']} is not present in the list$purchasedItems');
        element['qty'] = 1;
        purchasedItems.add(element);
      }
    }

    print("productsBought:$purchasedItems");

    totalPrice = purchasedItems.fold(0, (prev, element) {
      double actualPrice = (element['qty'] * element['price']);
      print("actualPrice: $actualPrice");
      return prev + actualPrice;
    });

    print("totalPrice $totalPrice");
    String stringDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Database.addToShoppingList(
        date: stringDate, totalPrice: totalPrice, products: purchasedItems);
  }
}
