import 'package:buy_and_go/models/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerSocialMedia = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

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
                  'Registrar Compra',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 30,
                ),
                // TextFormField(
                //   controller: _controllerDate,
                //   decoration: InputDecoration(
                //     labelText: 'Data da compra',
                //     labelStyle: const TextStyle(color: Colors.blue),
                //     hintText: 'Informe a data da compra',
                //   ),
                // ),
                TextFormField(
                  controller: _controllerTotalPrice,
                  decoration: InputDecoration(
                    labelText: 'Preço Total',
                    labelStyle: const TextStyle(color: Colors.blue),
                    hintText: 'Informe o Preço Total',
                  ),
                ),
                // TextFormField(
                //   controller: _controllerAge,
                //   decoration: InputDecoration(
                //     labelText: 'Idade',
                //     labelStyle: TextStyle(color: Colors.blue),
                //     hintText: 'Informe a idade',
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    String stringDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    Database.addToShoppingList(
                      date: stringDate,
                      totalPrice: double.parse(_controllerTotalPrice.text),
                      // age: _controllerAge.text.isEmpty
                      //     ? null
                      //     : int.parse(_controllerAge.text),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Adicionar Compra"),
                )
              ],
            ),
          ],
        ),
      )),

      // body: Form(
      //     child: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: ListView(
      //     children: [
      //       Column(
      //         children: [
      //           SizedBox(
      //             height: 30,
      //           ),
      //           Text(
      //             'Cadastro de Estudantes',
      //             style: TextStyle(
      //               fontSize: 30,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //           Container(
      //             height: 30,
      //           ),
      //           TextFormField(
      //             controller: _controllerName,
      //             decoration: InputDecoration(
      //               labelText: 'Nome do Estudante',
      //               labelStyle: const TextStyle(color: Colors.blue),
      //               hintText: 'Inform o nome do estudante',
      //             ),
      //           ),
      //           TextFormField(
      //             controller: _controllerSocialMedia,
      //             decoration: InputDecoration(
      //               labelText: 'Redes Sociais',
      //               labelStyle: const TextStyle(color: Colors.blue),
      //               hintText: 'Informe a rede social',
      //             ),
      //           ),
      //           TextFormField(
      //             controller: _controllerAge,
      //             decoration: InputDecoration(
      //               labelText: 'Idade',
      //               labelStyle: TextStyle(color: Colors.blue),
      //               hintText: 'Informe a idade',
      //             ),
      //           ),
      //           SizedBox(
      //             height: 40,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               Database.addStudent(
      //                 name: _controllerName.text,
      //                 socialMedia: _controllerSocialMedia.text,
      //                 age: _controllerAge.text.isEmpty
      //                     ? null
      //                     : int.parse(_controllerAge.text),
      //               );
      //               Navigator.of(context).pop();
      //             },
      //             child: Text("Adicionar Estudante"),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // )),
    );
  }
}
