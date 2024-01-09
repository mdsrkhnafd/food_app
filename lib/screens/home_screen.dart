import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/screens/favorite_screen.dart';
import 'package:food_app/screens/loading_manager.dart';
import 'package:food_app/screens/meal_planer.dart';
import 'package:food_app/screens/popular_recipe.dart';
import 'package:food_app/screens/product_details.dart';
import 'package:food_app/screens/scan_recipe.dart';
import 'package:food_app/services/assets_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../consts/app_constant.dart';
import '../models/meal_model.dart';
import '../models/user_model.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../services/my_app_method.dart';
import '../widgets/heart_btn.dart';
import '../widgets/home_widget.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchTextController;

  /// fetching user image, email and name
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      if(!mounted) return ;
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
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
    List<ProductModel> productList = passedCategory == null
        ? productsProvider.products
        : productsProvider.findByCategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
         backgroundColor: Colors.grey,
        appBar: AppBar(
            backgroundColor: Colors.grey,
          title: const Text(
            'Discover New Recipes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                //showSearch(context: context, delegate: _CustomSearchDelegate());
              },
            ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                       UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(color: Colors.grey),
                        accountName: Text(
                          userModel == null ? 'your name' : userModel!.userName,
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        accountEmail: Text(
                          userModel == null ? 'your email' : userModel!.userEmail,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userModel == null ? 'your email' : userModel!.userImage,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text(
                          'Scan Recipe',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ScanRecipe.routeName,);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.favorite),
                        title: const Text(
                          'Favorites',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, FavoriteScreen.routeName,);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text(
                          'Meal Planner',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, MealPlaner.routeName,);
                        },
                      ),
                      ListTile(
                     // final String name;
                        leading: const Icon(Icons.trending_up),
                        title: Text(
                          AppConstants.categoriesList[1].name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, PopularRecipe.routeName, arguments: AppConstants.categoriesList[1].name,);
                         // Navigator.pushNamed(context, PopularRecipe.routeName,);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () async {
                          if (user == null) {
                            Navigator.pushNamed(context, LoginScreen.routName);
                          } else {
                            await MyAppMethods.showErrorORWarningDialog(
                              context: context,
                              subtitle: "Are you sure you want to SignOut",
                              fct: () async {
                                final GoogleSignIn _googleSignIn = GoogleSignIn();
                                await FirebaseAuth.instance.signOut();
                                await _googleSignIn.signOut();
                                if (!mounted) return;
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routName);
                              },
                              isError: false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScanRecipe(),
                        ));
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: productList.isEmpty
            ? const Center(child: Text("No product found"),)
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                  TextField(
                    // controller: searchTextController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          //  setState(() {
                          FocusScope.of(context).unfocus();
                          searchTextController.clear();
                          //  });
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
                    height: 3.0,
                  ),
                              if (searchTextController.text.isNotEmpty &&
                                  productListSearch.isEmpty) ...[
                                const Center(
                                  child: Text("No products found"),
                                ),
                              ],
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchTextController.text.isNotEmpty
                          ? productListSearch.length
                          : productList.length,
                      padding:
                          const EdgeInsets.only(top: 10.0),
                      itemBuilder: (context, index) {
                        return HomeWidget(
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
              }
            ),
      ),
    );
  }
}


