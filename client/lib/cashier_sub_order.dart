import 'dart:convert';

import 'package:client/cashier_sub_main.dart';
import 'package:client/cashier_page_payment.dart';
import 'package:client/cashier_sub_order_item.dart';
import 'package:client/cashier_sub_order_option_panel.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import 'util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrder extends GetWidget {
  CashierSubOrder({Key? key}) : super(key: key);
  final nameSaveOrder = "".obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: [
          Obx(
            () => Container(
              color: Colors.brown[100],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => Text(
                          NumberFormat.simpleCurrency(locale: "id_ID")
                              .format(UtilPref.listorder.fold(
                                  0,
                                  (previousValue, element) =>
                                      int.parse(previousValue!.toString()) +
                                      (int.parse(element['price'].toString().replaceAll(".", "")) * element['qty'])))
                              .replaceAll(",00", "")
                              .replaceAll("Rp", ""),
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
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
                                      CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        child: BackButton(color: Colors.white),
                                      ),
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {

                          if (UtilPref.listorder.isEmpty) {
                            EasyLoading.showToast("Your order is empty");
                            return;
                          }

                          if (UtilPref.savedOrder.isNotEmpty) {
                            final index = UtilPref.listSaveOrder
                                .indexWhere((element) => element['id'] == UtilPref.savedOrder['id']);

                            // final data = {
                            //   "id": Uuid().v4(),
                            //   "name": nameSaveOrder.value,
                            //   "order": List.from(UtilPref.listorder),
                            //   "pax": UtilPref.pax.value,
                            //   "customer": Map.from(UtilPref.customer),
                            //   "date": DateTime.now().toString()
                            // };

                            UtilPref.savedOrder["order"] = List.from(UtilPref.listorder);
                            UtilPref.savedOrder["pax"] = UtilPref.pax.value;
                            UtilPref.savedOrder["customer"] = Map.from(UtilPref.customer);
                            UtilPref.listSaveOrder[index] = Map.from(UtilPref.savedOrder);
                            UtilPref.listSaveOrderSet(value: List.from(UtilPref.listSaveOrder));

                            EasyLoading.showToast("data updated");
                            return;
                          }

                          Get.dialog(
                            anido.ElasticIn(
                              child: AlertDialog(
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
                                        onChanged: (value) => nameSaveOrder.value = value,
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
                                    onPressed: () {
                                      // check is empty name
                                      if (nameSaveOrder.value.isEmpty) {
                                        EasyLoading.showError("Please fill order name");
                                        return;
                                      }

                                      // check duplicate name
                                      if (UtilPref.listSaveOrder
                                          .any((element) => element['name'] == nameSaveOrder.value)) {
                                        EasyLoading.showError("Order name already exist");
                                        return;
                                      }

                                      if (UtilPref.listorder.isEmpty) {
                                        EasyLoading.showError("Please add order");
                                        return;
                                      }

                                      final data = {
                                        "id": Uuid().v4(),
                                        "name": nameSaveOrder.value,
                                        "order": List.from(UtilPref.listorder),
                                        "pax": UtilPref.pax.value,
                                        "customer": Map.from(UtilPref.customer),
                                        "date": DateTime.now().toString()
                                      };

                                      EasyLoading.show(status: "Saving...");
                                      UtilPref.listSaveOrder.add(data);
                                      UtilPref.listSaveOrderSet();
                                      UtilPref.listorderSet(value: []);
                                      EasyLoading.showSuccess("Save order success");

                                      Get.back();
                                    },
                                  ),
                                  MaterialButton(
                                    color: Colors.teal[300],
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      EasyLoading.showToast("Baek lah, ga jadi ...");
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: Icon(UtilPref.savedOrder.isEmpty ? Icons.save : Icons.update, color: Colors.cyan)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          if (UtilPref.listorder.isEmpty) {
                            EasyLoading.showToast("Your order is empty");
                            return;
                          }

                          // delete all item
                          Get.dialog(
                            anido.ElasticIn(
                              child: AlertDialog(
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
                                        UtilPref.listorderSet(value: []);
                                        UtilPref.savedOrderSet(value: {});
                                        UtilPref.paxSet(value: 1);
                                        UtilPref.customerSet(value: {});
                                        
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
                            ),
                          );
                        },
                        icon: Tooltip(
                          message: "Delete All",
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CashierSubOrderOptionPanel(),
          Flexible(
            child: Obx(
              () => ListView.builder(
                  controller: ScrollController(),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = UtilPref.listorder[index];
                    return CashierSubOrderItem(item: item);
                  },
                  itemCount: UtilPref.listorder.length),
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
