import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_comp.dart';
import 'package:client/utils/util_conn.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sticky_grid_view/sticky_grid_view.dart';
import '../utils/util_value.dart';

class CashierSubMainItemMenu extends StatelessWidget {
  CashierSubMainItemMenu({Key? key}) : super(key: key);
  final categoryText = "".obs;

  final bisa = true.obs;
  // final ls = List.generate(20, (index) => index).toList();

  _addItem(SizingInformation sizingInformation, dynamic item2) {
    final itm = item2;
    final idx = GVal.listOrders.value.val.indexWhere((element) => element["id"] == itm["id"]);
    if (idx == -1) {
      itm['qty'] = 1;
      itm['note'] = "";
      GVal.listOrders.value.val.add(itm);
    } else {
      GVal.listOrders.value.val[idx]['qty'] = GVal.listOrders.value.val[idx]['qty'] + 1;
    }

    UtilValue.lastClick.value = item2;
    GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
    GVal.listOrders.refresh();
    if (sizingInformation.isMobile) {
      Get.back();
    }

    // final index = UtilPref.listorder.indexWhere((element) => element["id"] == itm["id"]);
    // final top = UtilPref.listorder.removeAt(index);
    // UtilPref.listorder.add(top);

    // UtilVal.listOrderController.jumpTo(
    //   UtilVal.listOrderController.position.maxScrollExtent,
    // );
  }

  _addFavorite(Map<String, dynamic> item2) {
    final index =
        UtilValue.listFavorite.map((element) => element["id"].toString()).toList().indexOf(item2["id"].toString());

    if (index == -1) {
      UtilValue.listFavorite.add(item2);
      EasyLoading.showToast("Added to favorite ${item2["name"]}", toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      UtilValue.listFavorite.removeAt(index);
      EasyLoading.showToast("Removed from favorite ${item2["name"]}", toastPosition: EasyLoadingToastPosition.bottom);
    }

    // save to list favorite
    UtilValue.listFavoriteSet();
  }

  

  @override
  Widget build(BuildContext context) {
    const lebar = 150.0;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: [
          // Text(sizingInformation.deviceScreenType.toString()),
          Flexible(
            child: Obx(
              () => GVal.products.value.val.isEmpty
                  ? Center(child: Image.asset("assets/images/empty.png", width: 100, height: 100,),)
                  : Container(
                    alignment: Alignment.topCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      // decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 2,
                          runSpacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.start,
                          // alignment: WrapAlignment.start,
                          // crossAxisSpacing: 2,
                          // mainAxisSpacing: 2,
                          // addAutomaticKeepAlives: true,
                          // physics: BouncingScrollPhysics(),
                          // controller: ScrollController(),
                          children: [
                            for (final product in GVal.products.value.val)
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                                width: lebar,
                                height: 255,
                                child: InkWell(
                                  onTap: () => _addItem(sizingInformation, product),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        height: lebar,
                                        width: lebar,
                                        fit: BoxFit.cover,
                                        imageUrl: UtilComp().gambar(product),
                                        placeholder: (a, b) => Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 0.5,
                                              
                                            ),
                                          ),
                                        ),
                                        errorWidget: (a, b, c) => Icon(Icons.error),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 34,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                product['name'].toString(),
                                                style: const TextStyle(fontSize: 12),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          // Text(
                                          //   product['description'].toString(),
                                          //   maxLines: 2,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                                          // ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.all_inbox_sharp,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  (product['Stocks']?['quantity'] ?? 0).toString(),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                      const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        color: Colors.blue,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  NumberFormat("#,###", "id_ID").format(product['price']),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => _addFavorite(product),
                                              child: Icon(
                                                Icons.favorite,
                                                color: UtilValue.listFavorite
                                                        .map((element) => element["id"])
                                                        .toList()
                                                        .contains(product["id"])
                                                    ? Colors.pink[200]
                                                    : Colors.blue[100],
                                              ),
                                            )
                                            
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            // for (final item2 in UtilPref.listMenu)
                            //   Card(
                            //     child: SizedBox(
                            //       width: 200,
                            //       height: UtilPref.isGrid.value == "true" ? 290 : 60,
                            //       child: InkWell(
                            //         onTap: () {
                            //           final itm = item2;
                            //           final idx =
                            //               UtilPref.listorder.indexWhere((element) => element["id"] == itm["id"]);
                            //           if (idx == -1) {
                            //             itm['qty'] = 1;
                            //             itm['note'] = "";
                            //             UtilPref.listorder.add(itm);
                            //           } else {
                            //             UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
                            //           }

                            //           UtilPref.lastClick.value = item2;
                            //           UtilPref.listorderSet(value: List.from(UtilPref.listorder));
                            //           if (sizingInformation.isMobile) {
                            //             Get.back();
                            //           }

                            //           // jusmp to bottom
                            //           UtilVal.listOrderController.jumpTo(
                            //             UtilVal.listOrderController.position.maxScrollExtent + 200,
                            //           );
                            //         },
                            //         child: Stack(
                            //           children: [
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Visibility(
                            //                   visible: UtilPref.isGrid.value == "true",
                            //                   child: SizedBox(
                            //                     width: double.infinity,
                            //                     child: CachedNetworkImage(
                            //                       cacheKey: Key(item2['image']).toString(),
                            //                       fit: BoxFit.cover,
                            //                       errorWidget: (a, b, c) => Icon(Icons.hide_image_outlined),
                            //                       imageUrl: item2["image"],
                            //                       placeholder: (con, str) => Icon(Icons.image_search_rounded),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Container(
                            //                   height: 50,
                            //                   padding: const EdgeInsets.all(8.0),
                            //                   child: Text(
                            //                     item2["title"].toString(),
                            //                     maxLines: 2,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey
                            //                         // color: UtilPref.listorder
                            //                         //         .map((element) => element["id"].toString())
                            //                         //         .toList()
                            //                         //         .contains(item2["title"].toString())
                            //                         //     ? UtilPref.lastClick["id"] == item2["title"].toString()
                            //                         //         ? Colors.white
                            //                         //         : Colors.black
                            //                         //     : Colors.black,
                            //                         ),
                            //                   ),
                            //                 ),
                            //                 Visibility(
                            //                   visible: UtilPref.isGrid.value == "true",
                            //                   child: Chip(
                            //                     label: Text(
                            //                       "Rp. " + item2["price"].toString(),
                            //                       maxLines: 1,
                            //                       overflow: TextOverflow.ellipsis,
                            //                       style: TextStyle(
                            //                         fontSize: 18,
                            //                         fontWeight: FontWeight.bold,
                            //                         color: Colors.blueGrey,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             // favorite button
                            //             Visibility(
                            //               visible: UtilPref.isGrid.value == "true",
                            //               child: Positioned(
                            //                 child: CircleAvatar(
                            //                   backgroundColor: Colors.white,
                            //                   child: Tooltip(
                            //                     message: "add favorite",
                            //                     child: IconButton(
                            //                       onPressed: () {
                            //                         final index = UtilPref.listFavorite
                            //                             .map((element) => element["id"].toString())
                            //                             .toList()
                            //                             .indexOf(item2["title"].toString());

                            //                         if (index == -1) {
                            //                           UtilPref.listFavorite.add(item2);
                            //                           EasyLoading.showToast("Added to favorite ${item2["id"]}");
                            //                         } else {
                            //                           UtilPref.listFavorite.removeAt(index);
                            //                           EasyLoading.showToast("Removed from favorite ${item2["id"]}");
                            //                         }

                            //                         // save to list favorite
                            //                         UtilPref.listFavoriteSet();
                            //                       },
                            //                       icon: Icon(
                            //                         Icons.favorite,
                            //                         color: UtilPref.listFavorite
                            //                                 .map((element) => element["id"])
                            //                                 .toList()
                            //                                 .contains(item2["id"])
                            //                             ? Colors.pink[300]
                            //                             : Colors.grey,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
