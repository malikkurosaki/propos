import 'package:client/cashier_sub_main.dart';
import 'package:client/cashier_page_payment.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'util_pref.dart';

class CashierSubOrder extends StatelessWidget {
  const CashierSubOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => Column(
          children: [
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                  child: Text(
                    "Rp. ${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue!.toString()) + (int.parse(element['price'].toString().replaceAll(".", "")) * element['qty']))}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Visibility(
                  visible: sizingInformation.isMobile,
                  child: IconButton(
                      onPressed: () {
                        Get.dialog(Material(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    BackButton(),
                                  ],
                                ),
                              ),
                              Flexible(child: CashierSubMain())
                            ],
                          ),
                        ));
                      },
                      icon: Icon(
                        Icons.post_add_rounded,
                        color: Colors.purple,
                      )),
                ),
                IconButton(
                    onPressed: () {
                      // delete all item
                      Get.dialog(AlertDialog(
                        backgroundColor: Colors.red[100],
                        title: Text("Delete All"),
                        content: Text("Mau Menghapus Semuanya ?"),
                        actions: [
                          MaterialButton(
                              child: Text("Ya"),
                              onPressed: () {
                                UtilPref.listorderSet([]);
                                Get.back();
                              }),
                          MaterialButton(
                              child: Text("Tidak"),
                              onPressed: () {
                                Get.back();
                              })
                        ],
                      ));
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.cyan,
                    ))
              ]),
            ),
            Flexible(
              child: ListView(
                children: [
                  for (var item in UtilPref.listorder)
                    Card(
                      elevation: UtilPref.lastClick['title'] == item['title'] ? 4 : 0,
                      color: UtilPref.lastClick['title'] == item['title'] ? Colors.cyan[100] : Colors.pink[50],
                      child: ListTile(
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Colors.green[100],
                              title: Text("Add Some Note"),
                              content: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Note",
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(color: Colors.transparent)),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
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
                          UtilPref.listorderSet(List.from(UtilPref.listorder));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            item["qty"].toString(),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                          ),
                        ),
                        title: Text(
                          item["title"].toString(),
                          style: TextStyle(fontSize: 12
                              // color: UtilPref.listorder
                              //         .map((element) => element['title'].toString())
                              //         .toList()
                              //         .contains(item["title"].toString())
                              //     ? UtilPref.lastClick['title'] == item["title"].toString()
                              //         ? Colors.white
                              //         : Colors.black
                              //     : Colors.black,
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
                        trailing: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: InkWell(
                            onTap: () {
                              // reduce qty
                              final idx =
                                  UtilPref.listorder.indexWhere((element) => element['title'] == item['title']);
                              if (item['qty'] > 1) {
                                UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] - 1;
                              } else {
                                UtilPref.listorder.removeWhere((element) => element['title'] == item['title']);
                              }

                              UtilPref.lastClick.value = item;
                              UtilPref.listorderSet(List.from(UtilPref.listorder));
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
                                        UtilPref.listorder
                                            .removeWhere((element) => element['title'] == item['title']);
                                        UtilPref.listorderSet(List.from(UtilPref.listorder));
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
                ],
              ),
            ),
            Card(
              color: Colors.brown[50],
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // total item
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${UtilPref.listorder.length}: Item / ",
                              style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // total qty
                            Text(
                              "${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue.toString()) + element['qty'])}: Qty",
                              style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                      onPressed: () {
                        UtilRoutes.cashierPayment().go();;
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
