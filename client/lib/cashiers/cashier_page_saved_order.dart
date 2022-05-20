import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as anido;
import '../utils/util_pref.dart';

class CashierPageSavedOrder extends StatelessWidget {
  const CashierPageSavedOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => UtilPref.listSaveOrder.isEmpty
            ? Container()
            : InkWell(
                child: Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      UtilPref.listSaveOrder.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  label: Text(
                    "Saved Order",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  Get.dialog(
                    Dialog(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: BackButton(
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    "Saved Order",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Obx(
                              () => GridView.extent(
                                controller: ScrollController(),
                                physics: BouncingScrollPhysics(),
                                maxCrossAxisExtent: Get.width * 0.2,
                                children: [
                                  for (final item in UtilPref.listSaveOrder)
                                    InkWell(
                                      onTap: () {
                                        UtilPref.paxSet(value: item['pax']);
                                        UtilPref.customerSet(value: Map.from(item['customer']));
                                        UtilPref.listorderSet(value: List.from(item['order']));

                                        // final data = {
                                        //   "id": Uuid().v4(),
                                        //   "name": nameSaveOrder.value,
                                        //   "order": List.from(UtilPref.listorder),
                                        //   "pax": UtilPref.pax.value,
                                        //   "customer": Map.from(UtilPref.customer),
                                        //   "date": DateTime.now().toString()
                                        // };

                                        UtilPref.savedOrderSet(value: {
                                          'date': item['date'],
                                          'name': item['name'],
                                          'id': item['id'],
                                          'pax': item['pax'],
                                          'customer': Map.from(item['customer']),
                                          'order': List.from(item['order'])
                                        });

                                        Get.back();
                                      },
                                      child: anido.ElasticIn(
                                        duration: Duration(milliseconds: Random().nextInt(600) + 500),
                                        child: Card(
                                          color: Colors.grey[100],
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Center(
                                                  child: Icon(
                                                    Icons.sd_storage_rounded,
                                                    size: 150,
                                                    color: Colors.cyan[100],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          UtilPref.listSaveOrder.remove(item);
                                                          UtilPref.listSaveOrderSet(
                                                            value: List.from(UtilPref.listSaveOrder),
                                                          );
                                                          if (UtilPref.listSaveOrder.isEmpty) {
                                                            UtilPref.savedOrderSet(value: {});
                                                            Get.back();
                                                          }
                                                        },
                                                        icon: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.red[200],
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white54,
                                                    padding: EdgeInsets.all(4),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.numbers),
                                                            Expanded(
                                                              child: Text(
                                                                item['id'].toString(),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.title),
                                                            Text(
                                                              item['name'].toString(),
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.date_range),
                                                            Text(item['date'].toString().split(' ')[0]),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.av_timer_outlined),
                                                            Text(
                                                              item['date']
                                                                  .toString()
                                                                  .split(' ')[1]
                                                                  .toString()
                                                                  .split('.')[0]
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
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
                },
              )
        // MaterialButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(32),
        //   ),
        //     color: Colors.green,
        //     onPressed: () {
        //       // UtilPref.listorderSet(value: []);
        //       // show dialog saved order
        //       Get.dialog(
        //         Dialog(
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Row(
        //                   children: [
        //                     CircleAvatar(
        //                         backgroundColor: Colors.orange,
        //                         child: BackButton(
        //                           color: Colors.white,
        //                         )),
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //                       child: Text(
        //                         "Saved Order",
        //                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Flexible(
        //                 child: Obx(
        //                   () => GridView.extent(
        //                     controller: ScrollController(),
        //                     physics: BouncingScrollPhysics(),
        //                     maxCrossAxisExtent: Get.width * 0.2,
        //                     children: [
        //                       for (final item in UtilPref.listSaveOrder)
        //                         InkWell(
        //                           onTap: () {
        //                             UtilPref.paxSet(value: item['pax']);
        //                             UtilPref.customerSet(value: Map.from(item['customer']));
        //                             UtilPref.listorderSet(value: List.from(item['order']));

        //                             // final data = {
        //                             //   "id": Uuid().v4(),
        //                             //   "name": nameSaveOrder.value,
        //                             //   "order": List.from(UtilPref.listorder),
        //                             //   "pax": UtilPref.pax.value,
        //                             //   "customer": Map.from(UtilPref.customer),
        //                             //   "date": DateTime.now().toString()
        //                             // };

        //                             UtilPref.savedOrderSet(value: {
        //                               'date': item['date'],
        //                               'name': item['name'],
        //                               'id': item['id'],
        //                               'pax': item['pax'],
        //                               'customer': Map.from(item['customer']),
        //                               'order': List.from(item['order'])
        //                             });

        //                             Get.back();
        //                           },
        //                           child: anido.ElasticIn(
        //                             duration: Duration(milliseconds: Random().nextInt(600) + 500),
        //                             child: Card(
        //                               color: Colors.grey[100],
        //                               child: Stack(
        //                                 children: [
        //                                   Center(
        //                                     child: Center(
        //                                       child: Icon(
        //                                         Icons.sd_storage_rounded,
        //                                         size: 150,
        //                                         color: Colors.cyan[100],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Column(
        //                                     crossAxisAlignment: CrossAxisAlignment.start,
        //                                     children: [
        //                                       Flexible(
        //                                         child: Align(
        //                                           alignment: Alignment.topRight,
        //                                           child: IconButton(
        //                                             onPressed: () {
        //                                               UtilPref.listSaveOrder.remove(item);
        //                                               UtilPref.listSaveOrderSet(
        //                                                 value: List.from(UtilPref.listSaveOrder),
        //                                               );
        //                                               if (UtilPref.listSaveOrder.isEmpty) {
        //                                                 UtilPref.savedOrderSet(value: {});
        //                                                 Get.back();
        //                                               }
        //                                             },
        //                                             icon: CircleAvatar(
        //                                                 backgroundColor: Colors.white,
        //                                                 child: Icon(
        //                                                   Icons.delete,
        //                                                   color: Colors.red[200],
        //                                                 )),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Container(
        //                                         color: Colors.white54,
        //                                         padding: EdgeInsets.all(4),
        //                                         child: Column(
        //                                           crossAxisAlignment: CrossAxisAlignment.start,
        //                                           children: [
        //                                             Row(
        //                                               children: [
        //                                                 Icon(Icons.numbers),
        //                                                 Expanded(
        //                                                   child: Text(
        //                                                     item['id'].toString(),
        //                                                     overflow: TextOverflow.ellipsis,
        //                                                     maxLines: 1,
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 Icon(Icons.title),
        //                                                 Text(
        //                                                   item['name'].toString(),
        //                                                   maxLines: 1,
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 Icon(Icons.date_range),
        //                                                 Text(item['date'].toString().split(' ')[0]),
        //                                               ],
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 Icon(Icons.av_timer_outlined),
        //                                                 Text(
        //                                                   item['date']
        //                                                       .toString()
        //                                                       .split(' ')[1]
        //                                                       .toString()
        //                                                       .split('.')[0]
        //                                                       .toString(),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                           ],
        //                                         ),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10),
        //           child: Text(
        //             "Saved Order",
        //             style: TextStyle(
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //         CircleAvatar(
        //           backgroundColor: Colors.white,
        //           radius: 14,
        //           child: Text(UtilPref.listSaveOrder.length.toString(), style: TextStyle(color: Colors.green),),
        //         )
        //       ],
        //     ),
        //   ),
        );
  }
}
