import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/login_screen.dart';
import 'package:food_app/services/assets_manager.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                AssetsManager.logo,
                width: 200,
              ),
            ),
            const SizedBox(height: 32),
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(AppColor.appColor),
              // ),
          ],
        ),
      ),
    );
  }
}
