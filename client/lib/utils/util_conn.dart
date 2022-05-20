import 'dart:convert';
import 'package:http/http.dart' as http;
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

const customers = "https://raw.githubusercontent.com/malikkurosaki/makuro_api/main/customers.json";

class UtilConn {
  static const host = "http://localhost:3000";
  static const url = 'http://localhost:3000/api/v1';

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

  // login
  Future<http.Response> login(Map? body) => http.post(Uri.parse('$host/login'), body: body);

  // register
  Future register(Map body) => http.post(Uri.parse(url + '/register'), body: body);

  

  // get outlet by user
  static Future<http.Response> outletGet() => http.get(
        Uri.parse(url + '/outlet/get/'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );
}
