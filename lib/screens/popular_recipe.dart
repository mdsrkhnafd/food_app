import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/loading_manager.dart';
import 'package:food_app/widgets/popular_widget.dart';
import 'package:provider/provider.dart';

import '../models/meal_model.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/title_text.dart';

class PopularRecipe extends StatefulWidget {
  static const routeName = '/PopularScreen';
  const PopularRecipe({super.key});

  @override
  State<PopularRecipe> createState() => _PopularRecipeState();
}

class _PopularRecipeState extends State<PopularRecipe> {

  late TextEditingController searchTextController;
  bool _isLoading = true;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context , listen: false);
    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = productsProvider.findByCategory(categoryName: "Popular Recipes");
   // List<ProductModel> productList = passedCategory == null ? productsProvider.products : productsProvider.findByCategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:  const Text("Popular Recipes"),
        ),
        body: productList.isEmpty
            ? const Center(child: TitlesTextWidget(label: "No product found"))
            : StreamBuilder<List<ProductModel>>(
            stream: productsProvider.fetchProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: SelectableText(snapshot.error.toString()),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: SelectableText("No products has been added"),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // setState(() {
                            FocusScope.of(context).unfocus();
                            searchTextController.clear();
                            // });
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      // onChanged: (value) {
                      //   setState(() {
                      //     productListSearch = productsProvider.searchQuery(
                      //         searchText: searchTextController.text);
                      //   });
                      // },
                      onSubmitted: (value) {
                        setState(() {
                          productListSearch = productsProvider.searchQuery(
                              searchText: searchTextController.text,
                              passedList: productList);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (searchTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      const Center(
                        child: TitlesTextWidget(label: "No products found"),
                      ),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        itemCount: searchTextController.text.isNotEmpty
                            ? productListSearch.length
                            : productList.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        builder: (context, index) {
                          return PopularWidget(
                            productId: searchTextController.text.isNotEmpty
                                ? productListSearch[index].productId
                                : productList[index].productId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Popular Recipe"),
//         centerTitle: true,
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 3,
//           mainAxisSpacing: 5,
//           //childAspectRatio: 0.85,
//         ),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//          // final recipe = _recipeList[index];
//           return GestureDetector(
//             onTap: () {
//
//             },
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Flexible(
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                       child: Image.asset(
//                         'assets/food1.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         const Text(
//                           "Chicken",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         // const Text(
//                         //   "Recipe",
//                         //   style: TextStyle(
//                         //     color: Colors.black,
//                         //     fontSize: 18.0,
//                         //     fontWeight: FontWeight.bold,
//                         //   ),
//                         // ),
//                         GestureDetector(
//                           onTap: () {},
//                           child: const Icon(
//                             Icons.favorite,
//                             color: Colors.red, // Change the color to red
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
