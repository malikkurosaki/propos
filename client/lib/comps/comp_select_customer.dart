import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/util_value.dart';

class CompSelectCustomer extends StatelessWidget {
  CompSelectCustomer({Key? key, required this.onCustomerChanged, required this.value}) : super(key: key);

  final customer = {}.obs;
  final Map? value;
  final Function(Map customer)? onCustomerChanged;

  _onload() {
    if (value != null) {
      customer.value = value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _onload();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text(customer['name'] ?? "-"),
          subtitle: Text("Customer"),
          trailing: Icon(Icons.arrow_drop_down),
          onTap: () => _dialogSelectCustomer(context, sizingInformation),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () => _dialogSelectCustomer(context, sizingInformation),
        //     child: Chip(
        //       label: Container(
        //         padding: const EdgeInsets.all(8),
        //         width: double.infinity,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text("Customer"),
        //             Text(
        //               customer['name'] ?? "",
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 18),
        //             ),
        //           ],
        //         ),
        //       ),
        //       backgroundColor: Colors.grey[200],
        //       avatar: const CircleAvatar(
        //         backgroundColor: Colors.green,
        //         child: Icon(
        //           Icons.account_circle_rounded,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  _dialogSelectCustomer(BuildContext context, SizingInformation sizingInformation) async {
    _onload();
    final listCustomer = List.from(GVal.customers.value.val).obs;
    showBottomSheet(
        context: context,
        builder: (context) => Material(
              child: Column(
                children: [
                  CompAppBar(
                    title: "Select Customer",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        listCustomer.assignAll(List.from(GVal.customers.value.val).where(
                            (element) => element['name'].toString().toLowerCase().contains(value.toLowerCase())));
                      },
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                          fillColor: Colors.grey[100],
                          filled: true,
                          hintText: "eg: gunawan",
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  Flexible(
                    child: Obx(
                      () => GridView.extent(
                        controller: ScrollController(),
                        childAspectRatio: 12 / 8,
                        maxCrossAxisExtent: Get.width / (sizingInformation.isMobile ? 2 : 6),
                        children: [
                          for (final cus in listCustomer)
                            InkWell(
                              onTap: () {
                                customer.assignAll(cus);
                                onCustomerChanged!(cus);
                                Get.back();
                              },
                              child: Card(
                                color: Colors.grey[100],
                                child: Column(
                                  children: [
                                    const Flexible(
                                      child: Center(
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 70,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.black45,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            cus['name'].toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            cus['phone'].toString(),
                                            style: const TextStyle(color: Colors.white),
                                          ),
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
                  )
                ],
              ),
            ));
    // Get.dialog(
    //   Dialog(
    //     child: ResponsiveBuilder(
    //       builder: (context, sizingInformation) =>
    //       Column(
    //         children: [
    //           Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: CircleAvatar(
    //                   backgroundColor: Colors.grey[100],
    //                   child: BackButton(
    //                     color: Colors.grey[700],
    //                   ),
    //                 ),
    //               ),
    //               const Expanded(
    //                 child: Padding(
    //                   padding: EdgeInsets.all(8.0),
    //                   child: Text("Select Customer"),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: CircleAvatar(
    //                   backgroundColor: Colors.grey[100],
    //                   child: IconButton(
    //                     onPressed: () {
    //                       customer.value = {};
    //                       onCustomerChanged!({});
    //                       Get.back();
    //                     },
    //                     icon: Icon(
    //                       Icons.delete,
    //                       color: Colors.red[300],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: TextFormField(
    //               onChanged: (value) {
    //                 listCustomer.assignAll(List.from(GVal.customers.value.val)
    //                     .where((element) => element['name'].toString().toLowerCase().contains(value.toLowerCase())));
    //               },
    //               controller: TextEditingController(),
    //               decoration: InputDecoration(
    //                   border: const OutlineInputBorder(borderSide: BorderSide.none),
    //                   fillColor: Colors.grey[100],
    //                   filled: true,
    //                   hintText: "eg: gunawan",
    //                   prefixIcon: const Icon(Icons.search)),
    //             ),
    //           ),
    //           Flexible(
    //             child: Obx(
    //               () => GridView.extent(
    //                 childAspectRatio: 12 / 8,
    //                 maxCrossAxisExtent: Get.width / (sizingInformation.isMobile ? 2 : 6),
    //                 children: [
    //                   for (final cus in listCustomer)
    //                     InkWell(
    //                       onTap: () {
    //                         customer.assignAll(cus);
    //                         onCustomerChanged!(cus);
    //                         Get.back();
    //                       },
    //                       child: Card(
    //                         color: Colors.grey[100],
    //                         child: Column(
    //                           children: [
    //                             const Flexible(
    //                               child: Center(
    //                                 child: Icon(
    //                                   Icons.account_circle,
    //                                   size: 70,
    //                                   color: Colors.grey,
    //                                 ),
    //                               ),
    //                             ),
    //                             Container(
    //                               width: double.infinity,
    //                               color: Colors.black45,
    //                               padding: const EdgeInsets.all(8.0),
    //                               child: Column(
    //                                 children: [
    //                                   Text(
    //                                     cus['name'].toString(),
    //                                     style: const TextStyle(
    //                                       fontSize: 16,
    //                                       color: Colors.white,
    //                                       fontWeight: FontWeight.bold,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     cus['phone'].toString(),
    //                                     style: const TextStyle(color: Colors.white),
    //                                   ),
    //                                 ],
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
