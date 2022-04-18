import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_connect.dart';
import 'util_pref.dart';

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

class UtilConn extends GetConnect {
  Future<void> loadMenuItem() async {
    final result = [];
    for (var item in listMenuItem) {
      var response = await http.get(Uri.parse(item["data"].toString()));
      for (var item in json.decode(response.body)) {
        result.add(item);
      }
    }
    UtilPref.listMenuSet([...result]);
  }
}
