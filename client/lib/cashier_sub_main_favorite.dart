import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

class CashierSubMainFavorite extends StatelessWidget {
  const CashierSubMainFavorite({Key? key}) : super(key: key);

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
                  // if (UtilPref.listorder.isNotEmpty) {
                  //   UtilPref.showFavoriteSet(!UtilPref.showFavorite.value);
                  // } else {
                  //   EasyLoading.showToast("Your favorite is empty");
                  // }

                  // dialog list favorite and order list item
                  Get.dialog(
                    Dialog(
                      child: SizedBox(
                        height: Get.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child:
                                        Text("Favorite", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Obx(
                                () => GridView.extent(
                                  maxCrossAxisExtent: Get.width * 0.19,
                                  childAspectRatio: 12 / 8,
                                  children: [
                                    ...UtilPref.listFavorite.map(
                                      (e) {
                                        return InkWell(
                                          // add to order list
                                          onTap: () {
                                            final itm = e;
                                            final idx = UtilPref.listorder
                                                .indexWhere((element) => element['title'] == itm['title']);
                                            if (idx == -1) {
                                              itm['qty'] = 1;
                                              itm['note'] = "";
                                              UtilPref.listorder.add(itm);
                                            } else {
                                              UtilPref.listorder[idx]['qty'] = UtilPref.listorder[idx]['qty'] + 1;
                                            }

                                            UtilPref.lastClick.value = e;
                                            UtilPref.listorderSet(value: List.from(UtilPref.listorder));
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
                                                  Center(
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
                                                              UtilPref.listFavorite.remove(e);
                                                              UtilPref.listFavoriteSet(
                                                                  value: UtilPref.listFavorite.toList());
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
                                                          e['title'].toString(),
                                                          maxLines: 2,
                                                          style: TextStyle(color: Colors.brown),
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
                      ),
                    ),
                  );
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
    );
  }
}
