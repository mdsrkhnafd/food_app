import 'package:flutter/material.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:food_app/screens/edit_upload_meal_from.dart';
import 'package:provider/provider.dart';

class MealWidget extends StatefulWidget {
  final String productId;
  const MealWidget({super.key,required this.productId,});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Product ID => ${widget.productId}");
  }

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealProvider>(context);
    final getCurrProduct = mealsProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditUploadMealScreen(
                  productModel: getCurrProduct,
                );
              },
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getCurrProduct.daysTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => () {

                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  getCurrProduct.breakFastTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(getCurrProduct.breakFastMenu),
              ),
              ListTile(
                title: Text(
                  getCurrProduct.lunchTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(getCurrProduct.lunchMenu),
              ),
              ListTile(
                title: Text(
                  getCurrProduct.dinnerTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(getCurrProduct.dinnerMenu),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
