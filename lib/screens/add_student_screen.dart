import 'package:buy_and_go/models/database.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerSocialMedia = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

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
                  'Cadastro de Estudantes',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 30,
                ),
                TextFormField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    labelText: 'Nome do Estudante',
                    labelStyle: const TextStyle(color: Colors.blue),
                    hintText: 'Inform o nome do estudante',
                  ),
                ),
                TextFormField(
                  controller: _controllerSocialMedia,
                  decoration: InputDecoration(
                    labelText: 'Redes Sociais',
                    labelStyle: const TextStyle(color: Colors.blue),
                    hintText: 'Informe a rede social',
                  ),
                ),
                TextFormField(
                  controller: _controllerAge,
                  decoration: InputDecoration(
                    labelText: 'Idade',
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Informe a idade',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Database.addStudent(
                      name: _controllerName.text,
                      socialMedia: _controllerSocialMedia.text,
                      age: _controllerAge.text.isEmpty
                          ? null
                          : int.parse(_controllerAge.text),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Adicionar Estudante"),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
