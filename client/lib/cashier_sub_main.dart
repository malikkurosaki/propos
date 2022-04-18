import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/chasier_sub_main_item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'util_pref.dart';

class CashierSubMain extends GetWidget {
  CashierSubMain({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: ListTile(
        //         title: Card(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(100),
        //           ),
        //           child: TextFormField(
        //             controller: searchController,
        //             onChanged: (value) {
        //               UtilPref.searchSet(value.toLowerCase());
        //             },
        //             decoration: InputDecoration(
        //               prefixIcon: Icon(Icons.search),
        //               labelText: "Search",
        //               fillColor: Colors.cyan[50],
        //               filled: true,
        //               enabledBorder: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.white)),
        //               border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.white)),
        //               suffixIcon: IconButton(
        //                 icon: Icon(Icons.close),
        //                 onPressed: () {
        //                   searchController.clear();
        //                   UtilPref.searchSet("");
        //                 },
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Flexible(
          child: Container(
            height: Get.height * 0.8,
            padding: const EdgeInsets.all(14),
            child: CashierSubMainItemMenu(),
          ),
        ),
        Obx(
          () => Container(
            width: double.infinity,
            color: Colors.brown[100],
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        UtilPref.isGridSet(!(UtilPref.isGrid.value == "true"));
                        if (UtilPref.isGrid.value == "true") {
                          UtilPref.aspekSet(10 / 16);
                        } else {
                          UtilPref.aspekSet(10 / 4);
                        }
                      },
                      icon: UtilPref.isGrid.value == "true"
                          ? Icon(
                              Icons.format_list_bulleted_outlined,
                              color: Colors.cyan,
                            )
                          : Icon(
                              Icons.grid_view_outlined,
                              color: Colors.orange,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            if (UtilPref.listorder.isNotEmpty) {
                              UtilPref.showFavoriteSet(!UtilPref.showFavorite.value);
                            } else {
                              EasyLoading.showToast("Your favorite is empty");
                            }
                          },
                          icon: Icon(
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
                          visible: UtilPref.listFavorite.isNotEmpty,
                          child: Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 24,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: UtilPref.showFavorite.value ? Colors.blueGrey : Colors.pink,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              UtilPref.listFavorite.length.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          final listTempSearch = [].obs;
                          searchController.clear();
                          // search dialog
                          Get.dialog(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                    radius: 24,
                                                    backgroundColor: Colors.grey[200],
                                                    child: BackButton()),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      controller: searchController,
                                                      onChanged: (value) {
                                                        listTempSearch.assignAll(UtilPref.listMenu
                                                            .where((p0) => p0['title'].toLowerCase().contains(value.toLowerCase())));
                                                      },
                                                      decoration: InputDecoration(
                                                        prefixIcon: Icon(Icons.search),
                                                        labelText: "Search",
                                                        fillColor: Colors.grey[100],
                                                        filled: true,
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(28),
                                                            borderSide: BorderSide(color: Colors.white)),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(28),
                                                            borderSide: BorderSide(color: Colors.white)),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.close),
                                                          onPressed: () {
                                                            searchController.clear();
                                                            UtilPref.searchSet("");
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Flexible(
                                      child: Obx(
                                        () => listTempSearch.isEmpty
                                            ? SizedBox.shrink()
                                            : Card(
                                              child: ListView.builder(
                                                  itemCount: listTempSearch.length,
                                                  itemBuilder: (context, index) {
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(listTempSearch[index]['title']),
                                                          onTap: () {
                                                            final itm = listTempSearch[index];
                                                            final idx = UtilPref.listorder
                                                                .indexWhere((element) => element['title'] == itm['title']);
                                                            if (idx == -1) {
                                                              itm['qty'] = 1;
                                                              itm['note'] = "";
                                                              UtilPref.listorder.add(itm);
                                                            } else {
                                                              UtilPref.listorder[idx]['qty'] =
                                                                  UtilPref.listorder[idx]['qty'] + 1;
                                                            }
                                            
                                                            UtilPref.lastClick.value = itm;
                                                            UtilPref.listorderSet(List.from(UtilPref.listorder));
                                                            searchController.clear();
                                                            Get.back();
                                                          },
                                                        ),
                                                        Divider()
                                                      ],
                                                    );
                                                  },
                                                ),
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.search)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
