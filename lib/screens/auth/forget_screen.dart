
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/screens/auth/login_screen.dart';

import '../../consts/my_validators.dart';
import '../../services/my_app_method.dart';
import '../../widgets/common/custom_form_button.dart';
import '../../widgets/common/custom_input_field.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/page_heading.dart';


class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  //
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });

        await auth.sendPasswordResetEmail(
            email: _emailController.text.trim().toString());

        Fluttertoast.showToast(
          msg:
          "We have sent you an email to recover the password, please check your email",
          textColor: Colors.white,
        );

        // if(!mounted) return;
        // Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (error) {
        if (error.code == 'user-not-found') {
          /// Handle the case where the email is not registered
          if (!mounted) return;
          await MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: "This email is not registered. Please sign up.",
              fct: () {});
          // Fluttertoast.showToast(
          //   msg: "This email is not registered. Please sign up.",
          //   textColor: Colors.white,
          // );
          // if(!mounted) return;
          // Navigator.pushReplacementNamed(context, RootScreen.routeName);
        } else {
          if (!mounted) return;
          await MyAppMethods.showErrorORWarningDialog(
              context: context, subtitle: error.toString(), fct: () {});
        }
      } catch (error) {
        if (!mounted) return;
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
          backgroundColor: const Color(0xffEEF1F3),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.0457,),
                            const PageHeading(title: 'Forgot password',),
                            SizedBox(height: size.height * 0.045,),
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            hintText: 'youremail@email.com',
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: const Icon(IconlyLight.message),
                            ),
                           // filled: true,
                          ),
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                          onFieldSubmitted: (_) {
                            // Move focus to the next field when the "next" button is pressed
                          },
                        ),
                            const SizedBox(height: 20,),
                            CustomFormButton(innerText: 'Submit', onPressed: _forgetPassFCT,),
                            const SizedBox(height: 20,),
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
                                },
                                child: const Text(
                                  'Back to login',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  void _handleForgetPassword() {
    // forget password
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }
}