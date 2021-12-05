import 'dart:ffi';

import 'package:buy_and_go/models/database.dart';
import 'package:buy_and_go/screens/edit_product_screen.dart';
import 'package:buy_and_go/screens/edit_screen.dart';
import 'package:buy_and_go/screens/view_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListProductsScreen extends StatefulWidget {
  const ListProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ListProductsScreenState createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  @override
  void initState() {
    // nameController = TextEditingController(text: widget.name);
    // socialMediaController = TextEditingController(text: widget.socialMedia);
    super.initState();
  }

  // late TextEditingController nameController;
  // late TextEditingController socialMediaController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.productList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Não existe dados no Firebase!!!");
        } else if (snapshot.hasData || snapshot.data != null) {
          print('TEM SNAPSHOT');
          return Scaffold(
            appBar: AppBar(
              title: Text('Produtos Disponíveis'),
            ),
            body: Form(
              child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String productId = snapshot.data!.docs[index].id;
                  String imageLink = snapshot.data!.docs[index].get('image');
                  double price = snapshot.data!.docs[index].get('price');
                  return InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(imageLink),
                      decoration: BoxDecoration(
                          // color: Colors.red[400],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProductScreen(
                              productId: productId,
                              price: price,
                            ))),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                shrinkWrap: true,
              ),
            ),
          );
        } else {
          print("CONTAINER VAZIO CRIADO");
          return Container();
        }
      },
    );
  }
}
