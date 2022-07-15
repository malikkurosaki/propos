import 'package:client/comps/comp_app_bar.dart';
import 'package:client/comps/comp_select_customer.dart';
import 'package:client/cashiers/cashier_sub_main.dart';
import 'package:client/cashiers/cashier_sub_order_item.dart';
import 'package:client/comps/comp_detail_print.dart';
import 'package:client/comps/comp_save_order.dart';
import 'package:client/comps/comp_select_pax.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import '../utils/util_value.dart';

class CashierSubOrder extends GetWidget {
  CashierSubOrder({Key? key}) : super(key: key);
  final nameSaveOrder = "".obs;
  final ScrollController con = ScrollController();
  final pax = 1.obs.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) => Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey[50], border: Border.all(color: Colors.grey.shade300)),
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
                              .format(GVal.listOrders.value.val.fold(
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
                                          children: const [
                                            BackButton(color: Colors.grey),
                                          ],
                                        ),
                                        const Flexible(
                                          child: CashierSubMain(),
                                        )
                                      ],
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.post_add_rounded,
                                  color: Colors.cyan,
                                )),
                          ),
                        ),
                      ),
                      CompSaveOrder(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              if (GVal.listOrders.value.val.isEmpty) {
                                EasyLoading.showToast("Your order is empty");
                                return;
                              }

                              // delete all item
                              Get.dialog(
                                AlertDialog(
                                  backgroundColor: Colors.red,
                                  title: const Text(
                                    "Delete All",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: const Text(
                                    "Mau Menghapus Semuanya ?",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                        color: Colors.red[800],
                                        child: const Text(
                                          "Ya",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          GVal.listOrders.value.val =  [];
                                          GVal.listOrders.refresh();
                                          
                                          // UtilValue.savedOrderSet(value: {});
                                          GVal.savedOrder.value.val = {};
                                          GVal.savedOrder.refresh();
                                          // UtilValue.paxSet(value: 1);
                                          // pax
                                          // UtilValue.customerSet(value: {});
                                          GVal.customer.value.val = {};
                                          GVal.customer.refresh();

                                          Get.back();
                                        }),
                                    MaterialButton(
                                      color: Colors.red[300],
                                      child: const Text(
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
              // CompSelectCustomer(
              //   value: GVal.customer.value.val,
              //   defaultPax: GVal.pax.value.val.toString(),
              //   onPaxChanged: (value) {

              //     GVal.pax.value.val = int.parse(value);
              //     GVal.pax.refresh();

              //   },
              //   onCustomerChanged: (value) {
              //     GVal.customer.value.val = Map.from(value);
              //     GVal.customer.refresh();

              //   },
              // ),
              Divider(),
              Obx(
                () => Row(
                  children: [
                    Flexible(
                      child: CompSelectPax(),
                    ),
                    Container(
                      height: 32,
                      width: 1,
                      color: Colors.grey,
                    ),
                    Flexible(
                      child: CompSelectCustomer(
                        onCustomerChanged: (customer) {
                          // disini
                          GVal.customer.value.val = customer;
                          GVal.customer.refresh();
                        },
                        value: GVal.customer.value.val,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.grey[100],
                  child: Obx(
                    () => ListView(
                      controller: UtilVal.listOrderController,
                      children: [
                        for (final item in GVal.listOrders.value.val)
                          CashierSubOrderItem(
                            item: item,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: GVal.listOrders.value.val.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [Text("Detail Order"), Icon(Icons.arrow_drop_down)],
                          ),
                          onPressed: () {
                            showBottomSheet(
                              backgroundColor: Colors.white,
                              elevation: 4,
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CompAppBar(title: "Detail Order",),
                                    Flexible(
                                      child: CompDetailPrint(),
                                    ),
                                    // Center(
                                    //   child: IconButton(
                                    //     onPressed: () {
                                    //       Get.back();
                                    //     },
                                    //     icon: const Icon(Icons.arrow_downward),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                            // ExpansionTile(
                            //   leading: CircleAvatar(
                            //     backgroundColor: Colors.grey[100],
                            //     child: Icon(
                            //       Icons.shopping_cart,
                            //       color: Colors.blue,
                            //     ),
                            //   ),
                            //   expandedAlignment: Alignment.centerLeft,
                            //   expandedCrossAxisAlignment: CrossAxisAlignment.center,
                            //   childrenPadding: EdgeInsets.all(16),
                            //   title: Text("Details"),
                            //   children: [

                            //   ],
                            // ),
                            ),
                        MaterialButton(
                          color: Colors.blue,
                          child: const Padding(
                            padding: EdgeInsets.all(10),
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
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
