import 'package:client/comps/comp_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as animdo;
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/util_pref.dart';

class CashierPaxCustomer extends StatelessWidget {
  const CashierPaxCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: dialogPax,
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.cyan,
                          child: Icon(
                            Icons.groups,
                            color: Colors.white,
                          ),
                        ),
                        label: Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            UtilPref.pax.value.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: dialogSelectCustomer,
                      child: Chip(
                        label: Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            UtilPref.customer['name'] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        backgroundColor: Colors.grey[200],
                        avatar: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        //  ExpansionTile(
        //   subtitle:
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Chip(
        //         avatar: CircleAvatar(
        //           backgroundColor: Colors.cyan,
        //           child: Icon(
        //             Icons.groups,
        //             color: Colors.white,
        //           ),
        //         ),
        //         label: Text(
        //           UtilPref.pax.value.toString(),
        //           style: TextStyle(
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.blueGrey
        //           ),
        //         ),
        //         backgroundColor: Colors.white,
        //       ),
        //       SizedBox(
        //         width: 20,
        //       ),
        //       Chip(
        //         label: Text(
        //           UtilPref.customer['name'] ?? "",
        //           maxLines: 1,
        //           overflow: TextOverflow.ellipsis,
        //           style: TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.blueGrey
        //           ),
        //         ),
        //         backgroundColor: Colors.white,
        //         avatar: Icon(
        //           Icons.account_circle_rounded,
        //           color: Colors.green[300],
        //         ),
        //       ),
        //     ],
        //   ),
        //   iconColor: Colors.brown,
        //   textColor: Colors.brown,
        //   collapsedBackgroundColor: Colors.grey[100],
        //   backgroundColor: Colors.grey[300],
        //   title: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 8),
        //     child: Text(
        //       "Order Options".toUpperCase(),
        //       style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold),
        //     ),
        //   ),
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Colors.grey,
        //             child: Icon(
        //               Icons.groups_sharp,
        //               color: Colors.white,
        //               size: 32,
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //             child: Text(
        //               "PAX COUNT",
        //               style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         animdo.ElasticInDown(
        //           child: MaterialButton(
        //               color: Colors.white,
        //               child: Icon(
        //                 Icons.add_circle,
        //                 color: Colors.cyan[300],
        //                 size: 32,
        //               ),
        //               onPressed: () {
        //                 UtilPref.paxSet(value: (UtilPref.pax.value + 1));
        //               }),
        //         ),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         animdo.ElasticInDown(
        //           child: MaterialButton(
        //               color: Colors.white,
        //               child: Icon(
        //                 Icons.remove_circle,
        //                 size: 32,
        //                 color: Colors.cyan[300],
        //               ),
        //               onPressed: () {
        //                 if (UtilPref.pax.value > 1) {
        //                   UtilPref.paxSet(value: (UtilPref.pax.value - 1));
        //                 }
        //               }),
        //         )
        //       ],
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     animdo.ZoomIn(
        //       child: Card(
        //         elevation: 0,
        //         color: Colors.white,
        //         child: ListTile(
        //           leading: Icon(
        //             Icons.account_circle_sharp,
        //             color: Colors.green,
        //           ),
        //           title: Text(
        //             UtilPref.customer['name'] ?? "Select Customer",
        //             style: TextStyle(color: Colors.green),
        //           ),
        //           onTap: () {
        //             // dialog search and select customer
        //             final search = "".obs;
        //             final listCustomer = List.from(UtilPref.listCustomer).obs;
        //             Get.dialog(
        //               Dialog(
        //                 child: Column(
        //                   children: [
        //                     Row(
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: CircleAvatar(
        //                               backgroundColor: Colors.orange,
        //                               child: BackButton(
        //                                 color: Colors.white,
        //                               )),
        //                         ),
        //                         Expanded(
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Text("Select Customer"),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: CircleAvatar(
        //                             backgroundColor: Colors.red[300],
        //                             child: IconButton(
        //                                 onPressed: () {
        //                                   UtilPref.customerSet(value: {});
        //                                   Get.back();
        //                                 },
        //                                 icon: Icon(
        //                                   Icons.delete,
        //                                   color: Colors.white,
        //                                 )),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: TextFormField(
        //                         onChanged: (value) {
        //                           listCustomer.assignAll(List.from(UtilPref.listCustomer).where((element) =>
        //                               element['name'].toString().toLowerCase().contains(value.toLowerCase())));
        //                         },
        //                         controller: TextEditingController(),
        //                         decoration: InputDecoration(
        //                             border: OutlineInputBorder(),
        //                             fillColor: Colors.grey[100],
        //                             filled: true,
        //                             hintText: "eg: gunawan",
        //                             prefixIcon: Icon(Icons.search)),
        //                       ),
        //                     ),
        //                     Flexible(
        //                       child: Obx(
        //                         () => GridView.extent(
        //                           childAspectRatio: 12 / 8,
        //                           maxCrossAxisExtent: Get.width * 0.2,
        //                           children: [
        //                             for (final cus in listCustomer)
        //                               InkWell(
        //                                 onTap: () {
        //                                   UtilPref.customerSet(value: cus);
        //                                   Get.back();
        //                                 },
        //                                 child: Card(
        //                                   color: Colors.green[100],
        //                                   child: Column(
        //                                     children: [
        //                                       Flexible(
        //                                         child: Center(
        //                                           child: Icon(
        //                                             Icons.account_circle,
        //                                             size: 70,
        //                                             color: Colors.green,
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Padding(
        //                                         padding: const EdgeInsets.all(8.0),
        //                                         child: Column(
        //                                           children: [
        //                                             Text(
        //                                               cus['name'].toString(),
        //                                               style: TextStyle(
        //                                                 fontSize: 16,
        //                                                 color: Colors.brown,
        //                                                 fontWeight: FontWeight.bold,
        //                                               ),
        //                                             ),
        //                                             Text(cus['phone'].toString()),
        //                                           ],
        //                                         ),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               )
        //                           ],
        //                         ),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //           trailing: Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.green),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  dialogSelectCustomer() async {
    // dialog search and select customer
    //final search = "".obs;
    final listCustomer = List.from(UtilPref.customers).obs;
    Get.dialog(
      Dialog(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: BackButton(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select Customer"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                          onPressed: () {
                            UtilPref.customerSet(value: {});
                            Get.back();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[300],
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    listCustomer.assignAll(List.from(UtilPref.customers)
                        .where((element) => element['name'].toString().toLowerCase().contains(value.toLowerCase())));
                  },
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: "eg: gunawan",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              Flexible(
                child: Obx(
                  () => GridView.extent(
                    childAspectRatio: 12 / 8,
                    maxCrossAxisExtent: Get.width / (sizingInformation.isMobile ? 2 : 6),
                    children: [
                      for (final cus in listCustomer)
                        InkWell(
                          onTap: () {
                            UtilPref.customerSet(value: cus);
                            Get.back();
                          },
                          child: Card(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                Flexible(
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        cus['phone'].toString(),
                                        style: TextStyle(color: Colors.white),
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
        ),
      ),
    );
  }

  dialogPax() async {
    Get.dialog(
      Dialog(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => SizedBox(
            width: sizingInformation.isMobile ? Get.width - 80 : Get.width * 0.3,
            height: sizingInformation.isMobile ? Get.width - 80 : Get.width * 0.4,
            child: Column(
              children: [
                Flexible(
                  child: CompCalculator(
                    defaultValue: UtilPref.pax.value.toString(),
                    onChange: (p0) => UtilPref.paxSet(
                      value: int.parse(
                        p0.toString(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
