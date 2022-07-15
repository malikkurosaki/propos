import 'dart:math';

import 'package:client/cashiers/cashier_fun.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/util_value.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const CashierSubOrderItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            color: UtilValue.lastClick["id"] == item["id"] ? Colors.grey[100] : Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 0.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: UtilValue.lastClick["id"] == item["id"],
              child: Center(
                child: Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(8),
                  height: 115,
                  child: Column(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () => CashierFun.addQty(item),
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
                  if (UtilValue.lastClick["id"] == item["id"]) {
                    UtilValue.lastClickSet(value: {});
                  } else {
                    UtilValue.lastClickSet(value: item);
                  }
                },
                onLongPress: dialogDeleteQty,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item["name"].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  // color: Colors.brown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: UtilValue.lastClick["id"] == item["id"] ? Colors.grey[700] : Colors.grey[600],
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
                                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[600]
                                              // color: UtilPref.lastClick["id"] == item["id"] ? Colors.white : Colors.brown,
                                              ),
                                        ),
                                      ),
                                      const Text("x"),
                                      Chip(
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          "Rp. " + item["price"].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(locale: "id_ID")
                                      .format(
                                        (item["price"] * item["qty"]),
                                      )
                                      .toString()
                                      .replaceAll(",00", ""),
                                ),
                              ],
                            ),
                            Visibility(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Chip(
                                  backgroundColor: Colors.grey[50],
                                  avatar: CircleAvatar(
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  label: Text(
                                    item["note"].toString(),
                                  ),
                                ),
                              ),
                              visible: item["note"].toString().isNotEmpty && UtilValue.lastClick["id"] != item["id"],
                            ),
                            Visibility(
                              visible: UtilValue.lastClick["id"] == item["id"],
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Chip(
                                    backgroundColor: Colors.white,
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    label: item["note"].toString().isEmpty
                                        ? const SizedBox.shrink()
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
        title: const Text("Delete Item"),
        content: const Text("Are you sure want to delete this item?"),
        actions: [
          MaterialButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
          MaterialButton(
            child: const Text("Delete"),
            onPressed: () {
              GVal.listOrders.value.val.removeWhere((element) => element["id"] == item["id"]);
              GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
              GVal.listOrders.refresh();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void reduceQty() {
    final idx = GVal.listOrders.value.val.indexWhere((element) => element["id"] == item["id"]);
    if (item['qty'] > 1) {
      GVal.listOrders.value.val[idx]['qty'] = GVal.listOrders.value.val[idx]['qty'] - 1;
      GVal.listOrders.refresh();

    } else {
      Get.dialog(
        AlertDialog(
          title: const Text("Delete Item"),
          content: const Text("Are you sure want to delete this item?"),
          actions: [
            MaterialButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            MaterialButton(
              child: const Text("Delete"),
              onPressed: () {
                GVal.listOrders.value.val.removeWhere((element) => element["id"] == item["id"]);
                GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
                GVal.listOrders.refresh();
                Get.back();
              },
            ),
          ],
        ),
      );
      // UtilPref.listorder.removeWhere((element) => element["id"] == item["id"]);
    }

    UtilValue.lastClick.value = item;
    GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
    GVal.listOrders.refresh();
  }

  

  void dialogNote(String note) {
    Get.dialog(
      anido.ElasticIn(
        child: AlertDialog(
          title: const Text(
            "Add Some Note",
          ),
          content: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.edit),
              labelText: "Note",
              fillColor: Colors.grey[50],
              filled: true,
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            ),
            controller: TextEditingController(text: item['note']),
            onChanged: (value) {
              item['note'] = value;
              GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
              GVal.listOrders.refresh();
            },
          ),
          actions: [
            MaterialButton(
              child: const Text("Clear"),
              onPressed: () {
                item['note'] = "";
                Get.back();
              },
            ),
            MaterialButton(
              color: Colors.green,
              child: const Text(
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
