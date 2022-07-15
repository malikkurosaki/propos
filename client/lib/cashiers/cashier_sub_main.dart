import 'package:client/cashiers/cashier_favorite.dart';
import 'package:client/cashiers/cashier_search.dart';
import 'package:client/cashiers/cashier_sub_main_item_menu.dart';
import 'package:client/comps/comp_category_panel.dart';
import 'package:client/utils/g_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../utils/util_value.dart';

class CashierSubMain extends GetWidget {
  const CashierSubMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey[50], border: Border.all(color: Colors.grey.shade300)),
              width: double.infinity,
              child:Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(12),
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: IconButton(
                  //       onPressed: () {
                  //         UtilValue.isGridSet(value: !(UtilValue.isGrid.value == "true"));
                  //         if (UtilValue.isGrid.value == "true") {
                  //           UtilValue.aspekSet(value: 10 / 18);
                  //         } else {
                  //           UtilValue.aspekSet(value: 10 / 6);
                  //         }
                  //       },
                  //       icon: UtilValue.isGrid.value == "true"
                  //           ? const Icon(
                  //               Icons.format_list_bulleted_outlined,
                  //               color: Colors.cyan,
                  //             )
                  //           : const Icon(
                  //               Icons.grid_view_outlined,
                  //               color: Colors.orange,
                  //             ),
                  //     ),
                  //   ),
                  // ),
                  const CashierFavorite(),
                  CashierSearch(
                    value: GVal.products.value.val,
                  ),
                  Flexible(
                    child: CompCategoryHorizontal(
                      onChange: (Map<dynamic, dynamic> value) {
                        GVal.category.value.val = value;
                        _onCategory();
                      },
                      value: GVal.category.value.val,
                    ),
                  )
                ],
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
      ),
    );
  }

  _onCategory() {
    if (GVal.category.value.val['id'] == null) {
      GVal.products.value.val = GVal.productsBackup.value.val;
      GVal.products.refresh();
      return;
    }

    GVal.products.value.val = GVal.productsBackup.value.val.where((item) {
      return item['categoriesId'] == GVal.category.value.val['id'];
    }).toList();

    GVal.products.refresh();
  }
}
