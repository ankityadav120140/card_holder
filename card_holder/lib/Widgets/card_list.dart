// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_import, prefer_typing_uninitialized_variables, await_only_futures, unused_field, prefer_final_fields, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class card_detail {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late final String card_name;
  late final String fornt_img_path;
  late final String back_img_path;

  card_detail({
    required this.card_name,
    required this.fornt_img_path,
    required this.back_img_path,
  });

  factory card_detail.fromJson(Map<String, dynamic> jsonData) {
    return card_detail(
      card_name: jsonData['card_name'],
      fornt_img_path: jsonData['fornt_img_path'],
      back_img_path: jsonData['back_img_path'],
    );
  }

  static Map<String, dynamic> toMap(card_detail card) => {
        'card_name': card.card_name,
        'fornt_img_path': card.fornt_img_path,
        'back_img_path': card.back_img_path,
      };
}

List<card_detail> card_list = [];
