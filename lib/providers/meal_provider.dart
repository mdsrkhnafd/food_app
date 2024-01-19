import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/meal_model.dart';

class MealProvider with ChangeNotifier {
  List<MealModel> products = [];

  List<MealModel> get getProduct => products;

  MealModel? findByProdId(String productId) {
    if (products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productId == productId);
  }

  // List<MealModel> findByCategory({required String categoryName}) {
  //   List<MealModel> categoryList = products
  //       .where((element) => element.productCategory
  //       .toLowerCase()
  //       .contains(categoryName.toLowerCase()))
  //       .toList();
  //   return categoryList;
  // }

  List<MealModel> searchQuery(
      {required String searchText, required List<MealModel> passedList}) {
    List<MealModel> searchList = passedList
        .where((element) => element.daysTitle
        .toLowerCase()
        .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final userDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<void> removeMealFromFirestore({
    required String productId,
  }) async {
    final User? user = _auth.currentUser;
    try {
      await userDb.doc(user!.uid).update({
        'mealProducts': FieldValue.arrayRemove([
          {
            'productId': productId,
          }
        ])
      });
      // await fetchCart();
      products.remove(productId);
      Fluttertoast.showToast(msg: "Meal has been removed");
      notifyListeners();
    } catch (e) {
      rethrow;
    }

  }


  final productDb = FirebaseFirestore.instance.collection("mealProducts");

  // Future<List<MealModel>> fetchProducts() async {
  //
  //   try {
  //     await productDb.orderBy('productId', descending: false).get().then(
  //           (productSnapshot) {
  //         products.clear();
  //         //  products = [];
  //         for (var element in productSnapshot.docs) {
  //           products.insert(0, MealModel.fromFirestore(element));
  //         }
  //       },
  //     );
  //     notifyListeners();
  //     return products;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Stream<List<MealModel>> fetchProductsStream() {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    try {
      return productDb.where('userId', isEqualTo: uid).snapshots().map((snapshot) {
        products.clear();
        //  products = [];
        for (var element in snapshot.docs) {
          products.insert(0, MealModel.fromFirestore(element));
        }
        return products;
      });
    } catch (error) {
      rethrow;
    }
  }

}
