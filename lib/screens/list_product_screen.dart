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

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({
    Key? key,
    required this.purchaseId,
  }) : super(key: key);

  final String purchaseId;

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
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
      stream: Database.productListFromUser(widget.purchaseId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Não existe dados no Firebase!!!");
        } else if (snapshot.hasData || snapshot.data != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('GridView Demo'),
            ),
            body: Form(
              child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String productId = snapshot.data!.docs[index].id;
                  // String date = snapshot.data!.docs[index].get('date');
                  double price = snapshot.data!.docs[index].get('price');
                  return ListTile(
                    title: Text("$productId"),
                    subtitle: Text("R\$ $price"),
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         ListProductScreen(purchaseId: purchaseId))),
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => EditScreen(
                    //       id: docId, name: name, socialMedia: socialMedia),
                    // )),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                shrinkWrap: true,
                // children: [
                //   Image.network('https://picsum.photos/250?image=1'),
                //   Image.network('https://picsum.photos/250?image=2'),
                //   Image.network('https://picsum.photos/250?image=3'),
                //   Image.network('https://picsum.photos/250?image=4'),
                //   Image.network('https://picsum.photos/250?image=1'),
                //   Image.network('https://picsum.photos/250?image=2'),
                //   Image.network('https://picsum.photos/250?image=3'),
                //   Image.network('https://picsum.photos/250?image=4'),
                //   Image.network('https://picsum.photos/250?image=1'),
                //   Image.network('https://picsum.photos/250?image=2'),
                //   Image.network('https://picsum.photos/250?image=3'),
                //   Image.network('https://picsum.photos/250?image=4'),

                // Center(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // Text(
                //       //   "Id: ${widget.id}",
                //       //   style: TextStyle(fontWeight: FontWeight.bold),
                //       // ),
                //       SizedBox(height: 5),
                //       Text("id:${widget.purchaseId}"),
                //       // TextFormField(
                //       //   controller: nameController,
                //       //   keyboardType: TextInputType.text,
                //       //   textInputAction: TextInputAction.next,
                //       // ),
                //       SizedBox(height: 30),
                //       Text("Rede Social:"),
                //       // TextFormField(
                //       //   controller: socialMediaController,
                //       //   keyboardType: TextInputType.text,
                //       //   textInputAction: TextInputAction.next,
                //       // ),
                //       SizedBox(
                //         height: 30,
                //       ),
                //       // Center(
                //       //   child: ElevatedButton(
                //       //     onPressed: () async {
                //       //       await Database.updateStudent(widget.id,
                //       //           nameController.text, socialMediaController.text);
                //       //       Navigator.of(context).pop();
                //       //     },
                //       //     child: Text(
                //       //       "Atualizar Dados",
                //       //       style: TextStyle(
                //       //         fontSize: 20,
                //       //         fontWeight: FontWeight.bold,
                //       //         color: Colors.black,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                // ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },

      // body: GridView(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //   ),
      //   children: [
      //     Image.network('https://picsum.photos/250?image=1'),
      //     Image.network('https://picsum.photos/250?image=2'),
      //     Image.network('https://picsum.photos/250?image=3'),
      //     Image.network('https://picsum.photos/250?image=4'),
      //   ],
      // ),
    );
  }
}
