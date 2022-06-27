// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unused_import, unnecessary_import, sized_box_for_whitespace, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class view_card extends StatefulWidget {
  final int index;
  final String name;
  final String front_image_path;
  final String back_image_path;
  // final String path;

  const view_card(
    this.index,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Front View',
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InteractiveViewer(
                  clipBehavior: Clip.none,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.file(
                      File(widget.front_image_path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                widget.back_image_path == ""
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Back View',
                              style: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.back_image_path == ""
                    ? Container()
                    : InteractiveViewer(
                        clipBehavior: Clip.none,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          child: Image.file(
                            File(widget.back_image_path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
