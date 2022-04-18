import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/util_conn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:sticky_grid_view/sticky_grid_view.dart';
import 'util_pref.dart';

class CashierSubMainItemMenu extends StatelessWidget {
  CashierSubMainItemMenu({Key? key}) : super(key: key);
  final categoryText = "".obs;

  final bisa = true.obs;
  final ls = List.generate(20, (index) => index).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Obx(
            () => UtilPref.listMenu.isEmpty? Text("..."): GridView.count(
              crossAxisCount: 3,
              childAspectRatio: UtilPref.aspek.value,
              children:  [
                for(final item2 in UtilPref.listMenu)
                Card(
                    elevation: UtilPref.listorder
                            .map((element) => element['title'].toString())
                            .toList()
                            .contains(item2["title"].toString())
                        ? UtilPref.lastClick['title'] == item2["title"].toString()
                            ? 4
                            : 0
                        : 0,
                    color: UtilPref.listorder
                            .map((element) => element['title'].toString())
                            .toList()
                            .contains(item2["title"].toString())
                        ? UtilPref.lastClick['title'] == item2["title"].toString()
                            ? Colors.cyan[100]
                            : Colors.pink[50]
                        : Colors.white,
                    child: SizedBox(
                      width: 200,
                      height: UtilPref.isGrid.value == "true" ? 290 : 60,
                      child: InkWell(
                        onTap: () {
                          final itm = item2;
                          final idx = UtilPref.listorder.indexWhere((element) => element['title'] == itm['title']);
                          if (idx == -1) {
                            itm['qty'] = 1;
                            itm['note'] = "";
                            UtilPref.listorder.add(itm);
                          } else {
                            UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
                          }

                          UtilPref.lastClick.value = item2;
                          UtilPref.listorderSet(List.from(UtilPref.listorder));
                        },
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: UtilPref.isGrid.value == "true",
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      errorWidget: (a, b, c) => Icon(Icons.hide_image_outlined),
                                      imageUrl: item2["image"],
                                      placeholder: (con, str) => Icon(Icons.image_search_rounded),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item2["title"].toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      // color: UtilPref.listorder
                                      //         .map((element) => element['title'].toString())
                                      //         .toList()
                                      //         .contains(item2["title"].toString())
                                      //     ? UtilPref.lastClick['title'] == item2["title"].toString()
                                      //         ? Colors.white
                                      //         : Colors.black
                                      //     : Colors.black,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: UtilPref.isGrid.value == "true",
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Rp. " + item2["price"].toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // favorite button
                            Positioned(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Tooltip(
                                  message: "add favorite",
                                  child: IconButton(
                                    onPressed: () {
                                      final index = UtilPref.listFavorite
                                          .map((element) => element['title'].toString())
                                          .toList()
                                          .indexOf(item2["title"].toString());

                                      if (index == -1) {
                                        UtilPref.listFavorite.add(item2);
                                        EasyLoading.showToast("Added to favorite ${item2['title']}");
                                      } else {
                                        UtilPref.listFavorite.removeAt(index);
                                        EasyLoading.showToast("Removed from favorite ${item2['title']}");
                                      }

                                      // save to list favorite
                                      UtilPref.listFavoriteSet(List.from(UtilPref.listFavorite));
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: UtilPref.listFavorite
                                              .map((element) => element['title'])
                                              .toList()
                                              .contains(item2['title'])
                                          ? Colors.pink[300]
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ]
              ,
            ),
          ),
        ),
      ],
    );
  }
}
