import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const CashierSubOrderItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        // color: UtilPref.lastClick['title'] == item['title'] ? Colors.white : Colors.grey[200],
        elevation: UtilPref.lastClick['title'] == item['title'] ? 8 : 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: UtilPref.lastClick['title'] == item['title'],
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 115,
                  child: Column(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: addQty,
                          child: SizedBox(
                            child: Center(
                              child: Icon(
                                Icons.add_circle,
                                size: 32,
                                color: Colors.green[300],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey[300],
                        width: 30,
                      ),
                      Flexible(
                          child: InkWell(
                        onTap: reduceQty,
                        child: SizedBox(
                            child: Center(
                          child: Icon(
                            Icons.remove_circle,
                            size: 32,
                            color: Colors.pink[300],
                          ),
                        )),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (UtilPref.lastClick['title'] == item['title']) {
                    UtilPref.lastClickSet(value: {});
                  } else {
                    UtilPref.lastClickSet(value: item);
                  }
                },
                onLongPress: dialogDeleteQty,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CircleAvatar(
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //       // backgroundColor:
                    //       //     UtilPref.lastClick['title'] == item['title'] ? Colors.green : Colors.brown[50],
                    //       child: Text(
                    //         item["qty"].toString(),
                    //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey
                    //             // color: UtilPref.lastClick['title'] == item['title'] ? Colors.white : Colors.brown,
                    //             ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item["title"].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  // color: Colors.brown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      UtilPref.lastClick['title'] == item['title'] ? Colors.grey[700] : Colors.blueGrey,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          item["qty"].toString(),
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey
                                              // color: UtilPref.lastClick['title'] == item['title'] ? Colors.white : Colors.brown,
                                              ),
                                        ),
                                      ),
                                      Chip(
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          "Rp. " + item["price"].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Chip(label: Text((item["price"] * item["qty"]).toString())),
                              ],
                            ),
                            Visibility(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Chip(
                                  backgroundColor: Colors.grey[50],
                                  avatar: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                  label: Text(
                                    item["note"].toString(),
                                  ),
                                ),
                              ),
                              visible:
                                  item["note"].toString().isNotEmpty && UtilPref.lastClick['title'] != item['title'],
                            ),
                            Visibility(
                              visible: UtilPref.lastClick['title'] == item['title'],
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Chip(
                                    backgroundColor: Colors.white,
                                    avatar: CircleAvatar(
                                        backgroundColor: Colors.blue[300],
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    label: item["note"].toString().isEmpty
                                        ? SizedBox.shrink()
                                        : Text(item["note"].toString()),
                                  ),
                                ),
                                onTap: () => dialogNote(item["note"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dialogDeleteQty() {
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
  }

  void reduceQty() {
    final idx = UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
    if (item['qty'] > 1) {
      UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] - 1;
    } else {
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
      // UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
    }

    UtilPref.lastClick.value = item;
    UtilPref.listorderSet(value: List.from(UtilPref.listorder));
  }

  void addQty() {
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
  }

  void dialogNote(String note) {
    Get.dialog(
      anido.ElasticIn(
        child: AlertDialog(
          title: Text(
            "Add Some Note",
          ),
          content: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit),
              labelText: "Note",
              fillColor: Colors.grey[50],
              filled: true,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
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
                UtilPref.listorderSet();
                UtilPref.listorder.refresh();
                Get.back();
              },
            ),
            MaterialButton(
              color: Colors.green,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
