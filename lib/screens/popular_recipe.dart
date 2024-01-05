import 'package:flutter/material.dart';

class PopularRecipe extends StatefulWidget {
  const PopularRecipe({super.key});

  @override
  State<PopularRecipe> createState() => _PopularRecipeState();
}

class _PopularRecipeState extends State<PopularRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Recipe"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
          //childAspectRatio: 0.85,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
         // final recipe = _recipeList[index];
          return GestureDetector(
            onTap: () {

            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/food1.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Chicken",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
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
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red, // Change the color to red
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// GestureDetector(
// onTap: () {
//
// },
// child: Card(
// elevation: 4,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(16),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Flexible(
// child: ClipRRect(
// borderRadius: const BorderRadius.only(
// topLeft: Radius.circular(16),
// topRight: Radius.circular(16),
// ),
// child: Image.asset(
// 'assets/food1.jpeg',
// fit: BoxFit.cover,
// ),
// ),
// ),
// const SizedBox(height: 12),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// const Text(
// "Chicken",
// style: TextStyle(
// color: Colors.black,
// fontSize: 18.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// // const Text(
// //   "Recipe",
// //   style: TextStyle(
// //     color: Colors.black,
// //     fontSize: 18.0,
// //     fontWeight: FontWeight.bold,
// //   ),
// // ),
// GestureDetector(
// onTap: () {},
// child: const Icon(
// Icons.favorite,
// color: Colors.red, // Change the color to red
// ),
// )
// ],
// ),
// ),
// ],
// ),
// ),
// )