// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';

class view_card extends StatefulWidget {
  final String name;
  final String front_image_path;
  final String back_image_path;
  // final String path;

  const view_card(
    this.name,
    this.front_image_path,
    this.back_image_path,
    // this.path,
  );

  @override
  State<view_card> createState() => _view_cardState();
}

class _view_cardState extends State<view_card> {
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
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              border: Border.all(width: 2, color: Colors.blue),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.file(
                    File(widget.front_image_path),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.file(
                    File(widget.back_image_path),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
