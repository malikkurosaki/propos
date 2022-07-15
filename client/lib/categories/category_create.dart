import 'dart:convert';

import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/util_http.dart';
import '../utils/util_value.dart';

class CategoryCreate extends StatelessWidget {
  CategoryCreate({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _outlet = {}.obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SizedBox(
        width: sizingInformation.isMobile ? double.infinity : 360,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Add Category",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownButtonFormField<Map>(
                  decoration: InputDecoration(
                      labelText: "Outlet",
                      hintText: "Select outlet",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true),
                  // value: _listOutlet[0],
                  onChanged: (value) {
                    _outlet.assignAll(Map.from(value!));
                  },
                  items: List<Map>.from(GVal.outlets.value.val).map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value['name'].toString()),
                    );
                  }).toList(),
                ),
                // form create new category
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Category Name",
                      hintText: "Category Name",
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Category Description",
                      hintText: "Category Description",
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      if (_nameController.text.isEmpty || _outlet.isEmpty) {
                        EasyLoading.showError("Category Name or outlet is required ");
                        return;
                      }

                      final data = await UtilHttp.categoryCreate({
                        "outletId": _outlet['id'],
                        "name": _nameController.text,
                        "description": _descriptionController.text,
                      });

                      final hasil = jsonDecode(data.body);
                      if (hasil['success']) {
                        EasyLoading.showToast("success");
                        UtilLoad.loadCategory();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
