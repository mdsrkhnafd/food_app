import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../screens/product_details.dart';
import 'heart_btn.dart';

class FavoriteWidget extends StatefulWidget {
  final String productId;

  const FavoriteWidget({
    super.key,
    required this.productId,
  });

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FancyShimmerImage(
              imageUrl: getCurrProduct.productImage,
              height: size.height * 0.22,
              width: double.infinity,
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 60.0,
              width: 380.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 15.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 Text(
                  getCurrProduct.productTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Recipe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                HeartButtonWidget(
                  productId: getCurrProduct.productId,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
