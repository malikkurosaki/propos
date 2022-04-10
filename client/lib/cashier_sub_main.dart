import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'util_pref.dart';

class CashierSubMain extends StatelessWidget {
  CashierSubMain({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  // final showFavorite = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        UtilPref.searchSet(value.toLowerCase());
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        fillColor: Colors.cyan[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.white)),
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
              ),
            ],
          ),
          Container(
            height: Get.height * 0.8,
            padding: const EdgeInsets.all(14),
            child: ListView(
              controller: ScrollController(),
              key: const Key("list"),
              physics: const BouncingScrollPhysics(),
              children: [
                for (var item in UtilPref.listMenu)
                  Column(
                    key: Key(item["category"]),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item["category"].toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[300],
                          ),
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          for (var item2 in item["data"])
                            Visibility(
                              visible: UtilPref.search.value == ""
                                  ? true
                                  : item2["title"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(UtilPref.search.value.toLowerCase()),
                              child: Visibility(
                                visible: !UtilPref.showFavorite.value? true :UtilPref.listFavorite.map((element) => element['title']).contains(item2["title"]),
                                child: Card(
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
                                        final idx = UtilPref.listorder
                                            .indexWhere((element) => element['title'] == itm['title']);
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
                                                  height: 200,
                                                  width: 200,
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
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.brown),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // favorite button
                                          Positioned(
                                              child: CircleAvatar(
                                            backgroundColor: Colors.white,
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
                                                )),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
