import 'dart:convert';

import 'package:client/categories/category_create.dart';
import 'package:client/categories/category_table.dart';
import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Material(
          child: ListView(
            children: [
              CompAppBar(
                title: "category",
                surfix: Text(
                  UtilPref.outlet['name'].toString(),
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ),
              Wrap(
                children: [
                  CategoryCreate(),
                  CategoryTable(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
