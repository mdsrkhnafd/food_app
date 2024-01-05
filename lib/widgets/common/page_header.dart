import 'package:flutter/material.dart';

import '../../services/assets_manager.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
     // height: size.height * 0.3,
      child: ClipRRect(
        child: Image.asset(AssetsManager.loginimage, fit: BoxFit.contain),
      ),
    );
  }
}
