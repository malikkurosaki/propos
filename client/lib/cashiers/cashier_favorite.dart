import 'dart:math';
import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_value.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierFavorite extends StatelessWidget {
  const CashierFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                      builder: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CompAppBar(title: "Favorite",),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: const [
                          //       CircleAvatar(
                          //           backgroundColor: Colors.orange,
                          //           child: BackButton(
                          //             color: Colors.white,
                          //           )),
                          //       Padding(
                          //         padding: EdgeInsets.symmetric(horizontal: 8),
                          //         child:
                          //             Text("Favorite", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Flexible(
                            child: Obx(
                              () => GridView.extent(
                                controller: ScrollController(),
                                maxCrossAxisExtent: Get.width * 0.19,
                                childAspectRatio: 12 / 8,
                                children: [
                                  ...UtilValue.listFavorite.map(
                                    (e) {
                                      return InkWell(
                                        // add to order list
                                        onTap: () {
                                          final itm = e;
                                          final idx = GVal.listOrders.value.val
                                              .indexWhere((element) => element['name'] == itm['name']);
                                          if (idx == -1) {
                                            itm['qty'] = 1;
                                            itm['note'] = "";
                                            GVal.listOrders.value.val.add(itm);
                                          } else {
                                            GVal.listOrders.value.val[idx]['qty'] =
                                                GVal.listOrders.value.val[idx]['qty'] + 1;
                                          }

                                          UtilValue.lastClick.value = e;
                                          GVal.listOrders.value.val = List.from(GVal.listOrders.value.val);
                                          GVal.listOrders.refresh();

                                          Get.back();
                                        },
                                        child: anido.ElasticIn(
                                          duration: Duration(milliseconds: Random().nextInt(600) + 500),
                                          child: Card(
                                            // set randome color
                                            color: Color.fromARGB(
                                              255,
                                              Random().nextInt(255),
                                              Random().nextInt(255),
                                              Random().nextInt(255),
                                            ).withOpacity(0.4),
                                            child: Stack(
                                              children: [
                                                const Center(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 100,
                                                    color: Colors.white30,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Flexible(
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            UtilValue.listFavorite.remove(e);
                                                            UtilValue.listFavoriteSet(
                                                                value: UtilValue.listFavorite.toList());
                                                          },
                                                          icon: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.red[200],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      color: Colors.white54,
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        e['name'].toString(),
                                                        maxLines: 2,
                                                        style: const TextStyle(color: Colors.brown),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      onClosing: () {},
                    ),
                  );

                  // dialog list favorite and order list item
                  // Get.dialog(
                  //   Dialog(
                  //     child:
                  //     SizedBox(
                  //       height: Get.height * 0.8,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Row(
                  //               children: const [
                  //                 CircleAvatar(
                  //                     backgroundColor: Colors.orange,
                  //                     child: BackButton(
                  //                       color: Colors.white,
                  //                     )),
                  //                 Padding(
                  //                   padding: EdgeInsets.symmetric(horizontal: 8),
                  //                   child:
                  //                       Text("Favorite", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Flexible(
                  //             child: Obx(
                  //               () => GridView.extent(
                  //                 maxCrossAxisExtent: Get.width * 0.19,
                  //                 childAspectRatio: 12 / 8,
                  //                 children: [
                  //                   ...UtilValue.listFavorite.map(
                  //                     (e) {
                  //                       return InkWell(
                  //                         // add to order list
                  //                         onTap: () {
                  //                           final itm = e;
                  //                           final idx = GVal.listOrders.value.val
                  //                               .indexWhere((element) => element['name'] == itm['name']);
                  //                           if (idx == -1) {
                  //                             itm['qty'] = 1;
                  //                             itm['note'] = "";
                  //                             GVal.listOrders.value.val.add(itm);
                  //                           } else {
                  //                             GVal.listOrders.value.val[idx]['qty'] = GVal.listOrders.value.val[idx]['qty'] + 1;
                  //                           }

                  //                           UtilValue.lastClick.value = e;
                  //                           GVal.listOrders.value.val =  List.from(GVal.listOrders.value.val);
                  //                           GVal.listOrders.refresh();

                  //                           Get.back();
                  //                         },
                  //                         child: anido.ElasticIn(
                  //                           duration: Duration(milliseconds: Random().nextInt(600) + 500),
                  //                           child: Card(
                  //                             // set randome color
                  //                             color: Color.fromARGB(
                  //                               255,
                  //                               Random().nextInt(255),
                  //                               Random().nextInt(255),
                  //                               Random().nextInt(255),
                  //                             ).withOpacity(0.4),
                  //                             child: Stack(
                  //                               children: [
                  //                                 const Center(
                  //                                   child: Icon(
                  //                                     Icons.favorite,
                  //                                     size: 100,
                  //                                     color: Colors.white30,
                  //                                   ),
                  //                                 ),
                  //                                 Column(
                  //                                   children: [
                  //                                     Flexible(
                  //                                       child: Align(
                  //                                         alignment: Alignment.topRight,
                  //                                         child: IconButton(
                  //                                           onPressed: () {
                  //                                             UtilValue.listFavorite.remove(e);
                  //                                             UtilValue.listFavoriteSet(
                  //                                                 value: UtilValue.listFavorite.toList());
                  //                                           },
                  //                                           icon: CircleAvatar(
                  //                                             backgroundColor: Colors.white,
                  //                                             child: Icon(
                  //                                               Icons.delete,
                  //                                               color: Colors.red[200],
                  //                                             ),
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                     Container(
                  //                                       width: double.infinity,
                  //                                       color: Colors.white54,
                  //                                       padding: const EdgeInsets.all(8.0),
                  //                                       child: Text(
                  //                                         e['name'].toString(),
                  //                                         maxLines: 2,
                  //                                         style: const TextStyle(color: Colors.brown),
                  //                                       ),
                  //                                     )
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                   ).toList(),
                  //                 ],
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
              ),
            ),
            // badge fvorite length
            Positioned(
              top: 0,
              right: 0,
              child: Visibility(
                visible: UtilValue.listFavorite.isNotEmpty,
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 24,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: UtilValue.showFavorite.value ? Colors.blueGrey : Colors.pink,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    UtilValue.listFavorite.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
