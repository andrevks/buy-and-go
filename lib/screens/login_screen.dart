import 'package:buy_and_go/models/database.dart';
import 'package:buy_and_go/screens/crud_screen.dart';
import 'package:buy_and_go/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String texto;
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: Database.initializerFirebase(),
          builder: (context, snapshot) {
            return Form(
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 30, left: 15, right: 15, top: 40),
                        child: TextFormField(
                          controller: _userIdController,
                          style: TextStyle(color: Colors.indigo),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "Nome do usuário",
                            hintText: "Informe o identificador do usuário",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 30, left: 15, right: 15),
                        child: TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.indigo),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "Senha do usuário",
                            hintText: "Informe a senha do usuário",
                          ),
                          obscureText: true,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Database.userId = _userIdController.text;
                          Database.signIn(
                              userName: _userIdController.text,
                              password: _passwordController.text,
                              onFail: () {
                                ScaffoldMessenger(
                                  child: SnackBar(
                                    content: Text('Falha ao autenticar'),
                                  ),
                                );
                              },
                              onSuccess: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              });
                          debugPrint(
                              "${_userIdController.text} realizou login");
                        },
                        child: Text("Realizar Login"),
                      ),
                      TextButton(
                        onPressed: () {
                          Database.signUp(
                              userName: _userIdController.text,
                              password: _passwordController.text,
                              onFail: () {
                                ScaffoldMessenger(
                                  child: SnackBar(
                                    content: Text('Falha ao autenticar'),
                                  ),
                                );
                              },
                              onSuccess: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => CrudScreen(),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Registrar-se",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
