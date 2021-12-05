import 'dart:ffi';

import 'package:buy_and_go/models/database.dart';
import 'package:buy_and_go/screens/edit_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class ListProductScreen extends StatelessWidget {
//   final String purchaseId;
//   ListProductScreen({Key key, required this.purchaseId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Database.productListFromUser(purchaseId),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("Não existe dados no Firebase!!!");
//         } else if (snapshot.hasData || snapshot.data != null) {
//           return ListView.separated(
//             itemCount: snapshot.data!.docs.length,
//             separatorBuilder: (context, index) => SizedBox(
//               height: 5,
//             ),
//             itemBuilder: (context, index) {
//               String docId = snapshot.data!.docs[index].id;
//               double price = snapshot.data!.docs[index].get('price');
//               return ListTile(
//                 title: Text("Produto: $docId"),
//                 subtitle: Text("Preço: $price"),
//                 // onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                 //   builder: (context) => EditScreen(
//                 //       id: docId, name: name, socialMedia: socialMedia),
//                 // )),
//               );
//             },
//           );
//         } else {
//           return Container();
//         }
//       },
//     );

//     // return StreamBuilder<QuerySnapshot>(
//     //   stream: Database.studentsList(),
//     //   builder: (context, snapshot) {
//     //     if (snapshot.hasError) {
//     //       return Text("Não existe dados no Firebase!!!");
//     //     } else if (snapshot.hasData || snapshot.data != null) {
//     //       return ListView.separated(
//     //         itemCount: snapshot.data!.docs.length,
//     //         separatorBuilder: (context, index) => SizedBox(
//     //           height: 5,
//     //         ),
//     //         itemBuilder: (context, index) {
//     //           String docId = snapshot.data!.docs[index].id;
//     //           String name = snapshot.data!.docs[index].get('name');
//     //           String socialMedia =
//     //               snapshot.data!.docs[index].get('socialMedia');
//     //           return ListTile(
//     //             title: Text("nome: $name"),
//     //             subtitle: Text("Redes Sociais: $socialMedia"),
//     //             onTap: () => Navigator.of(context).push(MaterialPageRoute(
//     //               builder: (context) => EditScreen(
//     //                   id: docId, name: name, socialMedia: socialMedia),
//     //             )),
//     //           );
//     //         },
//     //       );
//     //     } else {
//     //       return Container();
//     //     }
//     //   },
//     // );
//   }
// }

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.purchaseId,
  }) : super(key: key);

  final String purchaseId;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
