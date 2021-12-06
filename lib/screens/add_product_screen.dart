import 'package:buy_and_go/models/database.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              'Cadastro de Produto',
              style: TextStyle(fontSize: 30),
            ),
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(
                labelText: 'Nome do Produto',
                labelStyle: TextStyle(color: Colors.blue),
                hintText: 'Informe o nome do produto',
              ),
            ),
            // TextFormField(
            //   controller: _controllerImage,
            //   decoration: InputDecoration(
            //     labelText: 'Redes Sociais',
            //     labelStyle: TextStyle(color: Colors.blue),
            //     hintText: 'Informe a rede social',
            //   ),
            // ),
            TextFormField(
              controller: _controllerPrice,
              decoration: InputDecoration(
                labelText: 'Preço do produto',
                labelStyle: TextStyle(color: Colors.blue),
                hintText: 'Informe o preço do produto',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                print('Botão ADICIONAR PRODUTO APERTADO!');
                // Database.addStudent(
                //     name: _controllerName.text,
                //     socialMedia: _controllerSocialMedia.text,
                //     age: _controllerAge.text.isEmpty
                //         ? null
                //         : int.parse(_controllerAge.text),
                //     sex: _controllerSex.text.isEmpty
                //         ? " "
                //         : _controllerSex.text);
                Database.addProduct(
                    name: _controllerName.text,
                    price: double.parse(_controllerPrice.text));
                Navigator.of(context).pop();
              },
              child: Text("Adicionar Produto"),
            )
          ],
        ),
      )),
    );
  }
}
