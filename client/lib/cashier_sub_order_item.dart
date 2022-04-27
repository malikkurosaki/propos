import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const CashierSubOrderItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => anido.ElasticInDown(
          duration: Duration(milliseconds: Random().nextInt(600) + 500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => UtilPref.lastClick.value = item,
                  onLongPress: dialogDeleteQty,
                  child: Card(
                    color: UtilPref.lastClick['title'] == item['title'] ? Colors.cyan[200] : Colors.white,
                    elevation: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              // backgroundColor:
                              //     UtilPref.lastClick['title'] == item['title'] ? Colors.green : Colors.brown[50],
                              child: Text(
                                item["qty"].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey
                                    // color: UtilPref.lastClick['title'] == item['title'] ? Colors.white : Colors.brown,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
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
                                    color: UtilPref.lastClick['title'] == item['title'] ? Colors.white : Colors.blueGrey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Rp. " + item["price"].toString()),
                              ),
                              Visibility(
                                visible: UtilPref.lastClick['title'] == item['title'],
                                child: InkWell(
                                  child: Chip(
                                    backgroundColor:
                                        item["note"].toString().isEmpty ? Colors.transparent : Colors.grey[100],
                                    avatar: CircleAvatar(
                                        backgroundColor: Colors.green[300],
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    label: item["note"].toString().isEmpty
                                        ? SizedBox.shrink()
                                        : Text(item["note"].toString()),
                                  ),
                                  onTap: () => dialogNote(item["note"]),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child: item["note"].toString() == ""
                              //       ? CircleAvatar(
                              //           backgroundColor: Colors.brown[50],
                              //           child: IconButton(color: Colors.brown, onPressed: dialogNote, icon: Icon(Icons.edit)),
                              //         )
                              //       : Card(color: Colors.brown[50], child: Text(item["note"].toString())),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: UtilPref.lastClick['title'] == item['title'],
                child: Card(
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
                        Divider(),
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
              )
            ],
          )
          // Card(
          //   elevation: UtilPref.lastClick['title'] == item['title'] ? 4 : 0,
          //   color: UtilPref.lastClick['title'] == item['title'] ? Colors.cyan[100] : Colors.pink[50],
          //   child: Tooltip(
          //     message: "long press to add some note\nsingle tap to add some quantity",
          //     child: ListTile(
          //       onLongPress: () {
          //         Get.dialog(
          //           anido.ElasticIn(
          //             child: AlertDialog(
          //               backgroundColor: Colors.green[100],
          //               title: Text("Add Some Note"),
          //               content: TextFormField(
          //                 decoration: InputDecoration(
          //                   labelText: "Note",
          //                   fillColor: Colors.white,
          //                   filled: true,
          //                   enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.transparent)),
          //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          //                 ),
          //                 controller: TextEditingController(text: item['note']),
          //                 onChanged: (value) {
          //                   item['note'] = value;
          //                   UtilPref.listorderSet(value: List.from(UtilPref.listorder));
          //                 },
          //               ),
          //               actions: [
          //                 MaterialButton(
          //                   child: Text("Clear"),
          //                   onPressed: () {
          //                     item['note'] = "";
          //                     UtilPref.listorderSet(value: List.from(UtilPref.listorder));
          //                     Get.back();
          //                   },
          //                 ),
          //                 MaterialButton(
          //                   child: Text("OK"),
          //                   onPressed: () {
          //                     Get.back();
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //       onTap: () {
          //         // add qty
          //         final idx = UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
          //         if (idx == -1) {
          //           item['qty'] = 1;
          //           item['note'] = "";
          //           UtilPref.listorder.add(item);
          //         } else {
          //           UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
          //         }

          //         UtilPref.lastClick.value = item;
          //         UtilPref.listorderSet(value: List.from(UtilPref.listorder));
          //       },
          //       leading: Tooltip(
          //         message: "Add Some Quantity",
          //         child: CircleAvatar(
          //           backgroundColor: Colors.white,
          //           child: Text(
          //             item["qty"].toString(),
          //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
          //           ),
          //         ),
          //       ),
          //       title: Text(
          //         item["title"].toString(),
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       isThreeLine: true,
          //       subtitle: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text("Rp. " + item["price"].toString()),
          //           Visibility(
          //             visible: item["note"].toString() != "",
          //             child: Container(
          //                 margin: EdgeInsets.only(top: 8),
          //                 padding: EdgeInsets.only(bottom: 4, left: 16, right: 16, top: 4),
          //                 decoration: BoxDecoration(
          //                   color: Colors.pink[100],
          //                   borderRadius: BorderRadius.circular(8),
          //                 ),
          //                 child: Text(item["note"].toString())),
          //           )
          //         ],
          //       ),
          //       trailing: Tooltip(
          //         message: "Reduce Some Quantity",
          //         child: CircleAvatar(
          //           backgroundColor: Colors.white,
          //           child: InkWell(
          //             onTap: () {
          //               // reduce qty
          //               final idx = UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
          //               if (item['qty'] > 1) {
          //                 UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] - 1;
          //               } else {
          //                 UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
          //               }

          //               UtilPref.lastClick.value = item;
          //               UtilPref.listorderSet(value: List.from(UtilPref.listorder));
          //             },
          //             onLongPress: () {
          //               // delete item dialog
          //               Get.dialog(
          //                 AlertDialog(
          //                   title: Text("Delete Item"),
          //                   content: Text("Are you sure want to delete this item?"),
          //                   actions: [
          //                     MaterialButton(
          //                       child: Text("Cancel"),
          //                       onPressed: () {
          //                         Get.back();
          //                       },
          //                     ),
          //                     MaterialButton(
          //                       child: Text("Delete"),
          //                       onPressed: () {
          //                         UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
          //                         UtilPref.listorderSet(value: List.from(UtilPref.listorder));
          //                         Get.back();
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //             child: Icon(Icons.remove, color: Colors.red[200]),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
      UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
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
          backgroundColor: Colors.green,
          title: Text("Add Some Note", 
          style: TextStyle(
            color: Colors.white
          ),
          ),
          content: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit),
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
                UtilPref.listorderSet();
                UtilPref.listorder.refresh();
                Get.back();
              },
            ),
            MaterialButton(
              color: Colors.green[200],
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
