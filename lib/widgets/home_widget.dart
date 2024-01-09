import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/product_details.dart';
import 'heart_btn.dart';

class HomeWidget extends StatefulWidget {
  final String productId;
  const HomeWidget({
    super.key,
    required this.productId,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, ProductDetailsScreen.routName,
              arguments: getCurrProduct.productId);
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      width: 380.0,
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
                                end: Alignment.topCenter)),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            getCurrProduct.productTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Recipe",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: <Widget>[
                              HeartButtonWidget(
                                productId: getCurrProduct.productId,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // food2
          ],
        ),
      ),
    );
  }
}