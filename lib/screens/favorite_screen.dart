import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';
import '../services/assets_manager.dart';
import '../services/my_app_method.dart';
import '../widgets/empty_bag.dart';
import '../widgets/favorite_widget.dart';
import '../widgets/title_text.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/FavoriteScreen';
  const FavoriteScreen({super.key});

 // static const routName = '/WishlistScreen';



  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final wishlistsProvider = Provider.of<WishlistProvider>(context);
    return wishlistsProvider.getWishlist.isEmpty
        ? Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your favorite is empty",
        subtitle:
        '',
        buttonText: "",
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              MyAppMethods.showErrorORWarningDialog(
                  isError: false,
                  context: context,
                  subtitle: "Clear Favorite?",
                  fct: () async {
                    await wishlistsProvider.clearWishlistFromFirebase();
                    // wishlistsProvider.cartLocalWishlist();
                  });
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: DynamicHeightGridView(
        itemCount: wishlistsProvider.getWishlist.length,
        builder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavoriteWidget(
              productId: wishlistsProvider.getWishlist.values
                  .toList()[index]
                  .productId,
            ),
          );
        }),
        crossAxisCount: 1,
      ),
    );
  }
}
