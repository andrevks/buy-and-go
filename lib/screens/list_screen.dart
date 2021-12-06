import 'dart:ffi';

import 'package:buy_and_go/models/database.dart';
import 'package:buy_and_go/screens/edit_screen.dart';
import 'package:buy_and_go/screens/list_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.shoppingList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Não existe dados no Firebase!!!");
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              String purchaseId = snapshot.data!.docs[index].id;
              String date = snapshot.data!.docs[index].get('date');
              double totalPrice = snapshot.data!.docs[index].get('totalPrice');
              return ListTile(
                title: Text(
                  "Preço Total: $totalPrice",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.6,
                ),
                subtitle: Text(
                  "Dia: $date",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.6,
                ),

                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ListProductScreen(purchaseId: purchaseId))),
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => EditScreen(
                //       id: docId, name: name, socialMedia: socialMedia),
                // )),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );

    // return StreamBuilder<QuerySnapshot>(
    //   stream: Database.studentsList(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Não existe dados no Firebase!!!");
    //     } else if (snapshot.hasData || snapshot.data != null) {
    //       return ListView.separated(
    //         itemCount: snapshot.data!.docs.length,
    //         separatorBuilder: (context, index) => SizedBox(
    //           height: 5,
    //         ),
    //         itemBuilder: (context, index) {
    //           String docId = snapshot.data!.docs[index].id;
    //           String name = snapshot.data!.docs[index].get('name');
    //           String socialMedia =
    //               snapshot.data!.docs[index].get('socialMedia');
    //           return ListTile(
    //             title: Text("nome: $name"),
    //             subtitle: Text("Redes Sociais: $socialMedia"),
    //             onTap: () => Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) => EditScreen(
    //                   id: docId, name: name, socialMedia: socialMedia),
    //             )),
    //           );
    //         },
    //       );
    //     } else {
    //       return Container();
    //     }
    //   },
    // );
  }
}
