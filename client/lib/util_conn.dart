import 'dart:convert';
import 'package:client/util_routers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect.dart';
import 'util_pref.dart';
import 'package:get/get.dart';

final listMenuItem = <Map<String, dynamic>>[
  {"category": "breakfast", "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/breakfast.json"},
  {"category": "cake", "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/cake.json"},
  {"category": "drink", "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/drink.json"},
  {"category": "snacks", "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/snacks.json"},
  {"category": "fresh food", "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/fresh_food.json"},
  {
    "category": "instant food",
    "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/instant_food.json"
  },
  {
    "category": "tinned food",
    "data": "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/tinned_food.json"
  },
];

const customers = "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/customers.json";

class UtilConn extends GetConnect {
  Future<void> loadMenuItem() async {
    final result = [];
    for (var item in listMenuItem) {
      var response = await http.get(Uri.parse(item["data"].toString()));
      for (var item in json.decode(response.body)) {
        result.add(item);
      }
    }
    UtilPref.listMenuSet(value: [...result]);
  }

  Future<void> loadCustomer() async {
    final response = await http.get(Uri.parse(customers));
    UtilPref.listCustomerSet(value: List.from(json.decode(response.body)));
  }

  Future<void> login(Map? data) async {
    if ((data ?? "").toString().isEmpty) {
      EasyLoading.showError("Please fill all field");
      return;
    }

    if (data!['email'] == "malik@gmail.com" && data['pasword'] == "12345") {
      EasyLoading.showSuccess("Login Success");
      UtilRoutes.home().goOff();
    } else {
      EasyLoading.showError("Login Failed");
    }
  }
}
