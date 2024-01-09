import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/services/my_app_method.dart';
import 'package:uuid/uuid.dart';

import '../consts/my_validators.dart';
import '../models/meal_model.dart';
import '../widgets/title_text.dart';
import 'loading_manager.dart';


class EditUploadMealScreen extends StatefulWidget {
  static const routeName = '/EditUploadMealScreen';

  const EditUploadMealScreen({super.key, this.productModel});

  final MealModel? productModel;

  @override
  State<EditUploadMealScreen> createState() =>
      _EditUploadMealScreenState();
}

class _EditUploadMealScreenState extends State<EditUploadMealScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _daysController,
      _breakFastController,
      _breakFastMenuController,
      _lunchController,
      _lunchMenuController,
      _dinnerController,
      _dinnerMenuController;
  bool isEditing = false;
  bool isLoading = false;


  @override
  void initState() {
    if(widget.productModel != null){
      isEditing = true;
    }

    _daysController = TextEditingController(text: widget.productModel?.daysTitle);
    _breakFastController = TextEditingController(text: widget.productModel?.breakFastTitle);
    _breakFastMenuController = TextEditingController(text: widget.productModel?.breakFastMenu);
    _lunchController = TextEditingController(text: widget.productModel?.lunchTitle);
    _lunchMenuController = TextEditingController(text: widget.productModel?.lunchMenu);
    _dinnerController = TextEditingController(text: widget.productModel?.dinnerTitle);
    _dinnerMenuController = TextEditingController(text: widget.productModel?.dinnerMenu);


    super.initState();
  }

  @override
  void dispose() {
    _daysController.dispose();
    _breakFastController.dispose();
    _breakFastMenuController.dispose();
    _lunchController.dispose();
    _lunchMenuController.dispose();
    _dinnerController.dispose();
    _dinnerMenuController.dispose();
    super.dispose();
  }

  void clearForm() {
    _daysController.clear();
    _breakFastController.clear();
    _breakFastMenuController.clear();
    _lunchController.clear();
    _lunchMenuController.clear();
    _dinnerController.clear();
    _dinnerMenuController.clear();
  }


  Future<void> _uploadProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    // Validate the form
    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        final auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        if (user == null) {
          return;
        }
        final uid = user.uid;
        final productId = Uuid().v4();

        await FirebaseFirestore.instance
            .collection("mealProducts")
            .doc(productId)
            .set({
          'userId': uid,
          "productId": productId,
          "daysTitle": _daysController.text,
          "breakFastTitle": _breakFastController.text,
          "breakFastMenu": _breakFastMenuController.text,
          "lunchTitle": _lunchController.text,
          "lunchMenu": _lunchMenuController.text,
          "dinnerTitle": _dinnerController.text,
          "dinnerMenu": _dinnerMenuController.text,
          "createdAt": Timestamp.now(),
        });
        Fluttertoast.showToast(
          msg: "Meal has been added",
          textColor: Colors.white,
        );
        if (!mounted) return;
        MyAppMethods.showErrorORWarningDialog(
            isError: false,
            context: context,
            subtitle: "Clear Form?",
            fct: () {
              clearForm();
            });
      } on FirebaseException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
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

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });

        await FirebaseFirestore.instance
            .collection("mealProducts")
            .doc(widget.productModel!.productId)
            .update({
          "productId": widget.productModel!.productId,
          "daysTitle": _daysController.text,
          "breakFastTitle": _breakFastController.text,
          "breakFastMenu": _breakFastMenuController.text,
          "lunchTitle": _lunchController.text,
          "lunchMenu": _lunchMenuController.text,
          "dinnerTitle": _dinnerController.text,
          "dinnerMenu": _dinnerMenuController.text,
          "createdAt": widget.productModel!.createdAt,
        });
        Fluttertoast.showToast(
          msg: "Product has been edited",
          textColor: Colors.white,
        );
        if (!mounted) return;
        MyAppMethods.showErrorORWarningDialog(
            isError: false,
            context: context,
            subtitle: "Clear Form?",
            fct: () {
              clearForm();
            });
      } on FirebaseException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
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


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoadingManager(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child:
        Scaffold(
          bottomSheet: SizedBox(
            height: kBottomNavigationBarHeight + 10,
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.clear),
                    label: const Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      clearForm();
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      // backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.upload),
                    label: Text(
                      isEditing ? "Edit Meal" : "Upload Meal",
                    ),
                    onPressed: () {
                      if (isEditing) {
                        _editProduct();
                      } else {
                        _uploadProduct();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: TitlesTextWidget(
              label: isEditing ? "Edit Meal" : "Upload a new Meal",
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _daysController,
                            key: const ValueKey('Day Title'),
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Day Title',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString:
                                "Please enter a valid title",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            key: const ValueKey('Break Fast Title'),
                            controller: _breakFastController,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Break Fast Title',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString: "Break is missed",
                              );
                            },
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _breakFastMenuController,
                            key: const ValueKey('Break Fast Menu'),
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Break Fast Menu',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString:
                                "Please enter a valid title",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            key: const ValueKey('Lunch Title'),
                            controller: _lunchController,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Lunch Title',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString: "Lunch is missed",
                              );
                            },
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _lunchMenuController,
                            key: const ValueKey('Lunch Menu'),
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Lunch Menu',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString:
                                "Please enter a valid title",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            key: const ValueKey('Dinner Title'),
                            controller: _dinnerController,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Dinner Title',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString: "Dinner is missed",
                              );
                            },
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _dinnerMenuController,
                            key: const ValueKey('Dinner Menu'),
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Dinner Menu',
                            ),
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString:
                                "Please enter a valid title",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}