import 'package:flutter/material.dart';
import 'package:food_app/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';


class AppNameTextWidget extends StatelessWidget {
  final double fontSize;
  const AppNameTextWidget({super.key, this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 16),
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        child: TitlesTextWidget(
          label: "Recipepal",
          fontSize: fontSize,
        ));
  }
}
