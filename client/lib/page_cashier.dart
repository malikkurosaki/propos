import 'dart:convert';

import 'package:client/util_conn.dart';
import 'package:client/util_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
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

final lastClick = <String, dynamic>{}.obs;

class PageCashier extends StatelessWidget {
  const PageCashier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => SafeArea(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(UtilPref.listMenu.length.toString()),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          color: Colors.blueGrey[50],
                          child: Obx(() => UtilPref.listMenu.isEmpty
                              ? Text("Loading ...")
                              : Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: "Search",
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.search),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            child: IconButton(
                                              onPressed: () {
                                                UtilPref.isGridSet(!(UtilPref.isGrid.value == "true"));
                                              },
                                              icon: UtilPref.isGrid.value == "true"
                                                  ? Icon(Icons.view_list)
                                                  : Icon(Icons.view_module),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Flexible(
                                      child: ListView(
                                        children: [
                                          for (var item in UtilPref.listMenu)
                                            Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    item["category"].toString().toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Wrap(
                                                  children: [
                                                    for (var item2 in item["data"])
                                                      Card(
                                                        color: UtilPref.listorder
                                                                .map((element) => element['title'].toString())
                                                                .toList()
                                                                .contains(item2["title"].toString())
                                                            ? lastClick['title'] == item2["title"].toString()
                                                                ? Colors.green[50]
                                                                : Colors.orange[50]
                                                            : Colors.white,
                                                        child: SizedBox(
                                                          width: 200,
                                                          height: UtilPref.isGrid.value == "true" ? 300 : 100,
                                                          child: InkWell(
                                                            onTap: () {
                                                              final itm = item2;
                                                              final idx = UtilPref.listorder.indexWhere(
                                                                  (element) => element['title'] == itm['title']);
                                                              if (idx == -1) {
                                                                itm['qty'] = 1;
                                                                itm['note'] = "";
                                                                UtilPref.listorder.add(itm);
                                                              } else {
                                                                UtilPref.listorder[idx]['qty'] =
                                                                    UtilPref.listorder[idx]['qty'] + 1;
                                                              }

                                                              lastClick.value = item2;
                                                              UtilPref.listorderSet(List.from(UtilPref.listorder));
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Visibility(
                                                                  visible: UtilPref.isGrid.value == "true",
                                                                  child: SizedBox(
                                                                    height: 200,
                                                                    width: 200,
                                                                    child: Image.network(
                                                                      item2["image"],
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    item2["title"].toString(),
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    item2["price"].toString(),
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.cyan),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                        ),
                      ),
                      Obx(
                        () => Container(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: Column(
                            children: [
                              Row(children: [
                                // total
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Total : Rp. ${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue!.toString()) + (int.parse(element['price'].toString().replaceAll(".", "")) * element['qty']))}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                              Flexible(
                                child: ListView(
                                  children: [
                                    for (var item in UtilPref.listorder)
                                      Ink(
                                        color: lastClick['title'] == item['title'] ? Colors.green[50] : Colors.white,
                                        child: ListTile(
                                          onLongPress: () {
                                            Get.dialog(
                                              AlertDialog(
                                                title: Text("Add Some Note"),
                                                content: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: "Note",
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: InputBorder.none,
                                                  ),
                                                  controller: TextEditingController(text: item['note']),
                                                  onChanged: (value) {
                                                    item['note'] = value;
                                                    UtilPref.listorderSet(List.from(UtilPref.listorder));
                                                  },
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    child: Text("Clear"),
                                                    onPressed: () {
                                                      item['note'] = "";
                                                      UtilPref.listorderSet(List.from(UtilPref.listorder));
                                                      Get.back();
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          onTap: () {
                                            final idx = UtilPref.listorder
                                                .indexWhere((element) => element['title'] == item['title']);
                                            if (idx != -1) {
                                              if (UtilPref.listorder[idx]['qty'] > 1) {
                                                UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] - 1;
                                              } else {
                                                UtilPref.listorder.removeAt(idx);
                                              }
                                            }
                                            lastClick.value = UtilPref.listorder[idx];
                                            UtilPref.listorderSet(List.from(UtilPref.listorder));
                                          },
                                          leading: CircleAvatar(
                                            child: Text(
                                              item["qty"].toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          title: Text(item["title"].toString()),
                                          isThreeLine: true,
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item["price"].toString()),
                                              Visibility(
                                                visible: item["note"].toString() != "",
                                                child: Text(item["note"].toString()),
                                              )
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              UtilPref.listorder.remove(item);
                                              UtilPref.listorderSet(List.from(UtilPref.listorder));
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // total item
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "${UtilPref.listorder.length}: Item / ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // total qty
                                          Text(
                                            "${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue.toString()) + element['qty'])}: Qty",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MaterialButton(
                                        color: Colors.blue,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "Checkout",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {})
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLoad() async {
    final result = <Map<String, dynamic>>[];
    for (var item in listMenuItem) {
      var response = await http.get(Uri.parse(item["data"].toString()));
      result.add({
        "category": item["category"].toString(),
        "data": json.decode(response.body),
      });
    }
    UtilPref.listMenuSet(result);
  }
}
