import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class MealModel with ChangeNotifier {
  final String productId,
      userId,
      daysTitle,
      breakFastTitle,
      breakFastMenu,
      lunchTitle,
      lunchMenu,
      dinnerTitle,
      dinnerMenu;
  Timestamp? createdAt;

  MealModel({
    required this.productId,
    required this.userId,
    required this.daysTitle,
    required this.breakFastTitle,
    required this.breakFastMenu,
    required this.lunchTitle,
    required this.lunchMenu,
    required this.dinnerTitle,
    required this.dinnerMenu,
    this.createdAt,
  });

  factory MealModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // data.containsKey("key")
    return MealModel(
      productId: data["productId"],
      userId: data["userId"],
      //doc.get(field),
      daysTitle: data["daysTitle"],
      breakFastTitle: data["breakFastTitle"],
      breakFastMenu: data["breakFastMenu"],
      lunchTitle: data["lunchTitle"],
      lunchMenu: data["lunchMenu"],
      dinnerTitle: data["dinnerTitle"],
      dinnerMenu: data["dinnerMenu"],
      createdAt: data["createdAt"],
    );
  }
}
