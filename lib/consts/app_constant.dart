
import '../models/categories_model.dart';
import '../services/assets_manager.dart';

class AppConstants {
  static const String imageUrl =
      "https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png";

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Home",
      image: AssetsManager.aircondition,
      name: "Home",
    ),
    CategoryModel(
      id: "Popular Recipes",
      image: AssetsManager.homedecoration,
      name: "Popular Recipes",
    ),
  ];
}

class MyValidators {

}
