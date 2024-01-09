import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/product_details.dart';
import 'heart_btn.dart';

class PopularWidget extends StatefulWidget {
  final String productId;

  const PopularWidget({
    super.key,
    required this.productId,
  });

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Popular => ${widget.productId}");
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(
                context, ProductDetailsScreen.routName,
                arguments: getCurrProduct.productId);
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 150.0,
                  width: 350.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TitlesTextWidget(
                          label: getCurrProduct.productTitle,
                        ),
                      ),
                      // const Text(
                      //   "Recipe",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      HeartButtonWidget(
                        productId: getCurrProduct.productId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
