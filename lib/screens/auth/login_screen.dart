import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/screens/auth/forget_screen.dart';
import 'package:food_app/screens/auth/register_screen.dart';
import 'package:food_app/screens/home_screen.dart';

import '../../consts/my_validators.dart';
import '../../services/my_app_method.dart';
import '../../widgets/auth/google_btn.dart';
import '../../widgets/common/custom_form_button.dart';
import '../../widgets/common/custom_input_field.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/page_heading.dart';
import '../../widgets/subtitle_text.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // _formKey.currentState!.save();
      // if (_pickedImage == null) {
      //   MyAppMethods.showErrorORWarningDialog(
      //       context: context,
      //       subtitle: "Make sure to pick up an image",
      //       fct: () {});
      // }

      try {
        setState(() {
          isLoading = true;
        });

        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),);
        Fluttertoast.showToast(
          msg: "Login Successfull",
          textColor: Colors.white,
        );
        if(!mounted) return;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));

      } on FirebaseException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
            context: context, subtitle: error.message.toString(), fct: () {});
      }catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
            context: context, subtitle: error.toString(), fct: () {});
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(height: size.height * 0.057,),
              const PageHeader(),
              SizedBox(height: size.height * 0.045,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Email address",
                                  prefixIcon: Icon(
                                    IconlyLight.message,
                                  ),
                                ),

                                validator: (value) {
                                  return MyValidators.emailValidator(value);
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(),
                                  hintText: "*********",
                                  prefixIcon: const Icon(
                                    IconlyLight.lock,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  return MyValidators.passwordValidator(value);
                                },
                                onFieldSubmitted: (value) {
                                  _loginFct();
                                },
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetScreen(),));
                                  },
                                  child: const SubtitleTextWidget(
                                    label: "Forgot password?",
                                    textDecoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // SubtitleTextWidget(
                              //   label: "OR connect using".toUpperCase(),
                              // ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight + 10,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox(
                                          height: kBottomNavigationBarHeight,
                                          child: FittedBox(
                                            child: GoogleButton(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(8),
                                              backgroundColor: const Color(0xff233743),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                            ),
                                            icon: const Icon(Icons.login , color: Colors.white,),
                                            label: const Text(
                                              "Login",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                              ),
                                            ),
                                            onPressed: () async {
                                              _loginFct();
                                            },
                                          ),
                                        ),
                                       ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SubtitleTextWidget(
                                    label: "Don't have an account?",
                                  ),
                                  TextButton(
                                    child: const SubtitleTextWidget(
                                      label: "Sign up",
                                      textDecoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen(),));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _handleLoginUser() {
    // login user
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
    // if (_loginFormKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Submitting data..')),
    //   );
    // }
  }
}