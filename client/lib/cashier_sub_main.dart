import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/cashier_sub_main_favorite.dart';
import 'package:client/cashier_sub_main_search.dart';
import 'package:client/chasier_sub_main_item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'util_pref.dart';

class CashierSubMain extends GetWidget {
  CashierSubMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                        UtilPref.isGridSet(value: !(UtilPref.isGrid.value == "true"));
                        if (UtilPref.isGrid.value == "true") {
                          UtilPref.aspekSet(value: 10 / 16);
                        } else {
                          UtilPref.aspekSet(value: 10 / 4);
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
                CashierSubMainFavorite(),
                CashierSubMainSearch()
              ],
            ),
          ),
        )
      ],
    );
  }
}
