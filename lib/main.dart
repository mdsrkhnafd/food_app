import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/theme_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/root_screen.dart';
import 'package:food_app/screens/auth/forget_screen.dart';
import 'package:food_app/screens/auth/login_screen.dart';
import 'package:food_app/screens/auth/register_screen.dart';
import 'package:food_app/screens/edit_upload_meal_from.dart';
import 'package:food_app/screens/favorite_screen.dart';
import 'package:food_app/screens/meal_planer.dart';
import 'package:food_app/screens/popular_recipe.dart';
import 'package:food_app/screens/product_details.dart';
import 'package:food_app/screens/scan_recipe.dart';
import 'package:food_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MealProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MealProvider(),
        ),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context,
            themeProvider,
            child,) {
          return MaterialApp(
            title: 'Shop Smart AR',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsDarkTheme, context: context),
            home:const SplashScreen(),
            routes: {
              RootScreen.routeName: (context) => const RootScreen(),
              ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
              FavoriteScreen.routeName: (context) => const FavoriteScreen(),
              PopularRecipe.routeName: (context) => const PopularRecipe(),
              MealPlaner.routeName: (context) => const MealPlaner(),
              ScanRecipe.routeName: (context) => const ScanRecipe(),
              EditUploadMealScreen.routeName: (context) => const EditUploadMealScreen(),
              RegisterScreen.routName: (context) => const RegisterScreen(),
              LoginScreen.routName: (context) => const LoginScreen(),
              ForgetScreen.routeName: (context) => const ForgetScreen(),

            },
          );
        },
      ),
    );
  }
}


