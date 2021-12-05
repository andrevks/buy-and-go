import 'package:buy_and_go/screens/add_student_screen.dart';
import 'package:buy_and_go/screens/list_screen.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({Key? key}) : super(key: key);

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de Compras"),
      ),
      body: ListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddStudentScreen()));
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}
