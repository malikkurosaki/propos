import 'dart:convert';

import 'package:client/cashiers/cashier_sub_main.dart';
import 'package:client/cashiers/cashier_page_payment.dart';
import 'package:client/cashiers/cashier_sub_order_item.dart';
import 'package:client/cashiers/cashier_pax_customer.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import '../utils/util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubOrder extends GetWidget {
  CashierSubOrder({Key? key}) : super(key: key);
  final nameSaveOrder = "".obs;
  final ScrollController con = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        color: Colors.grey[50],
        child: Column(
          children: [
            Obx(
              () => Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        NumberFormat.simpleCurrency(locale: "id_ID")
                            .format(UtilPref.listorder.fold(
                                0,
                                (previousValue, element) =>
                                    int.parse(previousValue!.toString()) +
                                    (int.parse(element['price'].toString().replaceAll(".", "")) * element['qty'])))
                            .replaceAll(",00", "")
                            .replaceAll("Rp", ""),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      ),
                    ),
                    Visibility(
                      visible: sizingInformation.isMobile,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Get.dialog(Material(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          BackButton(color: Colors.grey),
                                        ],
                                      ),
                                      Flexible(
                                        child: CashierSubMain(),
                                      )
                                    ],
                                  ),
                                ));
                              },
                              icon: Icon(
                                Icons.post_add_rounded,
                                color: Colors.cyan,
                              )),
                        ),
                      ),
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
            const CashierPaxCustomer(),
            Flexible(
              child: Container(
                color: Colors.grey[100],
                child: Obx(
                  () => ListView.builder(
                      controller: UtilVal.listOrderController,
                      reverse: true,
                      // controller: ScrollController(keepScrollOffset: true, initialScrollOffset: 0),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = UtilPref.listorder[index];
                        return CashierSubOrderItem(
                          item: item,
                        );
                      },
                      itemCount: UtilPref.listorder.length),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: UtilPref.listorder.isNotEmpty,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.grey[50],
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ExpansionTile(
                            expandedAlignment: Alignment.centerLeft,
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            childrenPadding: EdgeInsets.all(16),
                            title: Text("Details"),
                            children: [
                              Text('''
                    iiff
                    
                    
                    dsdsd
                    sdsd
                    
                    dsdsds
                    s
                    
                    
                    dsdsd
                    sd
                    sd
                    sd
                    sd
                    sd
                    sdsds
                    ds
                    ds
                    ds
                    ds
                    ''')
                            ],
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: Colors.green,
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
