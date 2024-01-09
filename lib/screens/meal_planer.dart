import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:food_app/screens/edit_upload_meal_from.dart';
import 'package:food_app/widgets/meal_widgets.dart';
import 'package:provider/provider.dart';

import '../services/assets_manager.dart';
import '../widgets/title_text.dart';

class MealPlaner extends StatefulWidget {
  static const routeName = '/MealScreen';

  const MealPlaner({super.key});

  @override
  State<MealPlaner> createState() => _MealPlanerState();
}

class _MealPlanerState extends State<MealPlaner> {
  late TextEditingController searchTextController;

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

  List<MealModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<MealProvider>(context);
    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;
    List<MealModel> productList = productsProvider.products;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const TitlesTextWidget(label: "Meal Planner"),
          ),
          body: StreamBuilder<List<MealModel>>(
              stream: productsProvider.fetchProductsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Center(
                      child: CircularProgressIndicator(),
                    ),
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
                          crossAxisCount: 1,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          builder: (context, index) {
                            return MealWidget(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, EditUploadMealScreen.routeName);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
