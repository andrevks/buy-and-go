import 'package:buy_and_go/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen(
      {Key? key,
      required this.productId,
      required this.price,
      required this.name})
      : super(key: key);
  final String productId;
  final String name;
  final double price;

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price.toString());
    productIdController = TextEditingController(text: widget.productId);
    super.initState();
  }

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController productIdController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xFF36311f),
        title: Text("Persistência"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              print("DELETE pressed\n");
              // Database.deleteStudent(widget.id);
              Database.deleteProduct(widget.productId);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 60,
          right: 20,
          bottom: 10,
        ),
        child: Form(
          child: ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Id: ${widget.id}",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: 5),
                    Text("Nome:"),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 30),
                    Text("Preço:"),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          print("UPDATE pressed\n");
                          // await Database.updateStudent(widget.id,
                          //     nameController.text, priceController.text);
                          // Navigator.of(context).pop();
                          await Database.updateProduct(
                              widget.productId,
                              nameController.text,
                              double.parse(priceController.text));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Atualizar Dados",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
