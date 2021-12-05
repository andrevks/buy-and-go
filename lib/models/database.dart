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
    List<Map<String, dynamic>>? products,
  }) async {
    DocumentReference documentReference =
        _userReference.doc(userId).collection('shoppingList').doc();

    debugPrint("USERID >>>>> $userId");

    Map<String, dynamic> data = <String, dynamic>{
      "date": date,
      "totalPrice": totalPrice,
      "products": products,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("COMPRA gravada com sucesso!!!"));
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
    CollectionReference userCollection = _userReference
        .doc(userId)
        .collection('shoppingList')
        .doc(purchaseId)
        .collection('products');
    return userCollection.snapshots();
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
