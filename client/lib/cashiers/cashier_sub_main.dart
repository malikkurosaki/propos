import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/cashiers/cashier_favorite.dart';
import 'package:client/cashiers/cashier_search.dart';
import 'package:client/cashiers/cashier_sub_main_item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';

class CashierSubMain extends GetWidget {
  const CashierSubMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Card(
            color: Colors.grey[50],
            child: SizedBox(
              width: double.infinity,
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
                            UtilPref.aspekSet(value: 10 / 18);
                          } else {
                            UtilPref.aspekSet(value: 10 / 6);
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
                  const CashierFavorite(),
                  CashierSearch()
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: SizedBox(
            height: double.infinity,
            child: CashierSubMainItemMenu(),
          ),
        ),
      ],
    );
  }
}
