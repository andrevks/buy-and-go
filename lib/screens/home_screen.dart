import 'package:buy_and_go/screens/crud_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(CrudScreen());
    pageList.add(Container(color: Colors.black87));
    pageList.add(Container(
      color: Colors.blue.shade500,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: page,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp),
            label: "Categorias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Carrinho",
          )
        ],
        currentIndex: page,
        selectedItemColor: Colors.blue,
        onTap: _selectedItem,
      ),
    );
  }

  void _selectedItem(int index) {
    setState(() {
      page = index;
    });
  }
}
