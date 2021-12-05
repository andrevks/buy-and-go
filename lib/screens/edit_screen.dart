import 'package:buy_and_go/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {Key? key,
      required this.name,
      required this.socialMedia,
      required this.id})
      : super(key: key);
  final String id;
  final String name;
  final String socialMedia;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    socialMediaController = TextEditingController(text: widget.socialMedia);
    super.initState();
  }

  late TextEditingController nameController;
  late TextEditingController socialMediaController;
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
              Database.deleteStudent(widget.id);
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
                    Text("Rede Social:"),
                    TextFormField(
                      controller: socialMediaController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Database.updateStudent(widget.id,
                              nameController.text, socialMediaController.text);
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
