import 'package:flutter/material.dart';
import 'package:food_app/screens/favorite_screen.dart';
import 'package:food_app/screens/meal_planer.dart';
import 'package:food_app/screens/popular_recipe.dart';
import 'package:food_app/screens/scan_recipe.dart';
import 'package:food_app/services/assets_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.drawerimage),
                    // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: null,
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScanRecipe(),
                  ));
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ));
                  // Handle Favorites screen navigation
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MealPlaner(),
                  ));
                  // Handle Meal Planner screen navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.trending_up),
                title: const Text(
                  'Popular Recipes',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PopularRecipe(),
                  ));
                  // Handle Popular Recipes screen navigation
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
             // controller: searchTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                  onTap: () {
                    // setState(() {
                    FocusScope.of(context).unfocus();
                   // searchTextController.clear();
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
                  // productListSearch = productsProvider.searchQuery(
                  //     searchText: searchTextController.text,
                  //     passedList: productList);
                });
              },
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food1.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Burger",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food2.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Chicken",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                    // food3
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food3.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Fish",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                    // food4
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food4.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Parata",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                    // food5
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food5.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Pulao",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                    // food6
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: 380.0,
                              child: Image.asset(
                                'assets/food6.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: Container(
                                height: 60.0,
                                width: 380.0,
                                decoration: BoxDecoration(
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
                                    "Mutton Karai",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Recipe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          // isFav ? Icons.favorite : Icons.favorite_border,
                                          // color: isFav ? Colors.pinkAccent : Colors.white,
                                        ),
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
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
