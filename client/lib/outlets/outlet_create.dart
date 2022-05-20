import 'dart:convert';

import 'package:client/utils/util_conn.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/util_pref.dart';

class OutletCreate extends StatelessWidget {
  OutletCreate({Key? key, this.onSave, this.value}) : super(key: key);
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final Function(Map? body)? onSave;
  final Map? value;

  _onLoad(){
    if(value != null){
      nameController.text = value!['name'].toString();
      descController.text = value!['description'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SizedBox(
          width: sizingInformation.isMobile ? double.infinity : 360,
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Outlet",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  // form create new outlet
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Outlet Name",
                        hintText: "Outlet Name",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: "Outlet Description",
                        hintText: "Outlet Description",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        if (nameController.text.isEmpty) {
                          EasyLoading.showToast("Please input outlet name");
                          return;
                        }

                        final body = {
                          "name": nameController.text,
                          "description": descController.text,
                          "usersId": UtilPref.user["id"]
                        };

                        onSave!(body);
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Add Outlet",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),
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
