import 'package:client/cashier_sub_main.dart';
import 'package:client/cashier_page_payment.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'util_pref.dart';

class CashierSubOrder extends GetWidget {
  const CashierSubOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: [
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                        "Rp. ${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue!.toString()) + (int.parse(element['price'].toString().replaceAll(".", "")) * element['qty']))}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
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
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.purple,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Save"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Cancel"),
                      value: 2,
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.teal,
                          title: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Are you sure to save this order?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.teal[100],
                                    filled: true,
                                    labelText: "Order Name",
                                  ),
                                  controller: TextEditingController(
                                      text: UtilPref.listorder.isNotEmpty ? UtilPref.listorder[0]['name'] : ""),
                                ),
                              )
                            ],
                          ),
                          actions: [
                            MaterialButton(
                              color: Colors.teal[800],
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                            MaterialButton(
                              color: Colors.teal[300],
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      );
                    } else {

                    }
                  },
                ),
               
                IconButton(
                  onPressed: () {
                    // delete all item
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.red,
                        title: Text(
                          "Delete All",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        content: Text(
                          "Mau Menghapus Semuanya ?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        actions: [
                          MaterialButton(
                              color: Colors.red[800],
                              child: Text(
                                "Ya",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                UtilPref.listorderSet([]);
                                Get.back();
                              }),
                          MaterialButton(
                            color: Colors.red[300],
                            child: Text(
                              "Tidak",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Tooltip(
                      message: "Delete All",
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red[300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Obx(
              () => ListView(
                physics: BouncingScrollPhysics(),
                controller: ScrollController(
                  keepScrollOffset: true,
                ),
                children: [
                  Tooltip(
                    message: "Show Order Options",
                    child: ExpansionTile(
                      iconColor: Colors.green,
                      textColor: Colors.green,
                      collapsedBackgroundColor: Colors.green[100],
                      backgroundColor: Colors.green[200],
                      title: Text("Order Options",
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_circle),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("PAX COUNT"),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.green[100],
                                child: Text(
                                  "+",
                                  style: TextStyle(fontSize: 24),
                                ),
                                onPressed: () {
                                  UtilPref.paxSet((UtilPref.pax.value+1));
                                }),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                UtilPref.pax.value.toString(),
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.green[100],
                                child: Text(
                                  "-",
                                  style: TextStyle(fontSize: 24),
                                ),
                                onPressed: () {
                                   if(UtilPref.pax.value > 1){
                                     UtilPref.paxSet((UtilPref.pax.value -1));
                                   }
                                })
                          ],
                        ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.dashboard_customize,
                        //     color: Colors.brown,
                        //   ),
                        //   title: TextFormField(
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(50),
                        //         borderSide: BorderSide(
                        //           color: Colors.brown,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(50),
                        //         borderSide: BorderSide(
                        //           color: Colors.transparent,
                        //         ),
                        //       ),
                        //       fillColor: Colors.brown[100],
                        //       filled: true,
                        //       labelText: "PAX",
                        //     ),
                        //     controller: TextEditingController(
                        //         text: UtilPref.listorder.isNotEmpty ? UtilPref.listorder[0]['name'] : ""),
                        //   ),
                        //   onTap: () {},
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.green[50],
                          child: ListTile(
                            leading: Icon(
                              Icons.people,
                              color: Colors.green,
                            ),
                            title: Text(
                              "Customer",
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () {},
                            trailing: Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var item in UtilPref.listorder)
                    Card(
                      elevation: UtilPref.lastClick['title'] == item['title'] ? 4 : 0,
                      color: UtilPref.lastClick['title'] == item['title'] ? Colors.cyan[100] : Colors.pink[50],
                      child: Tooltip(
                        message: "long press to add some note\nsingle tap to add some quantity",
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
                          trailing: Tooltip(
                            message: "Reduce Some Quantity",
                            child: CircleAvatar(
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
                      ),
                    ),
                ],
              ),
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          color: Colors.brown[100],
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${UtilPref.listorder.length}: Item / ",
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // total qty
                              Text(
                                "${UtilPref.listorder.fold(0, (previousValue, element) => int.parse(previousValue.toString()) + element['qty'])}: Qty",
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: "Checkout To Proccess Payment",
                    child: MaterialButton(
                      color: Colors.purple[300],
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
                        UtilRoutes.cashierPayment().go();
                        ;
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
