// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, unnecessary_import, non_constant_identifier_names, unused_import, deprecated_member_use, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:card_holder/Widgets/card_list.dart';
import 'package:card_holder/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class addCard extends StatefulWidget {
  const addCard({Key? key}) : super(key: key);

  @override
  State<addCard> createState() => _addCardState();
}

class _addCardState extends State<addCard> {
  TextEditingController cardName = TextEditingController();
  late SharedPreferences _prefs;

  void saveData() async {
    List<String> spList =
        card_list.map((e) => jsonEncode(card_detail.toMap(e))).toList();

    _prefs.setStringList('card_list', spList);
    print(spList);
  }

  void addCard(card_detail new_card) async {
    card_list.add(new_card);
    saveData();
  }

  void imagePickerOption(bool front) {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera, front);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("CAMERA"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery, front);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("GALLERY"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("CANCEL"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String frontImgPath = "";
  String backImgPath = "";

  pickImage(ImageSource imageType, bool front) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: photo.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
          // CropAspectRatioPreset.ratio10x8,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        if (front) {
          setState(() {
            frontImgPath = croppedFile.path;
          });
        } else {
          setState(() {
            backImgPath = croppedFile.path;
          });
        }
      }

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Card Holder',
          style: TextStyle(
            fontSize: 21,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: cardName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Card Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  imagePickerOption(true);
                },
                child: frontImgPath == ""
                    ? Container(
                        child: SizedBox(
                          height: 225,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 200,
                                  color: Colors.black38,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                  color: Colors.transparent.withOpacity(
                                    0.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Card Front",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.blue,
                          ),
                        ),
                        child: Image.file(
                          File(
                            frontImgPath,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  imagePickerOption(false);
                },
                child: backImgPath == ""
                    ? Container(
                        child: SizedBox(
                          height: 225,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 200,
                                  color: Colors.black38,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                  color: Colors.transparent.withOpacity(
                                    0.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Card Back",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.blue,
                          ),
                        ),
                        child: Image.file(
                          File(backImgPath),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    if (cardName.text == '' || frontImgPath == '') {
                      final snackBar = SnackBar(
                        content: const Text(
                          'Add atleast a card name and a photo',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      setState(() {
                        final card_detail new_card = card_detail(
                          card_name: cardName.text.toUpperCase(),
                          fornt_img_path: frontImgPath,
                          back_img_path: backImgPath,
                          index: card_list.length,
                        );
                        addCard(new_card);
                      });
                      cardName.clear();
                      setState(() {});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => home(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Add Card",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {});
  }
}
