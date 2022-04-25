import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const CashierSubOrderItem({required this.item, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return anido.ElasticInDown(
      duration: Duration(milliseconds: Random().nextInt(600) + 500),
      child: Card(
        elevation: UtilPref.lastClick['title'] == item['title'] ? 4 : 0,
        color: UtilPref.lastClick['title'] == item['title'] ? Colors.cyan[100] : Colors.pink[50],
        child: Tooltip(
          message: "long press to add some note\nsingle tap to add some quantity",
          child: ListTile(
            onLongPress: () {
              Get.dialog(
                anido.ElasticIn(
                  child: AlertDialog(
                    backgroundColor: Colors.green[100],
                    title: Text("Add Some Note"),
                    content: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Note",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      controller: TextEditingController(text: item['note']),
                      onChanged: (value) {
                        item['note'] = value;
                        UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                      },
                    ),
                    actions: [
                      MaterialButton(
                        child: Text("Clear"),
                        onPressed: () {
                          item['note'] = "";
                          UtilPref.listorderSet(value: List.from(UtilPref.listorder));
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
                ),
              );
            },
            onTap: () {
              // add qty
              final idx = UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
              if (idx == -1) {
                item['qty'] = 1;
                item['note'] = "";
                UtilPref.listorder.add(item);
              } else {
                UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
              }
    
              UtilPref.lastClick.value = item;
              UtilPref.listorderSet(value: List.from(UtilPref.listorder));
            },
            leading: Tooltip(
              message: "Add Some Quantity",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  item["qty"].toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                ),
              ),
            ),
            title: Text(
              item["title"].toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            isThreeLine: true,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rp. " + item["price"].toString()),
                Visibility(
                  visible: item["note"].toString() != "",
                  child: Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.only(bottom: 4, left: 16, right: 16, top: 4),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item["note"].toString())),
                )
              ],
            ),
            trailing: Tooltip(
              message: "Reduce Some Quantity",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    // reduce qty
                    final idx = UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
                    if (item['qty'] > 1) {
                      UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] - 1;
                    } else {
                      UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
                    }
    
                    UtilPref.lastClick.value = item;
                    UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                  },
                  onLongPress: () {
                    // delete item dialog
                    Get.dialog(
                      AlertDialog(
                        title: Text("Delete Item"),
                        content: Text("Are you sure want to delete this item?"),
                        actions: [
                          MaterialButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          MaterialButton(
                            child: Text("Delete"),
                            onPressed: () {
                              UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
                              UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.remove, color: Colors.red[200]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}