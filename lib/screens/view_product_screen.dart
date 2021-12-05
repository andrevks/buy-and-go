import 'package:buy_and_go/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({
    Key? key,
    required this.imageLink,
    required this.productId,
    required this.price,
  }) : super(key: key);
  final String productId;
  final double price;
  final String imageLink;

  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  // @override void initState() {
  //   nameController = TextEditingController(text: widget.productId);
  //   priceController = TextEditingController(text: widget.price.toString());
  //   super.initState();
  // }

  // late TextEditingController nameController;
  // late TextEditingController priceController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xFF36311f),
        title: Text("Informações do Produto"),
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
                    Image.network(widget.imageLink),
                    SizedBox(height: 40),
                    Text(
                      "${widget.productId}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 3,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "R\$ ${widget.price}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 3,
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
