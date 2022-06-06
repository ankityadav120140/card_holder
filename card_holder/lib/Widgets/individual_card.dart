// ignore_for_file: camel_case_types, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, unused_import, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:card_holder/Widgets/card_list.dart';
import 'package:card_holder/pages/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class individual_card extends StatefulWidget {
  final String name;
  final String front_image_path;
  final String back_image_path;
  // final String path;

  const individual_card(
    this.name,
    this.front_image_path,
    this.back_image_path,
    // this.path,
  );

  @override
  State<individual_card> createState() => _individual_cardState();
}

class _individual_cardState extends State<individual_card> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => view_card(
              widget.name,
              widget.front_image_path,
              widget.back_image_path,
              // widget.path,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 250, 250),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          border: Border.all(width: 2, color: Colors.blue),
          image: DecorationImage(
            image: FileImage(
              File(widget.front_image_path),
            ),
            fit: BoxFit.cover,
          ),
        ),
        margin: const EdgeInsets.all(
          5,
        ),
        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: double.infinity,
                color: Colors.white.withOpacity(0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
