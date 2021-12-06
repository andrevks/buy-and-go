import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

//FirebaseFirestore -> permite acesso as dados no FIREBASE
//através da obtenção da instância deste.
FirebaseFirestore _firestore = FirebaseFirestore.instance;
//Objeto para obter uma referência da coleção
CollectionReference _reference = _firestore.collection("academic");
CollectionReference _userReference = _firestore.collection("user");
CollectionReference _productReference = _firestore.collection("product");
CollectionReference _cartReference = _firestore.collection("cart");
CollectionReference _purchaseReference = _firestore.collection("purchase");

//inicialização da instância de autenticação no firebase
FirebaseAuth auth = FirebaseAuth.instance;

class Database {
  static late String userId;
  //método para realizar autenticação de usuário no firebase
  static signIn(
      {required String userName,
      required String password,
      required Function onFail,
      required Function onSuccess}) async {
    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: userName, password: password))
          .user;
      // userId = user.displayName;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      print("Erro na autenticação ${e.toString()}");
    } on PlatformException catch (p) {
      print(p.toString());
      onFail();
    }
  }

  //método para criação de usuário no firebase
  static signUp(
      {required String userName,
      required String password,
      required Function onFail,
      required Function onSuccess}) async {
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
              email: userName, password: password))
          .user;
      userId = user!.email.toString();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      print("Erro na autenticação ${e.toString()}");
    } on PlatformException catch (p) {
      print(p.toString());
      onFail();
    }
  }

  //método para adicionar dados no Firebase
  static addStudent(
      {required String name,
      required String socialMedia,
      String? sex,
      int? age}) async {
    DocumentReference documentReference =
        _reference.doc(userId).collection('students').doc();

    debugPrint("USERID >>>>> $userId");

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "socialMedia": socialMedia,
      "sex": sex,
      "age": age,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Estudante gravado com sucesso!!!"));
  }

  //método para adicionar dados no Firebase
  static addToShoppingList({
    required String date,
    required double totalPrice,
    required List<Map<String, dynamic>> products,
  }) async {
    // DocumentReference documentReference =
    CollectionReference shoppingListColReference =
        _userReference.doc(userId).collection('shoppingList');

    debugPrint("USERID >>>>> $userId");

    Map<String, dynamic> data = <String, dynamic>{
      "date": date,
      "totalPrice": totalPrice,
    };

    DocumentReference shoppingListSaved = await shoppingListColReference
        .add(data)
        .whenComplete(() => print("COMPRA gravada com sucesso!!!"));

    String shoppingId = shoppingListSaved.id;
    print("SHOPPING_SAVED: $shoppingId");

    CollectionReference purchaseCol =
        _purchaseReference.doc(shoppingListSaved.id).collection('products');

    for (Map<String, dynamic> product in products) {
      data = <String, dynamic>{
        "shoppingId": shoppingId,
        "name": product['name'],
        "image": product['image'],
        "price": product['price'],
        "qty": product['qty']
      };
      await purchaseCol.add(data).whenComplete(
          () => print("PRODUTO ${data['name']} gravado com sucesso!!!"));
    }
  }

  static Future<void> updateStudent(
      dynamic docId, String name, String socialMedia) async {
    DocumentReference documentReference =
        _reference.doc(userId).collection("students").doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "socialMedia": socialMedia,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("estudante atualizado com sucesso!!!"));
  }

  static Stream<QuerySnapshot> studentsList() {
    CollectionReference studentsCollection =
        _reference.doc(userId).collection('students');
    return studentsCollection.snapshots();
  }

  static Stream<QuerySnapshot> shoppingList() {
    CollectionReference userCollection =
        _userReference.doc(userId).collection('shoppingList');
    return userCollection.snapshots();
  }

  static Stream<QuerySnapshot> productListFromUser(String purchaseId) {
    print("ID>>> ${purchaseId}\n");

    // CollectionReference cartCollection =
    //     _cartReference.doc(purchaseId).collection('products');
    // return cartCollection.snapshots();

    CollectionReference purchaseCollection =
        _purchaseReference.doc(purchaseId).collection('products');
    return purchaseCollection.snapshots();
  }

  static Stream<QuerySnapshot> productList() {
    CollectionReference productCollection = _productReference;
    print("RETURN SNAP${productCollection.snapshots()}");
    return productCollection.snapshots();
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _productReference.get();

    //convert to the list of Map<string, dynamic> to be more specific
    final List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(
        querySnapshot.docs
            .map((doc) => doc.data())
            .toList()); // Get data from docs and convert map to List

    return allData;
  }
  /* 
    You need to create a collection product and then a doc to a list of products

  */

  //método para deletar info no firebase
  static deleteStudent(String id) {
    DocumentReference documentReference =
        _reference.doc(userId).collection('students').doc(id);
    documentReference
        .delete()
        .whenComplete(() => print("Estudante deletado com sucesso!!!"))
        .catchError((e) => print(e));
  }

  static Future<FirebaseApp> initializerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
