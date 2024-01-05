import 'package:flutter/material.dart';

class ScanRecipe extends StatefulWidget {
  const ScanRecipe({super.key});

  @override
  State<ScanRecipe> createState() => _ScanRecipeState();
}

class _ScanRecipeState extends State<ScanRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
