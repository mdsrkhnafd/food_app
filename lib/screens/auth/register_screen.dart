import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/screens/auth/login_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../consts/my_validators.dart';
import '../../services/my_app_method.dart';
import '../../widgets/auth/pick_image_widget.dart';
import '../../widgets/common/custom_form_button.dart';
import '../../widgets/common/custom_input_field.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/page_heading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  XFile? _pickedImage;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Focus Nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "Make sure to pick up an image",
          fct: () {});
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });

        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "An account has been created",
          textColor: Colors.white,
        );

        final User? user = auth.currentUser;
        final String uid = user!.uid;

        final ref = FirebaseStorage.instance
            .ref("usersImages")
            .child("${_emailController.text.trim()}.jpg");
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "userId": uid,
          "userName": _nameController.text,
          "userImage": userImageUrl,
          "userEmail": _emailController.text.toLowerCase(),
          "createAt": Timestamp.now(),
          "userWish": [],
          "userCart": [],
        });
        if (!mounted) return;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
      } on FirebaseException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
            context: context, subtitle: error.message.toString(), fct: () {});
      } catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
            context: context, subtitle: error.toString(), fct: () {});
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                   // const PageHeader(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                      ),
                      child: Column(
                        children: [
                          const PageHeading(title: 'Sign-up',),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: PickImageWidget(
                          pickedImage: _pickedImage,
                          function: () async {
                            await localImagePicker();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                          TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "Full name",
                              prefixIcon: Icon(
                                IconlyLight.message,
                              ),
                            ),
                            validator: (value) {
                              return MyValidators.displayNamevalidator(value);
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
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
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.next,
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
                              FocusScope.of(context)
                                  .requestFocus(_confirmPasswordFocusNode);
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
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
                              return MyValidators.repeatPasswordValidator(
                                  value: value,
                                  password: _passwordController.text);
                            },
                            onFieldSubmitted: (value) {
                              _registerFct();
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          const SizedBox(height: 22,),
                          CustomFormButton(innerText: 'Signup', onPressed: () {
                            _registerFct();
                          },),
                          const SizedBox(height: 18,),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Already have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
                                  },
                                  child: const Text('Log-in', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignupUser() {
    // signup user
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }
}