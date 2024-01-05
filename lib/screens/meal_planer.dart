import 'package:flutter/material.dart';

class MealPlaner extends StatefulWidget {
  const MealPlaner({super.key});

  @override
  State<MealPlaner> createState() => _MealPlanerState();
}

class _MealPlanerState extends State<MealPlaner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planer"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        children: [
          Card(
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
                       "Monday",
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
                     "Breakfast",
                     style: const TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 subtitle: Text("Avocado Toast"),
               ),
               ListTile(
                 title: Text(
                   "Lunch",
                   style: const TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 subtitle: Text("Greek Salaad"),
               ),
               ListTile(
                 title: Text(
                   "Dinner",
                   style: const TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 subtitle: Text("Grilled Chicken with Vegetables"),
               ),
             ],
           ),
          ),
          Card(
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
                        "Tuesday",
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
                    "Breakfast",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Avocado Toast"),
                ),
                ListTile(
                  title: Text(
                    "Lunch",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Greek Salaad"),
                ),
                ListTile(
                  title: Text(
                    "Dinner",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Grilled Chicken with Vegetables"),
                ),
              ],
            ),
          ),
          Card(
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
                        "Wednesday",
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
                    "Breakfast",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Avocado Toast"),
                ),
                ListTile(
                  title: Text(
                    "Lunch",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Greek Salaad"),
                ),
                ListTile(
                  title: Text(
                    "Dinner",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Grilled Chicken with Vegetables"),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
