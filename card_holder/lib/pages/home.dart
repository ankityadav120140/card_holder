// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, non_constant_identifier_names, unused_element, unused_import, await_only_futures, unused_field

import 'dart:convert';
import 'dart:ffi';

import 'package:card_holder/Widgets/card_list.dart';
import 'package:card_holder/pages/add_new_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/individual_card.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late SharedPreferences _prefs;

  void loadData() async {
    List<String>? spList = await _prefs.getStringList('card_list');
    if (spList != null) {
      card_list =
          spList.map((e) => card_detail.fromJson(jsonDecode(e))).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadData();
    // setState(() {});
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
      body: Container(
        padding: const EdgeInsets.only(top: 2.5),
        decoration: BoxDecoration(color: Color.fromARGB(255, 226, 228, 249)),
        child: card_list.isEmpty
            ? Container()
            : ListView.builder(
                itemCount: card_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return individual_card(
                    index,
                    card_list[index].card_name,
                    card_list[index].fornt_img_path,
                    card_list[index].back_img_path,
                  );
                }
                //   final item = card_list[index];
                //   card_list.map(
                //     (e) => individual_card(
                //       e.index,
                //       e.card_name,
                //       e.fornt_img_path,
                //       e.back_img_path,
                //     ),
                //   );
                // },
                // children: card_list
                //     .map(
                //       (e) => individual_card(
                //         e.card_name,
                //         e.fornt_img_path,
                //         e.back_img_path,
                //       ),
                //     )
                //     .toList(),
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => addCard(),
            ),
          );
        },
        label: const Text(
          'Add New Card',
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
